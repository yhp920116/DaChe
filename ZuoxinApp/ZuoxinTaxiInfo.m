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
    }
    return self;
}

- (void)loadData
{
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"command" ofType:@"json"]];
    NSArray *drivers = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    _drivers = [[NSMutableArray alloc] initWithCapacity:8];
    
    for (NSDictionary *driverDic in drivers) {
        DriverBasicInfo *driverBasicInfo = [[DriverBasicInfo alloc] init];
        driverBasicInfo.driverName = [driverDic objectForKey:@"name"];
        driverBasicInfo.commentScore = [[driverDic objectForKey:@"commentScore"] floatValue];
        
        CLLocationDegrees latitude = [[driverDic objectForKey:@"latitude"] doubleValue];
        CLLocationDegrees longitude = [[driverDic objectForKey:@"longitude"] doubleValue];
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        driverBasicInfo.coordinate = coordinate;

        [_drivers addObject:[[DriverBasicInfoAnnotation alloc] initWithDriverBasicInfo:driverBasicInfo]];
    }
    
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
            _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-49)];
            _mapView.delegate = self;
            _mapView.scrollEnabled = YES;
            _mapView.zoomEnabled = YES;
            _mapView.showsUserLocation = YES;
            [self.view addSubview:_mapView];
            
            CLLocationDegrees latitude = 22.2120;
            CLLocationDegrees longitude = 114.1832;
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
            MKCoordinateSpan span = MKCoordinateSpanMake(0.12345, 0.1234);
            MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
            [_mapView setRegion:region];

            _userCircle = [MKCircle circleWithCenterCoordinate:coordinate radius:8000];
            
            [_mapView addAnnotations:_drivers];
            [_mapView addOverlay:_userCircle];
            
            break;
        }
        case 1:
        {
            UITableView *taxiInfoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-49) style:UITableViewStylePlain];
            taxiInfoTable.tag = 999;
            taxiInfoTable.delegate = self;
            taxiInfoTable.dataSource = self;
            taxiInfoTable.showsVerticalScrollIndicator = NO;
            taxiInfoTable.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:taxiInfoTable];
            break;
        }
        case 2:
        {
            break;
        }

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
    return 8;
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
    cell.driverNameLabel.text = @"路飞";
    cell.distanceLabel.text = [cell.distanceLabel.text stringByAppendingFormat:@"10公里"];
    cell.driveTimesLabel.text = [cell.driveTimesLabel.text stringByAppendingFormat:@"100次"];
    // set startProcess property
    
    
    cell.driverStatusLabel.text = @"冒险中";
    cell.driverStatusLabel.textColor = [UIColor redColor];
    
    cell.driveAgeLabel.text = [cell.driveAgeLabel.text stringByAppendingFormat:@"10年"];
    cell.nativePlaceLabel.text = [cell.nativePlaceLabel.text stringByAppendingFormat:@"新世界"];
    cell.arrowView.image = accessoryArrow;
    cell.separatorLine.image = separator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DriverDetail *driverDetail = [[DriverDetail alloc] init];
    [self.navigationController pushViewController:driverDetail animated:YES];
}

#pragma mark - reservationBtn

- (void)reservationBtn
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
	[self loadCustomBar];
    self.taxiInfoMode = TaxiInfoModeMap;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
