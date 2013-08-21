//
//  ZuoxinInvitation.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "ZuoxinInvitation.h"
#import "BackBtn.h"
#import "CustomBtn.h"

@interface ZuoxinInvitation ()

@end

@implementation ZuoxinInvitation

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadCustomBar
{
    self.navTitleLabel.text = @"邀请好友";
    self.backBtn.hidden = YES;
    self.customBtn.hidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadCustomBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
