//
//  ZuoxinReservationDetail.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-22.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "ZuoxinReservationDetail.h"
#import "CustomBtn.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomTextField.h"

@interface ZuoxinReservationDetail ()

@end

@implementation ZuoxinReservationDetail

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
    self.customBtn.hidden = YES;
    self.navTitleLabel.text = @"预约多位司机";
}

- (void)loadMainView
{
    //inputPhoneNumView
    UIView *inputPhoneNumView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 62)];
    inputPhoneNumView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2];
    inputPhoneNumView.layer.borderWidth = 1.0f;
    inputPhoneNumView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:inputPhoneNumView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 200, 14.0f)];
    label.text = @"您的联系电话:";
    label.font = [UIFont systemFontOfSize:14.0f];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    [inputPhoneNumView addSubview:label];
    
    _phoneNumField = [[CustomTextField alloc] initWithFrame:CGRectMake(6, 27, 288, 25)];
    _phoneNumField.font = [UIFont systemFontOfSize:16.0f];
    _phoneNumField.borderStyle = UITextBorderStyleNone;
    _phoneNumField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumField.delegate = self;
    _phoneNumField.layer.borderWidth = 1.0f;
    _phoneNumField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [inputPhoneNumView addSubview:_phoneNumField];
    
    //DetailView
    UIView *detailView = [[UIView alloc] initWithFrame:CGRectMake(10, 82, 300, 240)];
    detailView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2];
    detailView.layer.borderWidth = 1.0f;
    detailView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:detailView];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 200, 14.0f)];
    timeLabel.text = @"您要求司机到达的时间:";
    timeLabel.font = [UIFont systemFontOfSize:14.0f];
    timeLabel.textColor = [UIColor blackColor];
    timeLabel.backgroundColor = [UIColor clearColor];
    [inputPhoneNumView addSubview:timeLabel];
    
    [detailView addSubview:timeLabel];
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadCustomBar];
    [self loadMainView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
