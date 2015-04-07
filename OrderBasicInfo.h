//
//  OrderBasicInfo.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-9-13.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderBasicInfo : NSObject

@property(nonatomic, strong) NSString *orderID;
@property(nonatomic, assign) long long int customerMobile;
@property(nonatomic, strong) NSString *customerName;
@property(nonatomic, assign) long long int creatTime;
@property(nonatomic, assign) long long int reservationTime;
@property(nonatomic, strong) NSString *userAddress;
@property(nonatomic, assign) int driverCount;
@property(nonatomic, assign) long int leaderOrderID;
@property(nonatomic, assign) int *orderState;
@property(nonatomic, assign) int *commentLevel;
@property(nonatomic, assign) long long int leaderMobile;
@property(nonatomic, assign) int *driverName;
@property(nonatomic, strong) NSString *comment;
@property(nonatomic, assign) int customerType;
@property(nonatomic, assign) long long int startTime;
@property(nonatomic, assign) long long int endTime;
@property(nonatomic, strong) NSString *startAddress;
@property(nonatomic, strong) NSString *endAddress;
@property(nonatomic, assign) int cityID;
@property(nonatomic, strong) NSString *paperID;
@property(nonatomic, strong) NSString *carno;
@property(nonatomic, assign) long long int rstartTime;
@property(nonatomic, assign) long long int rendTime;
@property(nonatomic, assign) long int  waitMinutes;
@property(nonatomic, strong) NSString *rstartAddress;
@property(nonatomic, strong) NSString *rendAddress;
@property(nonatomic, assign) long int distance;
@property(nonatomic, assign) double totalAmount;
@property(nonatomic, assign) double vipAmount;
@property(nonatomic, assign) double coupon;
@property(nonatomic, assign) double cash;
@property(nonatomic, assign) int invoice;
@property(nonatomic, strong) NSString *remark;
@property(nonatomic, assign) BOOL complaint;
@property(nonatomic, assign) int cancelType;
@property(nonatomic, assign) int come;
@property(nonatomic, assign) long long int driverMobile;

@end

//"Order(orderid:1079,customer:Customer(customermobile:13480299615,customername:\"\",amount:0.000000,coupon:0.000000,credit:0.000000,sex:0,customertype:0,othermobiles:(null)),driver:Driver(driverid:0,mobile:18620605037,name:\"\U7ecd\U9510        \",score:0,longitude:0.000000,latitude:0.000000,drivercard:\"(null)\",driveage:0,province:\"(null)\",drivercount:0,state:0,picture:\"(null)\",pictype:0,address:\"(null)\",sex:0,isleader:0),createtime:1378351266,pretime:0,preaddress:\"\",drivercount:1,parentorderid:0,orderstate:3,ordertype:0,leadermobile:0,commentlevel:0,comment:\"\",starttime:0,endtime:0,startaddress:\"\",endaddress:\"\",city:11,paperid:\"(null)\",carno:\"(null)\",rstarttime:0,rendtime:0,waitminutes:0,rstartaddress:\"(null)\",rendaddress:\"(null)\",distance:0,totalamount:0.000000,vipamount:0.000000,coupon:0.000000,cash:0.000000,invoice:0,remark:\"(null)\",complaint:0,canceltype:0)",



@interface DriverInfo : NSObject

@property(nonatomic, assign) int driverID;
@property(nonatomic, assign) long long int driverMobile;
@property(nonatomic, strong) NSString *driverName;
@property(nonatomic, assign) int commentScore;
@property(nonatomic, assign) double longitude;
@property(nonatomic, assign) double latitude;
@property(nonatomic, strong) NSString *driverCard;
@property(nonatomic, assign) int driveAge;
@property(nonatomic, strong) NSString *province;
@property(nonatomic, assign) int driverCount;
@property(nonatomic, assign) int state;
@property(nonatomic, strong) NSString *address;
@property(nonatomic, assign) int sex;
@property(nonatomic, assign) int isLeader;

@end
