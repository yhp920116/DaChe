//
//  ZuoxinDriverInfoDetail.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-9-16.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "BasicViewModel.h"

@interface ZuoxinDriverInfoDetail : BasicViewModel<UITextViewDelegate>
{
    UILabel *_timeLabel;
    UILabel *_locationLabel;
    UILabel *_commentLabel;
    UITextView *_commentTextView;
}

@property(nonatomic, strong) NSDictionary *orderDic;

@end
