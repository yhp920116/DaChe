//
//  Coupons.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-9-9.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "BasicViewModel.h"
@class CustomTextField;

@interface Coupons : BasicViewModel<UITextFieldDelegate>
{
    CustomTextField *_couponsNumField;
    CustomTextField *_phoneFiled;
}

@end
