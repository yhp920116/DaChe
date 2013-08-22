//
//  ZuoxinReservation.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "ZuoxinReservation.h"
#import "BackBtn.h"
#import "CustomBtn.h"
#import "UIBezierPath+BasicShapes.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomTextField.h"

@interface ZuoxinReservation ()

@end

@implementation ZuoxinReservation

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
    self.backBtn.hidden = YES;
    self.customBtn.hidden = YES;
    self.navTitleLabel.text = @"多人预约";
}

- (void)loadMainView
{
    //inputPhoneNumView
    UIView *inputPhoneNumView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 120)];
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
    
    UIButton *verificationCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    verificationCodeBtn.frame = CGRectMake(6, 70, 288, 30);
    verificationCodeBtn.backgroundColor = [UIColor lightGrayColor];
    verificationCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [verificationCodeBtn setTitle:@"获取手机验证码" forState:UIControlStateNormal];
    [verificationCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [verificationCodeBtn addTarget:self action:@selector(verificationCodeBtn) forControlEvents:UIControlEventTouchUpInside];
    [inputPhoneNumView addSubview:verificationCodeBtn];
    
    //VerificationView
    UIView *verificationView = [[UIView alloc] initWithFrame:CGRectMake(10, 140, 300, 120)];
    verificationView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2];
    verificationView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    verificationView.layer.borderWidth = 1.0;
    [self.view addSubview:verificationView];
    
    UILabel *label_ = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 200, 14.0f)];
    label_.text = @"输入您收到的验证码:";
    label_.font = [UIFont systemFontOfSize:14.0f];
    label_.textColor = [UIColor blackColor];
    label_.backgroundColor = [UIColor clearColor];
    [verificationView addSubview:label_];
    
    _verificationField = [[CustomTextField alloc] initWithFrame:CGRectMake(6, 27, 288, 25)];
    _verificationField.font = [UIFont systemFontOfSize:16.0f];
    _verificationField.borderStyle = UITextBorderStyleNone;
    _verificationField.keyboardType = UIKeyboardTypeNumberPad;
    _verificationField.delegate = self;
    _verificationField.layer.borderWidth = 1.0f;
    _verificationField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [verificationView addSubview:_verificationField];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(6, 70, 288, 30);
    confirmBtn.backgroundColor = [UIColor lightGrayColor];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtn) forControlEvents:UIControlEventTouchUpInside];
    [verificationView addSubview:confirmBtn];
    
    
}


#pragma mark - VerificationCodeBtn

- (void)verificationCodeBtn
{
    
}

- (void)confirmBtn
{
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_phoneNumField resignFirstResponder];
    [_verificationField resignFirstResponder];
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
