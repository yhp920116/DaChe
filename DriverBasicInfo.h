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

@property(nonatomic,assign) long long int driverID;
@property(nonatomic, strong) NSString *driverName;
@property(nonatomic, strong) NSString *driverPhoneNum;
@property(nonatomic, strong) NSString *driverAge;
@property(nonatomic, strong) NSString *driverNativePlace;
@property(nonatomic, strong) NSString *driverCount;
@property(nonatomic, strong) NSData *thumbnailData;
@property(nonatomic, assign) NSInteger pictype;
@property(nonatomic, assign) int commentScore;
@property(nonatomic, assign) NSInteger driverState;
@property(nonatomic, assign) NSInteger driverSex;
@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(nonatomic, assign) __block float distance;

@end
