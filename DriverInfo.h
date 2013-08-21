//
//  DriverInfo.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-21.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface DriverInfo : NSObject<MKAnnotation>

@property(nonatomic, strong) NSString *driverName;
@property(nonatomic, assign) CLLocationCoordinate2D coordinate;

- (MKMapItem*)mapItem;

@end
