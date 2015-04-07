//
//  ZuoxinTaxiInfo.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//        CLLocationDegrees latitude = 22.17102;
//        CLLocationDegrees longitude = 114.16930;
//

#import "ZuoxinTaxiInfo.h"
#import "DriverInfoCell.h"
#import "DPMeterView.h"
#import "DriverBasicInfoAnnotation.h"
#import "DriverDetail.h"
#import "ZuoxinReservation.h"
#import "zuoxin.h"
#import "THTTPClient.h"
#import "TBinaryProtocol.h"
#import "Reachability.h"
#import <QuartzCore/QuartzCore.h>
#import "FlatRoundedImageView.h"
#import "TException.h"
#import "DriverBasicInfoPopView.h"
#import "DriverBasicPopAnnotation.h"
#import "SIAlertView.h"
#import "ZuoxinReservationDetail.h"
 



@interface ZuoxinTaxiInfo () <MKMapViewDelegate>{
    NSMutableArray *_drivers;
    MKCircle *_userCircle;
    CLLocationManager *_locationManager;
    CLLocation *_userLocation;
}

@end

@implementation ZuoxinTaxiInfo

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //set up UI
    [self loadCustomBar];
    [self loadMainView];
    //set up data
    [self registerNetworkNotification];
    
}


#pragma mark - loadCustomBar MainView and Data

- (void)loadCustomBar
{
    self.navTitleLabel.text = @"找人代驾";
    
    self.backBtn.hidden = YES;
    

    self.rightBtn.frame = CGRectMake(310-111/2-10, 0, 111/2+20, 47);
    [self.rightBtn setTitle:@"多人预约" forState:UIControlStateNormal];
    [self.rightBtn setImage:ReservationImage forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(reservationBtn) forControlEvents:UIControlEventTouchUpInside];
    

    UIImageView *navBar = (UIImageView *)[self.view viewWithTag:10001];
    self.customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.customBtn.frame = CGRectMake(0, 0, 62, 47);
    self.customBtn.adjustsImageWhenHighlighted = NO;
    [self.customBtn setImage:ListImage forState:UIControlStateNormal];
    [self.customBtn addTarget:self action:@selector(mapAndListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [navBar addSubview:self.customBtn];
    
    

}

- (void)loadMainView
{
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 47, 320, self.view.frame.size.height-47-47)];
    _taxiInfoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 47, 320, self.view.frame.size.height-47-47) style:UITableViewStylePlain];
    [self loadMapView];
    [self loadTableListView];
}

- (void)loadData
{
    //handle exception

    @try {
    NSMutableArray *driverArr = [[NSMutableArray alloc] initWithCapacity:8];
    driverArr = [self.server finddrivers:_userLocation.coordinate.longitude latitude:_userLocation.coordinate.latitude count:8 distance:8000];
    // if _driverArr throw a exception, it will jump to catch block for exception handling;and for in .. will not be execute!
    _driverArr = driverArr;
    driverArr = nil;
       
    //When load data, remove all annotation and overLay;
    if (_drivers) {
        [_mapView removeAnnotations:_drivers];
        _drivers = nil;
    }
    if (_userCircle) {
        [_mapView removeOverlay:_userCircle];
    }
    
    _drivers = [[NSMutableArray alloc] initWithCapacity:8];
        
    for (NSDictionary *driverDic in _driverArr) {
        
        DriverBasicInfo *driverBasicInfo = [[DriverBasicInfo alloc] init];
        
        //Tips:driverBasicInfo error may cause annotation disappear!
        driverBasicInfo.driverID = [driverDic valueForKey:@"driverid"];
        driverBasicInfo.driverName = [[driverDic valueForKey:@"name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        driverBasicInfo.commentScore = [[driverDic valueForKey:@"score"] intValue];
        driverBasicInfo.driverPhoneNum = [driverDic valueForKey:@"mobile"];
        driverBasicInfo.driverAge = [driverDic valueForKey:@"driveage"];
        driverBasicInfo.driverCount = [driverDic valueForKey:@"drivercount"];
        driverBasicInfo.driverSex = [[driverDic valueForKey:@"sex"] integerValue];
        driverBasicInfo.driverNativePlace = [driverDic valueForKey:@"province"];
        driverBasicInfo.thumbnailData = [driverDic valueForKey:@"picture"];
        driverBasicInfo.pictype = [driverDic valueForKey:@"pictype"];
        driverBasicInfo.driverState = [[driverDic valueForKey:@"state"] intValue];
        CLLocationDegrees longitude = [[driverDic valueForKey:@"longitude"] floatValue];
        CLLocationDegrees latitude = [[driverDic valueForKey:@"latitude"] floatValue];
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        driverBasicInfo.coordinate = coordinate;
        
        [_drivers addObject:[[DriverBasicInfoAnnotation alloc] initWithDriverBasicInfo:driverBasicInfo]];
    }

        //calculate the distance
        if ([_drivers count] != 0) {
            [self calculateDistanceFromUserToAnnotation];
        }
        else
        {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"找不到司机"];
            [self customAlertViewProperty:alertView andBlock:^{
                [alertView dismissAnimated:YES];
            }];
        }
        
        [self performSelectorOnMainThread:@selector(reloadMapviewAndListviewData) withObject:nil waitUntilDone:NO];
        NSLog(@"%s",__FUNCTION__);
        NSLog(@"%d",__LINE__);
        
    }
    //catch the RuntimeError and TTransportException
    @catch (RuntimeError *runtimeError) {
//    NSLog(@"%d,%@",[runtimeError errornumber],[runtimeError errormessage]);
    }
    @catch (TException *texception) {
    NSLog(@"%@",texception);
    }
    @finally {

    }
}

#pragma mark - observe the network condition

-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];

    
    if([reach isReachable])
    {
        //setTaxiInfoMode
        self.taxiInfoMode = TaxiInfoModeMap;
        //start location
        [self settupLocationManager];
        
    }
    else
    {
        self.taxiInfoMode = TaxiInfoModeUnconnected;
    }
}


- (void)reloadMapviewAndListviewData
{
    //load MapView data and TablelistView data
    if (_drivers) {
        if ([_drivers count] != 0) {
            if (_mapView) {
                [_mapView addAnnotations:_drivers];
                if (_userCircle) {
                    [_mapView addOverlay:_userCircle];
                }
            }
            if (_taxiInfoTable) {
                [_taxiInfoTable reloadData];
            }
        }
        else
        {

            MKCoordinateSpan span = MKCoordinateSpanMake(0.111111, 0.11111);
            MKCoordinateRegion region = MKCoordinateRegionMake(_userLocation.coordinate, span);
            [_mapView setRegion:region];
        }
        
    }
}


#pragma mark - TaxiInfoMode

- (void)setTaxiInfoMode:(TaxiInfoMode)taxiInfoMode
{
    _taxiInfoMode = taxiInfoMode;
    for (int i = 1; i <= [[self.view subviews] count]-1; i++) {
        [[[self.view subviews] objectAtIndex:i] removeFromSuperview];
    }
    switch (_taxiInfoMode) {
        case 0:
        {

            [self.view addSubview:_mapView];
            break;
        }
        case 1:
        {

            [self.view addSubview:_taxiInfoTable];

            break;
        }
        case 2:
        {
            [self loadUnconnectedView];
            [self.view addSubview:_unconnectedView];
            break;
        }
    }

}

- (void)loadMapView
{
    _mapView.delegate = self;
    _mapView.scrollEnabled = YES;
    _mapView.zoomEnabled = YES;
    _mapView.showsUserLocation = YES;
//    [self.mapView setUserTrackingMode: MKUserTrackingModeFollow animated: YES];
    
    
    //trackBtn
    
    //User Heading Button states images
    UIImage *buttonImage = [UIImage imageNamed:@"greyButtonHighlight.png"];
    UIImage *buttonImageHighlight = [UIImage imageNamed:@"greyButton.png"];
    UIImage *buttonArrow = [UIImage imageNamed:@"LocationGrey.png"];
    
    //Configure the button
    _trackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_trackBtn addTarget:self action:@selector(startShowingUserHeading:) forControlEvents:UIControlEventTouchUpInside];
    //Add state images
    [_trackBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [_trackBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [_trackBtn setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [_trackBtn setImage:buttonArrow forState:UIControlStateNormal];
    
    //Position and Shadow
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    _trackBtn.frame = CGRectMake(270,screenBounds.size.height-185,39,30);
//    _trackBtn.frame = CGRectMake(5,425,39,30);
    _trackBtn.layer.cornerRadius = 8.0f;
    _trackBtn.layer.masksToBounds = NO;
    _trackBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    _trackBtn.layer.shadowOpacity = 0.8;
    _trackBtn.layer.shadowRadius = 1;
    _trackBtn.layer.shadowOffset = CGSizeMake(0, 1.0f);
    
    [self.mapView addSubview:_trackBtn];
    
    
}

- (void)loadTableListView
{
    _taxiInfoTable.delegate = self;
    _taxiInfoTable.dataSource = self;
    _taxiInfoTable.showsVerticalScrollIndicator = NO;
    _taxiInfoTable.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _taxiInfoTable.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1];
//    _taxiInfoTable.backgroundColor = [UIColor clearColor];

    
    if (_refreshHeaderView == nil) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-_taxiInfoTable.frame.size.height, _taxiInfoTable.frame.size.width, _taxiInfoTable.frame.size.height)];
        _refreshHeaderView.delegate = self;
        [_taxiInfoTable addSubview:_refreshHeaderView];
        
        //1 it will call egoRefreshTableHeaderDataSourceLastUpdated method
        [_refreshHeaderView refreshLastUpdatedDate];
    }

    
}



#pragma mark - MapView

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    
    if ([view conformsToProtocol:@protocol(DriverBasicInfoViewProtocol)]) {
        
        if ([view isKindOfClass:[DriverBasicInfoView class]]) {
            DriverBasicInfoView *infoView = (DriverBasicInfoView *)view;
            [((NSObject<DriverBasicInfoViewProtocol> *)infoView) didSelectAnnotationViewInMap:mapView];
        }
        
        if ([view isKindOfClass:[DriverBasicInfoPopView class]]) {
            DriverBasicInfoPopView *popView = (DriverBasicInfoPopView *)view;
            [((NSObject<DriverBasicInfoViewProtocol> *)popView) didSelectAnnotationViewInMap:mapView];
            DriverDetail *driverDetail = [[DriverDetail alloc] init];
            driverDetail.driverBasicInfo = popView.myAnnotation.driverBasicInfo;
            [self.navigationController pushViewController:driverDetail animated:YES];
        }
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    if ([view conformsToProtocol:@protocol(DriverBasicInfoViewProtocol)]) {
        [((NSObject<DriverBasicInfoViewProtocol> *)view) didDiselectAnnotationViewImMap:mapView];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation conformsToProtocol:@protocol(DriverBasicInfoAnnotationProtocol)]) {
        return [((NSObject<DriverBasicInfoAnnotationProtocol> *)annotation) annotationViewInMap:mapView];
    }
    return nil;
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKCircle class]]) {
        MKCircleView *circleView = [[MKCircleView alloc] initWithCircle:overlay];
        circleView.lineWidth = 1;
        circleView.strokeColor = [UIColor blueColor];
        circleView.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.2];
        return circleView;
    }
    return nil;
    
}

- (void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated{
    if(self.mapView.userTrackingMode == 0){
        [self.mapView setUserTrackingMode: MKUserTrackingModeNone animated: YES];
        
        //Put it back again
        UIImage *buttonArrow = [UIImage imageNamed:@"LocationGrey.png"];
        [_trackBtn setImage:buttonArrow forState:UIControlStateNormal];
    }
    
}


#pragma mark - CLlocationManager

- (void)settupLocationManager
{
    
    _locationManager = [[CLLocationManager alloc] init];
    //if the location services enabled
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager.delegate = self;
        _locationManager.distanceFilter = 1000;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        [_locationManager startUpdatingLocation];
        
    }
    else
    {
        SIAlertView *alertview = [[SIAlertView alloc] initWithTitle:nil andMessage:@"当前位置服务不可用"];
        [self customAlertViewProperty:alertview andBlock:^{
            [alertview dismissAnimated:YES];
        }];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    _userLocation = [locations lastObject];
    
    // if connect the server
    [self connectThriftServer];
    [self performSelectorInBackground:@selector(loadData) withObject:nil];
        
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    //locate city
    [geocoder reverseGeocodeLocation:_userLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
                       
                       if (error){
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                           
                       }
                       
                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                       
                       //user locationInfo
                       locationinfo *userLocationInfo = [[locationinfo alloc] initWithLongitude:_userLocation.coordinate.longitude latitude:_userLocation.coordinate.latitude address:placemark.name orderid:0 createtime:0];
                       
                       [MyUserDefault setObject:userLocationInfo forKey:@"UserLocationInfo"];
                       [MyUserDefault setObject:placemark.name forKey:@"UserAddress"];
                       [MyUserDefault setObject:placemark.locality forKey:@"UserCity"];

                       
                   }];
        
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSString *errorStr = [error description];
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:errorStr];
    [self customAlertViewProperty:alertView andBlock:^{
        [alertView dismissAnimated:YES];
    }];
    [_locationManager stopUpdatingLocation];
}

//- (void)decodeGoogle:(CLLocation *)loc
//{
//    NSString *urlStr = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true&language=zh-CN",loc.coordinate.latitude,loc.coordinate.longitude];
//    ASIFormDataRequest *_request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlStr]];
//    __block __weak ASIFormDataRequest *request = _request;
//    request.requestMethod = @"POST";
//    [request setCompletionBlock:^{
//        NSString *s = [request responseString];
//        if (s == nil) {
//            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"连接地理位置失败"];
//            [self customAlertViewProperty:alertView andBlock:^{
//                [alertView dismissAnimated:YES];
//            }];
//            return;
//        }
//        else
//        {
////            NSArray* resultDic = [[s objectFromJSONString] objectForKey:@"results"];
//////            NSLog(@"%@",resultDic);
////            NSString* userAddress = [[resultDic objectAtIndex:0]objectForKey:@"formatted_address"];
////         
//        }
//    }];
//    [request startAsynchronous];
//    
//}
//


#pragma mark - Calculate the Annotation Distance

- (void)calculateDistanceFromUserToAnnotation
{
    
    __block CLLocationDistance maxDistance = DBL_MIN;
    //1
    
    [_drivers enumerateObjectsUsingBlock:^( DriverBasicInfoAnnotation *driverAnnotation, NSUInteger idx, BOOL *stop) {
        //2
        CLLocation *thisLocation = [[CLLocation alloc] initWithLatitude:driverAnnotation.coordinate.latitude longitude:driverAnnotation.coordinate.longitude];
        
        //3 The most important ! to caculate the distance between two CLLocation.
        CLLocationDistance thisDistance = [_userLocation distanceFromLocation:thisLocation];
        
        //4 get the distance
        driverAnnotation.driverBasicInfo.distance = thisDistance;
        
        //5
        if (maxDistance < thisDistance) {
            maxDistance = thisDistance;
        }
     NSLog(@"maxDistance = %f",maxDistance);
    }];
    
    //2 span and region

        NSLog(@"%@",_drivers);
        double minLat = 360.0f, maxLat = -360.0f;
        double minLon = 360.0f, maxLon = -360.0f;
        for (DriverBasicInfoAnnotation *vu in _drivers) {
            if (vu.coordinate.latitude < minLat) minLat = vu.coordinate.latitude;
            if (vu.coordinate.latitude > maxLat) maxLat = vu.coordinate.latitude;
            if (vu.coordinate.longitude < minLon) minLon = vu.coordinate.longitude;
            if (vu.coordinate.longitude > maxLon) maxLon = vu.coordinate.longitude;
        }
        
        if (_userLocation.coordinate.latitude < minLat) {
            minLat = _userLocation.coordinate.latitude;
        }
        else maxLat = _userLocation.coordinate.latitude;
        
        if (_userLocation.coordinate.longitude < minLon) {
            minLon = _userLocation.coordinate.longitude;
        }
        else maxLon = _userLocation.coordinate.longitude;
        
        CLLocationCoordinate2D center = CLLocationCoordinate2DMake((minLat + maxLat)/2, (minLon + maxLon)/2);
        MKCoordinateSpan span = MKCoordinateSpanMake(maxLat- minLat, maxLon - minLon);
        MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
        [_mapView setRegion:region];
    
    
    
    
    
    //3 mkcircle
//    _userCircle = [MKCircle circleWithCenterCoordinate:_userLocation.coordinate radius:500];

}

#pragma mark - TaxiTabel

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_drivers) {
        return [_drivers count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIndentifier = [[NSString alloc] initWithFormat:@"cell%d",indexPath.section];
    DriverInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if (cell == nil) {
        cell = [[DriverInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UIImage *freeToCallImg = [UIImage imageNamed:@"call@2x.png"];
    UIImage *busyToCallImg = [UIImage imageNamed:@"discall@2x.png"];
    UIImage *driverDefault = [UIImage imageNamed:@"moren3@2x.png"];
    

    
    if (_drivers) {
        DriverBasicInfoAnnotation *annotation = [_drivers objectAtIndex:indexPath.section];
        DriverBasicInfo *driverBasicInfo = annotation.driverBasicInfo;
        UIImage *driverThumbnail = [UIImage imageWithData:driverBasicInfo.thumbnailData];
        
//        //render image
        driverThumbnail = [cell renderThumbnail:driverThumbnail];
//        driverDefault  = [cell renderThumbnail:driverDefault];

        if (driverThumbnail) {
            cell.thumbnail.image = driverThumbnail;
        }
        else
        {
            cell.thumbnail.image = driverDefault;
        }
        
        if (cell.starsProcess.progress == 0) {
            [cell.starsProcess add:driverBasicInfo.commentScore/5.0];
        }
        
        
        cell.driverNameLabel.text = driverBasicInfo.driverName;
        
        if (driverBasicInfo.distance >= 1000) {
            NSString *distanceStr = [[NSString alloc] initWithFormat:@"%f",driverBasicInfo.distance/1000.0];
            NSRange dotLocationRange = [distanceStr rangeOfString:@"."];
            NSRange range = {0,dotLocationRange.location+2};
            distanceStr = [distanceStr substringWithRange:range];
            cell.distanceLabel.text= [NSString stringWithFormat:@"%@千米",distanceStr];
        }
        else
        {
            NSString *distanceStr = [[NSString alloc] initWithFormat:@"%f",driverBasicInfo.distance];
            NSRange dotLocationRange = [distanceStr rangeOfString:@"."];
            NSRange range = {0,dotLocationRange.location+2};
            distanceStr = [distanceStr substringWithRange:range];
            cell.distanceLabel.text = [NSString stringWithFormat:@"%@米",distanceStr];
        }
        
        
        
        cell.driveTimesLabel.text = [NSString stringWithFormat:@"代驾%@次",driverBasicInfo.driverCount];

        //driver status
        switch (driverBasicInfo.driverState) {
            case 1:
            {
                
                cell.driverStatusLabel.text = @"空闲状态";
                cell.driverStatusLabel.textColor = [UIColor greenColor];
                [cell.callBtn setBackgroundImage:freeToCallImg forState:UIControlStateNormal];
                
                break;
            }
            case 2:
            {
                cell.driverStatusLabel.text = @"服务中";
                cell.driverStatusLabel.textColor = [UIColor orangeColor];
                [cell.callBtn setBackgroundImage:busyToCallImg forState:UIControlStateNormal];
                break;
            }
        }
        
        //driver sex
        switch (driverBasicInfo.driverSex) {
            case 0:
            {
                cell.driverSexLabel.text = @"性别:男";
                break;
            }
            case 1:
            {
                cell.driverSexLabel.text = @"性别:女";
                break;
            }
        }
        
        cell.driveAgeLabel.text = [NSString stringWithFormat:@"驾龄%@年",driverBasicInfo.driverAge];
        cell.nativePlaceLabel.text = [NSString stringWithFormat:@"籍贯：%@",driverBasicInfo.driverNativePlace ];
        cell.callBtn.tag = indexPath.section;
        [cell.callBtn addTarget:self action:@selector(callDriverBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
 
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DriverDetail *driverDetail = [[DriverDetail alloc] init];
    driverDetail.driverBasicInfo = [[_drivers objectAtIndex:indexPath.section] driverBasicInfo];
    [self.navigationController pushViewController:driverDetail animated:NO];
}

#pragma mark - EGORefreshHeaderView

//更新数据时使用的方法
- (void)reloadTableViewDataSource
{
    _reloading = YES;
}

- (void)doneLoadingTableViewData
{
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_taxiInfoTable];
}

//2 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView 
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

//2-1 由于scroll是一个过程，所以它会重复调用几次，基于UIScroll
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return _reloading;
}

//1 更新date
- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}


#pragma mark - btnClick


- (void)mapAndListBtnClick:(UIButton *)btn
{
    if ([[btn imageForState:UIControlStateNormal] isEqual:ListImage]) {
        [btn setImage:mapImage forState:UIControlStateNormal];
        self.taxiInfoMode = TaxiInfoModeList;
    }
    else
    {
        [btn setImage:ListImage forState:UIControlStateNormal];
        self.taxiInfoMode = TaxiInfoModeMap;
    }
}


- (void)startShowingUserHeading:(id)sender{

    UIButton *trackBtn = (UIButton *)sender;
    
    if(self.mapView.userTrackingMode == 0){
        [self.mapView setUserTrackingMode: MKUserTrackingModeFollow animated: YES];
        
        //Turn on the position arrow
        UIImage *buttonArrow = [UIImage imageNamed:@"LocationBlue.png"];
        [trackBtn setImage:buttonArrow forState:UIControlStateNormal];
        
    }
    else if(self.mapView.userTrackingMode == 1){
        [self.mapView setUserTrackingMode: MKUserTrackingModeFollowWithHeading animated: YES];
        
        //Change it to heading angle
        UIImage *buttonArrow = [UIImage imageNamed:@"LocationHeadingBlue"];
        [trackBtn setImage:buttonArrow forState:UIControlStateNormal];
    }
    else if(self.mapView.userTrackingMode == 2){
        [self.mapView setUserTrackingMode: MKUserTrackingModeNone animated: YES];
        
        //Put it back again
        UIImage *buttonArrow = [UIImage imageNamed:@"LocationGrey.png"];
        [trackBtn setImage:buttonArrow forState:UIControlStateNormal];
    }
    
    //reload data
    [self loadData];
}


- (void)callDriverBtn:(id)sender
{
    UIButton *callDriverBtn = (UIButton *)sender;
    DriverBasicInfoAnnotation *annotation = [_drivers objectAtIndex:callDriverBtn.tag];
    DriverBasicInfo *driverBasicInfo = annotation.driverBasicInfo;
    
    
    
    switch (driverBasicInfo.driverState) {
        case 1:
        {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"拨打该电话？"];
            alertView.messageColor = [UIColor grayColor];
            alertView.messageFont = [UIFont systemFontOfSize:14.0f];
            alertView.buttonFont = [UIFont systemFontOfSize:12.0f];
            [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
                
                NSString *tel = [[NSString alloc] initWithFormat:@"tel://%@",driverBasicInfo.driverPhoneNum];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
            }];
            [alertView addButtonWithTitle:@"取消" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
                [alertView dismissAnimated:YES];
            }];
            [alertView show];
            break;
        }
        case 2:
        {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"该司机正在服务中..."];
            [self customAlertViewProperty:alertView andBlock:^{
                [alertView dismissAnimated:YES];
            }];
            [alertView show];
            break;
        }
    }

}

- (void)reservationBtn
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"SessionID"]) {
        ZuoxinReservationDetail *reservationDetail = [[ZuoxinReservationDetail alloc] init];
        [self.navigationController pushViewController:reservationDetail animated:NO];
    }
    else
    {
        ZuoxinReservation *reservation = [[ZuoxinReservation alloc] init];
        [self.navigationController pushViewController:reservation animated:NO];
    }
    
}


- (void)callBtnClick:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4006278866"]];
}

//- (void)reconnectbtnClick:(id)sender
//{
//    [self loadData];
//    
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
