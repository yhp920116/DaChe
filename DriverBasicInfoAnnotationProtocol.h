//
//  DriverBasicInfoAnnotationProtocol.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-9-6.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import <MapKit/MapKit.h>

@protocol DriverBasicInfoAnnotationProtocol <NSObject>

- (MKAnnotationView *)annotationViewInMap:(MKMapView *)mapView;

@end
