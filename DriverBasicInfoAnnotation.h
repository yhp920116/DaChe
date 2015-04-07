//
//  DriverBasicInfoAnnotation.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-21.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "DriverBasicInfo.h"
#import "DriverBasicInfoView.h"
#import "DriverBasicInfoAnnotationProtocol.h"


@interface DriverBasicInfoAnnotation : NSObject<MKAnnotation,DriverBasicInfoAnnotationProtocol>

@property(nonatomic, strong) DriverBasicInfo *driverBasicInfo;
@property(nonatomic, strong) DriverBasicInfoView *view;
@property(nonatomic, assign) CLLocationCoordinate2D coordinate;

- (id)initWithDriverBasicInfo:(DriverBasicInfo *)driverBasicInfo;
- (void)updateDriverBasicInfo:(DriverBasicInfo *)driverBasicInfo animated:(BOOL)animated;

@end
