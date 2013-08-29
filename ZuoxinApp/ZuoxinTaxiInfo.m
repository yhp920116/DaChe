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
        _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-49)];
        _taxiInfoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-49) style:UITableViewStylePlain];
            }
        _MainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-49)];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadCustomBar];
    [self loadData];
    [self loadMapView];
    [self loadTableListView];
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
            driverBasicInfo.driverName = [driverDic valueForKey:@"name"];
            driverBasicInfo.commentScore = 0.8;
            
            CLLocationDegrees longitude = [[driverDic valueForKey:@"longitude"] doubleValue];
            CLLocationDegrees latitude = [[driverDic valueForKey:@"latitude"] doubleValue];
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
            driverBasicInfo.coordinate = coordinate;
            [_drivers addObject:[[DriverBasicInfoAnnotation alloc] initWithDriverBasicInfo:driverBasicInfo]];
        }
        
        self.taxiInfoMode = TaxiInfoModeMap;
    }
    else self.taxiInfoMode = TaxiInfoModeUnconnected;
}


- (void)loadCustomBar
{
    self.backBtn.hidden = YES;
    [self.customBtn setTitle:@"多人预约" forState:UIControlStateNormal];
    [self.customBtn addTarget:self action:@selector(reservationBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UISegmentedControl *listAndMap = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"列表",@"地图",nil]];
    listAndMap.frame = CGRectMake(0, 0, 177, 24);
    listAndMap.segmentedControlStyle = UISegmentedControlStyleBar;
    listAndMap.selectedSegmentIndex = 1;
    [listAndMap addTarget:self action:@selector(segmentSwitch:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView =  listAndMap;
}

- (void)segmentSwitch:(id)sender
{
    UISegmentedControl *listAndMap = (UISegmentedControl *)sender;
    switch (listAndMap.selectedSegmentIndex) {
        case 0:
        {
            self.taxiInfoMode = TaxiInfoModeList;
            break;
        }
        case 1:
        {
            self.taxiInfoMode = TaxiInfoModeMap;
            break;
        }
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
    
    _userCircle = [MKCircle circleWithCenterCoordinate:coordinate radius:1000];
    
    [_mapView addAnnotation:[_drivers objectAtIndex:0]];
    [_mapView addOverlay:_userCircle];
}

- (void)loadTableListView
{
    _taxiInfoTable.delegate = self;
    _taxiInfoTable.dataSource = self;
    _taxiInfoTable.showsVerticalScrollIndicator = NO;
    _taxiInfoTable.backgroundColor = [UIColor whiteColor];
    
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
    }else return nil;
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_driverArr count];
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
    UIImage *separator = [UIImage imageNamed:@"contentSprarator.png"];
    
    cell.thumbnail.image = thumbnail;
    cell.driverNameLabel.text = [[_driverArr objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.distanceLabel.text = [cell.distanceLabel.text stringByAppendingFormat:@"10公里"];
    cell.driveTimesLabel.text = [cell.driveTimesLabel.text stringByAppendingFormat:@"%@",[[_driverArr objectAtIndex:indexPath.row] valueForKey:@"drivercount"]];
    // set startProcess property
    
    
    cell.driverStatusLabel.text = [[[_driverArr objectAtIndex:indexPath.row] valueForKey:@"state"] stringValue];
    cell.driverStatusLabel.textColor = [UIColor redColor];
    
    cell.driveAgeLabel.text = [cell.driveAgeLabel.text stringByAppendingFormat:@"%@",[[_driverArr objectAtIndex:indexPath.row] valueForKey:@"driveage"]];
    cell.nativePlaceLabel.text = [cell.nativePlaceLabel.text stringByAppendingFormat:@"%@",[[_driverArr objectAtIndex:indexPath.row] valueForKey:@"province"]];
    cell.arrowView.image = accessoryArrow;
    cell.separatorLine.image = separator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DriverDetail *driverDetail = [[DriverDetail alloc] init];
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
