//
//  DriverBasicPopAnnotation.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-9-6.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "DriverBasicInfoAnnotationProtocol.h"
#import "DriverBasicInfoPopView.h"
#import "DriverBasicInfo.h"

@interface DriverBasicPopAnnotation : NSObject<MKAnnotation,DriverBasicInfoAnnotationProtocol>

@property(nonatomic, strong) DriverBasicInfo *driverBasicInfo;
@property(nonatomic, strong) DriverBasicInfoPopView *view;
@property(nonatomic, assign) CLLocationCoordinate2D coordinate;

- (id)initWithDriverBasicInfo:(DriverBasicInfo *)driverBasicInfo;
- (void)updateDriverBasicInfo:(DriverBasicInfo *)driverBasicInfo animated:(BOOL)animated;

@end
