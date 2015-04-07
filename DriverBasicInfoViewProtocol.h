//
//  DriverBasicInfoViewProtocol.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-9-6.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import <MapKit/MapKit.h>

@protocol DriverBasicInfoViewProtocol <NSObject>

- (void)didSelectAnnotationViewInMap:(MKMapView *)mapView;
- (void)didDiselectAnnotationViewImMap:(MKMapView *)mapView;


@end
