//
//  BasicViewModel.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BackBtn;
@class CustomBtn;

@interface BasicViewModel : UIViewController

@property(nonatomic, strong) BackBtn *backBtn;
@property(nonatomic, strong) CustomBtn *customBtn;
@property(nonatomic, strong) UILabel *navTitleLabel;

- (void)setTabBarHidden:(BOOL)hidden;

@end
