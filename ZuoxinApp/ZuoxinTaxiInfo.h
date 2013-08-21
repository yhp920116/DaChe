//
//  ZuoxinTaxiInfo.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "BasicViewModel.h"
#import <MapKit/MapKit.h>

enum {
    TaxiInfoModeMap = 0,
    TaxiInfoModeList,
    TaxiInfoModeUnconnected
};
typedef NSUInteger TaxiInfoMode;

@interface ZuoxinTaxiInfo : BasicViewModel<UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate>
{
    TaxiInfoMode _taxiInfoMode;
    MKMapView *_mapView;
}

@property(nonatomic, strong) MKMapView *mapView;

- (void)setTaxiInfoMode:(TaxiInfoMode)taxiInfoMode;

@end
