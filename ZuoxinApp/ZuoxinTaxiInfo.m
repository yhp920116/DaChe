//
//  ZuoxinTaxiInfo.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "ZuoxinTaxiInfo.h"
#import "BackBtn.h"
#import "CustomBtn.h"
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


@interface ZuoxinTaxiInfo () <MKMapViewDelegate>{
    NSMutableArray *_drivers;
    MKCircle *_userCircle;
}

@end

@implementation ZuoxinTaxiInfo

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-49-44)];
        _taxiInfoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-49-44) style:UITableViewStylePlain];
            }
        _MainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-49-44)];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadCustomBar];
    [self loadData];

}

- (void)loadData
{
    if ([self connected]) {
        
        //1
        _drivers = [[NSMutableArray alloc] initWithCapacity:8];
        
        //2
        CLLocationDegrees latitude = 22.17102;
        CLLocationDegrees longitude = 114.16930;
        _driverArr = [self.server finddrivers:longitude latitude:latitude count:8 distance:8000];
    
        for (NSDictionary *driverDic in _driverArr) {
            
            DriverBasicInfo *driverBasicInfo = [[DriverBasicInfo alloc] init];
            
            //Tips:driverBasicInfo error may cause annotation disappear!
            driverBasicInfo.driverName = [driverDic valueForKey:@"name"];
            driverBasicInfo.commentScore = [[driverDic valueForKey:@"score"] floatValue]/1000.0;
            NSLog(@"%f",driverBasicInfo.commentScore);
            driverBasicInfo.driverPhoneNum = [driverDic valueForKey:@"mobile"];
            driverBasicInfo.driverAge = [driverDic valueForKey:@"driveage"];
            driverBasicInfo.driverCount = [driverDic valueForKey:@"drivercount"];
            driverBasicInfo.driverSex = [[driverDic valueForKey:@"sex"] integerValue];
            driverBasicInfo.driverNativePlace = [driverDic valueForKey:@"province"];
            CLLocationDegrees longitude = [[driverDic valueForKey:@"longitude"] floatValue];
            CLLocationDegrees latitude = [[driverDic valueForKey:@"latitude"] floatValue];
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
            driverBasicInfo.coordinate = coordinate;
            
            [_drivers addObject:[[DriverBasicInfoAnnotation alloc] initWithDriverBasicInfo:driverBasicInfo]];
        }
        
        //3 loadMapView and TableListView
        [self loadMapView];
        [self loadTableListView];
        
        self.taxiInfoMode = TaxiInfoModeMap;
    }
    else self.taxiInfoMode = TaxiInfoModeUnconnected;
}


- (void)loadCustomBar
{
    self.backBtn.hidden = YES;
    [self.customBtn setTitle:@"多人预约" forState:UIControlStateNormal];
    [self.customBtn addTarget:self action:@selector(reservationBtn) forControlEvents:UIControlEventTouchUpInside];

    UIButton *mapAndListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mapAndListBtn.frame = CGRectMake(0, 0, 50, 14);
    mapAndListBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [mapAndListBtn setTitle:@"地图" forState:UIControlStateNormal];
    [mapAndListBtn addTarget:self action:@selector(mapAndListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *mapAndListBtnItem = [[UIBarButtonItem alloc] initWithCustomView:mapAndListBtn]
    ;
    self.navigationItem.leftBarButtonItem = mapAndListBtnItem;
}

- (void)mapAndListBtnClick:(UIButton *)btn
{
    if ([[btn titleForState:UIControlStateNormal] isEqualToString:@"地图"]) {
        [btn setTitle:@"列表" forState:UIControlStateNormal];
        self.taxiInfoMode = TaxiInfoModeList;
    }
    else
    {
        [btn setTitle:@"地图" forState:UIControlStateNormal];
        self.taxiInfoMode = TaxiInfoModeMap;
    }
}

#pragma mark - TaxiInfoMode

- (void)setTaxiInfoMode:(TaxiInfoMode)taxiInfoMode
{
    _taxiInfoMode = taxiInfoMode;
    switch (_taxiInfoMode) {
        case 0:
        {
            _MainView = nil;
            _MainView = _mapView;
            break;
        }
        case 1:
        {
            _MainView = nil;
            _MainView = _taxiInfoTable;
            break;
        }
        case 2:
        {
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:16.0f];
            label.textColor = [UIColor orangeColor];
            CGSize size = CGSizeMake(280, 1000);
            label.text = @"糟糕啦！你的网络出现问题，我们无法定位你的位置，你可以检查下自己的网络情况，如果需要我们的服务，可以致电222222";
            CGSize textSize = [label.text sizeWithFont:label.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
            label.numberOfLines = 0;
            label.frame = CGRectMake(20, 20, textSize.width, textSize.height);
            [self.view addSubview:label];
            break;
        }
    }
    
    [self.view addSubview:_MainView];

    
}

- (void)loadMapView
{
    _mapView.delegate = self;
    _mapView.scrollEnabled = YES;
    _mapView.zoomEnabled = YES;
    _mapView.showsUserLocation = YES;
    
    //            CLLocationDegrees latitude = 22.15102;
    //            CLLocationDegrees longitude = 114.13930;
    CLLocationDegrees latitude = 23.14423;
    CLLocationDegrees longitude = 113.327631;
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01345, 0.01234);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [_mapView setRegion:region];
    
    _userCircle = [MKCircle circleWithCenterCoordinate:coordinate radius:500];

    [_mapView addAnnotation:[_drivers objectAtIndex:0]];
    [_mapView addOverlay:_userCircle];
}

- (void)loadTableListView
{
    _taxiInfoTable.delegate = self;
    _taxiInfoTable.dataSource = self;
    _taxiInfoTable.showsVerticalScrollIndicator = NO;
    _taxiInfoTable.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];

    
    if (_refreshHeaderView == nil) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-_taxiInfoTable.frame.size.height, _taxiInfoTable.frame.size.width, _taxiInfoTable.frame.size.height)];
        _refreshHeaderView.delegate = self;
        [_taxiInfoTable addSubview:_refreshHeaderView];
        
        //1 it will call egoRefreshTableHeaderDataSourceLastUpdated method
        [_refreshHeaderView refreshLastUpdatedDate];
    }

    
}

#pragma mark - MapView
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

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    DriverDetail *driverDetail = [[DriverDetail alloc] init];
    [self.navigationController pushViewController:driverDetail animated:YES];
}

#pragma mark - TaxiTabel

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_drivers count];
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
    static NSString *CellIndentifier =@"Cell";
    DriverInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if (cell == nil) {
        cell = [[DriverInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    UIImage *accessoryArrow = [UIImage imageNamed:@"search-cell-accessory@2x.png"];
    UIImage *thumbnail = [UIImage imageNamed:@"apple.jpg"];

    DriverBasicInfoAnnotation *annotation = [_drivers objectAtIndex:indexPath.section];
    DriverBasicInfo *driverBasicInfo = annotation.driverBasicInfo;
    
    cell.thumbnail.image = thumbnail;
    [cell.starsProcess add:driverBasicInfo.commentScore];
    
    cell.driverNameLabel.text = driverBasicInfo.driverName;
    cell.distanceLabel.text = [NSString stringWithFormat:@"距离：12米"];
    cell.driveTimesLabel.text = [NSString stringWithFormat:@"代驾%@次",driverBasicInfo.driverCount];
    // set startProcess property
    
    
    //driver status
    switch (driverBasicInfo.driverState) {
        case 0:
        {
            cell.driverStatusLabel.text = @"空闲状态";
            cell.driverStatusLabel.textColor = [UIColor greenColor];
            break;
        }
        case 1:
        {
            cell.driverStatusLabel.text = @"服务中";
            cell.driverStatusLabel.textColor = [UIColor redColor];
            break;
        }
        case 2:
        {
            cell.driverStatusLabel.text = @"休息中";
            cell.driverStatusLabel.textColor = [UIColor grayColor];
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
    cell.arrowView.image = accessoryArrow;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DriverDetail *driverDetail = [[DriverDetail alloc] init];
    driverDetail.driverBasicInfo = [[_drivers objectAtIndex:indexPath.section] driverBasicInfo];
    [self.navigationController pushViewController:driverDetail animated:YES];
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


#pragma mark - reservationBtn

- (void)reservationBtn
{
    ZuoxinReservation *reservation = [[ZuoxinReservation alloc] init];
    [self.navigationController pushViewController:reservation animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
