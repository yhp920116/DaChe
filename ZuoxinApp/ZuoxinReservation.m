//
//  ZuoxinReservation.m
//  ZuoxinApp
//  key : d92a92eeaaf9a497bd3b11d086a5cc42
//  Created by 新工厂 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "ZuoxinReservation.h"
#import "UIBezierPath+BasicShapes.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomTextField.h"
#import "ZuoxinReservationDetail.h"
#import "TabBarController.h"
#import "zuoxin.h"
#import "UIAlertView+Animation.h"
#import "SIAlertView.h"




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

- (void)viewWillAppear:(BOOL)animated
{
    TabBarController *tabBarController = (TabBarController*)self.tabBarController;
    [tabBarController tabBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadCustomBar];
    [self loadMainView];
}


- (void)loadCustomBar
{
    self.navTitleLabel.text = @"预约多位司机";
    self.rightBtn.hidden = YES;

}

- (void)loadMainView
{
    //backgroundView
    self.view.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1];
    //uiscrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 47, 320, self.view.frame.size.height-47*2)];
    scrollView.tag = 998;
    scrollView.contentSize = CGSizeMake(320, self.view.frame.size.height-47*2+0.5);
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    //inputPhoneNumView
    UIView *inputPhoneNumView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 120)];
    inputPhoneNumView.backgroundColor = [UIColor whiteColor];
    [self setLayerCornerRadiusAndshadowInView:inputPhoneNumView];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 26)];
    label.text = @"  您的联系电话:";
    label.font = MediumFont;
    label.textColor = BlackFontColor;
    label.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.1];
    [inputPhoneNumView addSubview:label];
    
    _phoneNumField = [[CustomTextField alloc] initWithFrame:CGRectMake(8, 36, 284, 28)];
    _phoneNumField.font = MediumFont;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userPhoneNum  = [userDefaults objectForKey:@"UserPhoneNum"];
    if (userPhoneNum) {
        _phoneNumField.text = userPhoneNum;
        
    }
    else
    {
        _phoneNumField.placeholder = @"请输入11位手机号码"; 
    }
    _phoneNumField.borderStyle = UITextBorderStyleNone;
    _phoneNumField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumField.delegate = self;
    _phoneNumField.layer.borderWidth = 0.3f;
    _phoneNumField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _phoneNumField.layer.cornerRadius = 3.0f;
    
    [inputPhoneNumView addSubview:_phoneNumField];
    
    UIButton *verificationCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    verificationCodeBtn.frame = CGRectMake(6, 74, 288, 30);
    verificationCodeBtn.titleLabel.font = MediumFont;
    [verificationCodeBtn setTitle:@"获取手机验证码" forState:UIControlStateNormal];
    [verificationCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [verificationCodeBtn setBackgroundImage:BlueBtnBG forState:UIControlStateNormal];
    [verificationCodeBtn addTarget:self action:@selector(verificationCodeBtn) forControlEvents:UIControlEventTouchUpInside];
    [inputPhoneNumView addSubview:verificationCodeBtn];
    
    //VerificationView
    UIView *verificationView = [[UIView alloc] initWithFrame:CGRectMake(10, 140, 300, 120)];
    verificationView.backgroundColor = [UIColor whiteColor];
    [self setLayerCornerRadiusAndshadowInView:verificationView];
    
    UILabel *label_ = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 26)];
    label_.text = @"  输入您收到的验证码:";
    label_.font = MediumFont;
    label_.textColor = BlackFontColor;
    label_.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.1];
    [verificationView addSubview:label_];
    
    _verificationField = [[CustomTextField alloc] initWithFrame:CGRectMake(8, 36, 249, 28)];
    _verificationField.font = MediumFont;
    _verificationField.borderStyle = UITextBorderStyleNone;
    _verificationField.keyboardType = UIKeyboardTypeNumberPad;
    _verificationField.delegate = self;
    _verificationField.layer.borderWidth = 0.3f;
    _verificationField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _verificationField.layer.cornerRadius = 3.0f;
    _verificationField.returnKeyType = UIReturnKeyDone;
    [verificationView addSubview:_verificationField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame = CGRectMake(262, 36, 30, 28);
    doneBtn.titleLabel.font = SmallFont;
    doneBtn.layer.borderWidth = 0.3f;
    doneBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    doneBtn.layer.cornerRadius = 3.0f;
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:GrayFontColor forState:UIControlStateNormal];
    [doneBtn setTitleColor:GreenFontColor forState:UIControlStateHighlighted];
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [verificationView addSubview:doneBtn];
    
    
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(6, 74, 288, 30);
    confirmBtn.titleLabel.font = MediumFont;
    [confirmBtn setBackgroundImage:GeenBtnBG forState:UIControlStateNormal];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtn) forControlEvents:UIControlEventTouchUpInside];
    [verificationView addSubview:confirmBtn];
    
    [scrollView addSubview:inputPhoneNumView];
    [scrollView addSubview:verificationView];
    
}


#pragma mark - keyboardMethod


- (void)keyboardShow:(NSNotification *)aNotification
{
    if ([_phoneNumField isFirstResponder]) {
    }
    else
    {
        UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:998];
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.contentOffset = CGPointMake(0, 80);
        }];
    }
    
    
}

- (void)keyboardHidden:(NSNotification *)aNotification
{
    if (_doneInKeyboardBtn.superview) {
        [_doneInKeyboardBtn removeFromSuperview];
    }
    
    if ([_phoneNumField isFirstResponder]) {

    }
    else
    {
        UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:998];
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.contentOffset = CGPointMake(0, 0);
        }];
    }
    
}

- (void)keyboardResign
{
    [_phoneNumField resignFirstResponder];
    [_verificationField resignFirstResponder];
}

#pragma mark - textFiledDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger newLength = [textField.text length]  + string.length;

    NSCharacterSet *nonNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0 || [string isEqualToString:@""]) {
                
        if ([textField isEqual:_phoneNumField]) {
            if (newLength >11) {
                return NO;
            }
            return YES;
        }
        if ([textField isEqual:_verificationField]) {
            if (newLength <= 6) {
                return YES;
            }
            else
            {
                SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"验证码只能输入6位数字"];
                [self customAlertViewProperty:alertView andBlock:^{
                    [alertView dismissAnimated:YES];
                }];
            }
        }

    }
    else
    {
        if (newLength <=6) {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"请输入数字！"];
            [self customAlertViewProperty:alertView andBlock:^{
                [alertView dismissAnimated:YES];
            }];
        }
        else
        {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"请按确定！"];
            [self customAlertViewProperty:alertView andBlock:^{
                [alertView dismissAnimated:YES];
            }];
        }
        
        return NO;
    }
    return nil;
}


#pragma mark - btnClick

- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSPredicate *regexTestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    if ([regexTestMobile evaluateWithObject:mobileNum] == YES) {
        
        
        return YES;
    }
    else
    {
        
        return NO;
    }
}

- (void)verificationCodeBtn
{
    if ([self isMobileNumber:_phoneNumField.text]) {
        [_phoneNumField resignFirstResponder];
        
        @try {
            if (!self.server) {
                if (![self connected]) {
                    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"未能连上当前网络，请检查网络"];
                    [self customAlertViewProperty:alertView andBlock:^{
                        [alertView dismissAnimated:YES];
                    }];
                }
                else
                {
                    [self connectThriftServer];
                    [self.server getvalidatecode:[_phoneNumField.text longLongValue]];
                }
                
            }
            
            
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"验证码已发送"];
            [self customAlertViewProperty:alertView andBlock:^{
                [alertView dismissAnimated:YES];
            }];
        
        }
        @catch (RuntimeError *runtimeError) {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"runtime"];
            [self customAlertViewProperty:alertView andBlock:^{
                [alertView dismissAnimated:YES];
            }];
            NSLog(@"%d,%@",[runtimeError errornumber],[runtimeError errormessage]);
        }
        @catch (TException *texception) {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"出现异常"];
            [self customAlertViewProperty:alertView andBlock:^{
                [alertView dismissAnimated:YES];
            }];
            NSLog(@"%@",texception);
        }
        @finally {

        }
    
    }
    else
    {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"请输入正确的手机格式!"];
        [self customAlertViewProperty:alertView andBlock:^{
            [alertView dismissAnimated:YES];
        }];
        
        
    }
    
}

- (void)doneBtnClick
{
    [_verificationField resignFirstResponder];
}

- (void)confirmBtn
{
    [_verificationField resignFirstResponder];


    if ([self isMobileNumber:_phoneNumField.text]) {
        
        if (_verificationField.text == nil || [_verificationField.text isEqual:@""])
        {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"请输入验证码!"];
            [self customAlertViewProperty:alertView andBlock:^{
                [alertView dismissAnimated:YES];
            }];
        }
        else if (_verificationField.text.length < 6)
        {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"验证码必须为6位数"];
            [self customAlertViewProperty:alertView andBlock:^{
                [alertView dismissAnimated:YES];
            }];
        }
        else
        {
            @try {
//                [self.server loginforcustomer:[_phoneNumField.text longLongValue] validatecode:_verificationField.text token:[[NSUserDefaults standardUserDefaults] objectForKey:@"TokenKey"] devicetype:0];
                if (!self.server) {
                    [self connectThriftServer];
                }
               NSString *sessionID =  [self.server loginforcustomer:[_phoneNumField.text longLongValue] validatecode:_verificationField.text token:@"token" devicetype:0];
                NSLog(@"sessionId = %@",sessionID);
                
                //save user phoneNum
                [MyUserDefault setObject:_phoneNumField.text forKey:@"UserPhoneNum"];
                [MyUserDefault setObject:sessionID forKey:@"SessionID"];
              
                //alertView
                SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"验证成功"];
                [self customAlertViewProperty:alertView andBlock:^{
                    [alertView dismissAnimated:YES];
                    ZuoxinReservationDetail *reservationDetail = [[ZuoxinReservationDetail alloc] init];
                    
                    [self.navigationController pushViewController:reservationDetail animated:NO];
                }];
            }
            //catch the RuntimeError and TTransportException
            @catch (RuntimeError *runtimeError) {
                SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"用户验证失败!"];
                [self customAlertViewProperty:alertView andBlock:^{
                    [alertView dismissAnimated:YES];
                }];
            }
            @catch (TException *texception) {
                SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"出现异常"];
                [self customAlertViewProperty:alertView andBlock:^{
                    [alertView dismissAnimated:YES];
                }];
                NSLog(@"%@",texception);
            }
            
            @finally {
            }

        }

    }
    else
    {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"请输入正确的手机号码格式"];
        [self customAlertViewProperty:alertView andBlock:^{
            [alertView dismissAnimated:YES];
        }];
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_phoneNumField resignFirstResponder];
    [_verificationField resignFirstResponder];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
