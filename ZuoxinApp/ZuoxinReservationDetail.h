//
//  ZuoxinReservationDetail.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-22.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "BasicViewModel.h"
#import <MapKit/MapKit.h>
@class CustomTextField;


@interface ZuoxinReservationDetail : BasicViewModel<UITextFieldDelegate
>
{
    UILabel *_timeLabel;
    CustomTextField *_driverCountField;
    UILabel *_locationLabel;
}

@end
