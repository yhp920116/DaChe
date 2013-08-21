//
//  DriverInfo.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-21.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "DriverInfo.h"
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>

@implementation DriverInfo

- (MKMapItem*)mapItem
{
    //1
    NSDictionary *addressDic = @{
    (NSString *)kABPersonAddressCountryKey: @"China",
    (NSString *)kABPersonAddressCityKey:@"广州",
    (NSString *)kABPersonAddressStreetKey:@"天河维多利广场",
    (NSString *)kABPersonAddressZIPKey:@"nil"};
    
    //2
    MKPlacemark *placeMark = [[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:addressDic];
    
    //3
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placeMark];
    mapItem.name = self.driverName;
    mapItem.phoneNumber = @"123456789";
    
    return mapItem;
}

@end
