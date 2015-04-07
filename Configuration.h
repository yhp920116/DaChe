//
//  Configuration.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-9-18.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//Configuration

#define BlueBtnBG [[UIImage imageNamed:@"bluebtn.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 5, 2, 5)]

#define GeenBtnBG [[UIImage imageNamed:@"greenbtn.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 5, 2, 5)]

#define RedBtnBG [[UIImage imageNamed:@"redbtn.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 5, 2, 5)]


#define MediumFont [UIFont systemFontOfSize:14.0f]
#define SMediumFont [UIFont systemFontOfSize:12.0f]
#define SmallFont [UIFont systemFontOfSize:10.0f]
#define BigFont [UIFont systemFontOfSize:14.0f]
#define BigBigFont [UIFont systemFontOfSize:16.0f]

#define BlackFontColor [UIColor colorWithRed:90.0/255.0 green:90.0/255.0 blue:90.0/255.0 alpha:1]
#define GreenFontColor [UIColor colorWithRed:90.0/255.0 green:156.0/255.0 blue:0 alpha:1]
#define GrayFontColor [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153/255.0 alpha:1]
#define OrangeFontColor [UIColor orangeColor]

#define MyUserDefault [NSUserDefaults standardUserDefaults]
/*
 MyUserDefault allKey
 UserCity  用户城市
 UserAddress 用户地址
 UserLocationInfo  用户位置信息
 UserPhoneNum   用户手机号码
 SessionID  用户登陆标识
 InviteNum  邀请码和可用次数
 
*/

#define NavigationBarImage [UIImage imageNamed:@"navigationbarbg.png"]
#define BackBtnImage [UIImage imageNamed:@"backbtn.png"]
#define ReservationImage [UIImage imageNamed:@"appointmentbtnbg.png"]
#define ListImage [UIImage imageNamed:@"listbtnbg.png"]
#define mapImage [UIImage imageNamed:@"mapbtnbg.png"]
#define CouponsImage [UIImage imageNamed:@"coupons.png"]
#define CityChooseBtnImage [UIImage imageNamed:@"citybtnImg.png"]
#define MyInfoImage [UIImage imageNamed:@"cmyinfo.png"]



//driverbasicPopView
#define DriverBasicInfoPopViewWidth 87.0f * 3
#define DriverBasicInfoPopViewHeight 60.0f * 2
#define DriverBasicInfoViewVerticalOffset 34.0f
#define  Arror_height 15
#define kDropCompressAmount 0.1

@interface Configuration : NSObject

@end
