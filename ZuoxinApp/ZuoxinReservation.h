//
//  ZuoxinReservation.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "BasicViewModel.h"


@interface ZuoxinReservation : BasicViewModel<UITextFieldDelegate>
{
    UITextField *_phoneNumField;
    UITextField *_verificationField;
    NSString *_verificationCode;
    UIButton *_doneInKeyboardBtn;

}

@end
