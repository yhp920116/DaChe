//
//  ZuoxinTaxiInfo.h
//  ZuoxinApp
//  http://192.168.1.245:9000/zxdj/
//
//  Created by 新工厂 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "BasicViewModel.h"
#import <MapKit/MapKit.h>
#import "EGORefreshTableHeaderView.h"
#import "Reachability.h"


enum {
    TaxiInfoModeMap = 0,
    TaxiInfoModeList,
    TaxiInfoModeUnconnected
};
typedef NSUInteger TaxiInfoMode;

@interface ZuoxinTaxiInfo : BasicViewModel<EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate,CLLocationManagerDelegate>
{
    MKMapView *_mapView;
    UITableView *_taxiInfoTable;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    NSMutableArray *_driverArr;
    UIButton *_trackBtn;
}

@property(nonatomic, assign) TaxiInfoMode taxiInfoMode;
@property(nonatomic, strong) MKMapView *mapView;
@property(nonatomic) UIView *MainView;

- (void)setTaxiInfoMode:(TaxiInfoMode)taxiInfoMode;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;


@end
