//
//  DriverBasicInfo.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-21.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface DriverBasicInfo : NSObject

@property(nonatomic, strong) NSString *driverName;
@property(nonatomic, strong) NSString *thumbnailURL;
@property(nonatomic, assign) float commentScore;
@property(nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
