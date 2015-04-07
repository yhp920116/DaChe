//
//  ZuoxinDelegateProtocol.h
//  ZuoxinApp
//
//  Created by tongxia on 9/4/13.
//  Copyright (c) 2013 Zuoxin.com. All rights reserved.
//

#import "BasicViewModel.h"

@interface ZuoxinDelegateProtocol : BasicViewModel<UITextViewDelegate>
{
    UITextView *protocolView;
}

@property(nonatomic,strong) UITextView *protocolView;

@end
