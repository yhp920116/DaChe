//
//  ZuoxinReservationDetail.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-22.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "ZuoxinReservationDetail.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomTextField.h"
#import "TabBarController.h"
#import "SIAlertView.h"
#import "zuoxin.h"
#import "MyLabel.h"
#define SearchKey @"d92a92eeaaf9a497bd3b11d086a5cc42"


@interface ZuoxinReservationDetail ()
{
    CLLocation *_userLocation;
}

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


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadCustomBar];
    [self loadMainView];
}

- (void)viewWillAppear:(BOOL)animated
{
    TabBarController *tabBarController = (TabBarController*)self.tabBarController;
    [tabBarController tabBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    TabBarController *tabBarController = (TabBarController*)self.tabBarController;
    [tabBarController tabBarHidden:NO];
}

- (void)loadCustomBar
{
    //backgroundView
    self.rightBtn.hidden = YES;
    self.customBtn.hidden = YES;
    [self.backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navTitleLabel.text = @"预约多位司机";
}

- (void)loadMainView
{
    //backgroundView
    self.view.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 47, 320, self.view.frame.size.height-47*2)];
    scrollView.tag = 998;
    scrollView.contentSize = CGSizeMake(320, self.view.frame.size.height-47*2+0.5);
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    //inputPhoneNumView
    UIView *inputPhoneNumView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 72)];
    inputPhoneNumView.backgroundColor = [UIColor whiteColor];
    [self setLayerCornerRadiusAndshadowInView:inputPhoneNumView];
    [scrollView addSubview:inputPhoneNumView];
    
    MyLabel *label = [[MyLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 26)];
    label.text = @"  您的联系电话 *";
    label.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.1];
    [inputPhoneNumView addSubview:label];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userPhoneNum = [userDefaults objectForKey:@"UserPhoneNum"];
    UILabel *phoneNumLable = [[UILabel alloc] initWithFrame:CGRectMake(6, 36, 288, 30)];
    if (userPhoneNum) {
        phoneNumLable.text = userPhoneNum;
    }
    else phoneNumLable.text = @"";
    phoneNumLable.font = MediumFont;
    phoneNumLable.textColor = GrayFontColor;
    phoneNumLable.layer.borderWidth = 0.2f;
    phoneNumLable.layer.cornerRadius = 2.0f;
    phoneNumLable.layer.borderColor = [UIColor grayColor].CGColor;
    
    [inputPhoneNumView addSubview:phoneNumLable];
    
    //myCollapseClickView
//    _myCollapseClick = [[CollapseClick alloc] initWithFrame:CGRectMake(1,5,298,185)];
    UIView *detailView = [[UIView alloc] initWithFrame:CGRectMake(10, 92, 300, 195)];
    detailView.backgroundColor = [UIColor whiteColor];
    [self setLayerCornerRadiusAndshadowInView:detailView];
    [scrollView addSubview:detailView];
    
    MyLabel *timeTitle = [[MyLabel alloc] initWithFrame:CGRectMake(0, 5, 300, 26)];
    timeTitle.text = @"  您要求司机到达的时间 *";
    [self setLayerCornerRadiusAndshadowInView:timeTitle];
    [detailView addSubview:timeTitle];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 31, 288, 30)];
    _timeLabel.text = @"［30|60|90分钟后到］";
    _timeLabel.font = MediumFont;
    _timeLabel.textColor = GrayFontColor;
    _timeLabel.layer.borderWidth = 0.2f;
    _timeLabel.layer.cornerRadius = 2.0f;
    _timeLabel.layer.borderColor = [UIColor grayColor].CGColor;
    _timeLabel.userInteractionEnabled = YES;
    [detailView addSubview:_timeLabel];
    
    UIButton *popBtnOne = [UIButton buttonWithType:UIButtonTypeCustom];
    popBtnOne.frame = CGRectMake(258, 0, 30, 30);
    popBtnOne.backgroundColor = [UIColor clearColor];
    popBtnOne.tag = 0;
    [popBtnOne setImage:[UIImage imageNamed:@"popimg.png"] forState:UIControlStateNormal];
    [popBtnOne addTarget:self action:@selector(popBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_timeLabel addSubview:popBtnOne];
    
    MyLabel *driverCountTitle = [[MyLabel alloc] initWithFrame:CGRectMake(0, 61+5, 300, 26)];
    driverCountTitle.text = @"  您要预约的司机人数 *";
    [self setLayerCornerRadiusAndshadowInView:driverCountTitle];
    [detailView addSubview:driverCountTitle];
    
    _driverCountField = [[CustomTextField alloc] initWithFrame:CGRectMake(6, 92, 251, 30)];
    _driverCountField.font = BigFont;
    _driverCountField.textColor = GrayFontColor;
    _driverCountField.borderStyle = UITextBorderStyleNone;
    _driverCountField.keyboardType = UIKeyboardTypeNumberPad;
    _driverCountField.delegate = self;
    _driverCountField.layer.borderWidth = 0.2f;
    _driverCountField.layer.cornerRadius = 2.0f;
    _driverCountField.layer.borderColor = [UIColor grayColor].CGColor;
    [detailView addSubview:_driverCountField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame = CGRectMake(264, 92, 30, 30);
    doneBtn.titleLabel.font = SmallFont;
    doneBtn.layer.borderWidth = 0.3f;
    doneBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    doneBtn.layer.cornerRadius = 3.0f;
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:GrayFontColor forState:UIControlStateNormal];
    [doneBtn setTitleColor:GreenFontColor forState:UIControlStateHighlighted];
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [detailView addSubview:doneBtn];
    
    
    MyLabel *locationTitle = [[MyLabel alloc] initWithFrame:CGRectMake(0, 127, 300, 26)];
    locationTitle.text = @"  您的位置 *";
    [self setLayerCornerRadiusAndshadowInView:locationTitle];
    [detailView addSubview:locationTitle];
    
    _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 153, 288, 30)];
    _locationLabel.text = [userDefaults objectForKey:@"UserAddress"];
    _locationLabel.font = MediumFont;
    _locationLabel.textColor = GrayFontColor;
    _locationLabel.layer.borderWidth = 0.2f;
    _locationLabel.layer.cornerRadius = 2.0f;
    _locationLabel.layer.borderColor = [UIColor grayColor].CGColor;
    _locationLabel.userInteractionEnabled = YES;
    [detailView addSubview:_locationLabel];
    
    UIButton *popBtnThree = [UIButton buttonWithType:UIButtonTypeCustom];
    popBtnThree.backgroundColor = [UIColor whiteColor];
    popBtnThree.frame = CGRectMake(258, 0, 30, 30);
    popBtnThree.contentMode = UIViewContentModeScaleAspectFit;
    popBtnThree.tag = 2;
    [popBtnThree setImage:[UIImage imageNamed:@"locationimg_r.png"] forState:UIControlStateNormal];
    [popBtnThree addTarget:self action:@selector(popBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_locationLabel addSubview:popBtnThree];
    
    
    //confirmButton
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(10, 297, 300, 30);
    confirmBtn.titleLabel.font = BigFont;
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn setBackgroundImage:GeenBtnBG forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtn) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:confirmBtn];
}


#pragma mark - textFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *nonNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0 || [string isEqualToString:@""]) {
        NSLog(@"%d",textField.text.length);
        NSLog(@"%d",range.length);
        NSLog(@"%d",string.length);
        if ((textField.text.length -range.length)+ string.length >=3) {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"....你确定你不是来恶搞的？"];
            [self customAlertViewProperty:alertView andBlock:^{
                [alertView dismissAnimated:YES];
            }];
        }
        
        return YES;
    }
    else
    {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"请输入数字"];
        [self customAlertViewProperty:alertView andBlock:^{
            [alertView dismissAnimated:YES];
        }];
        return NO;
    }
}

#pragma mark - keyboard responder

- (void)keyboardShow:(NSNotification *)aNotification
{
    NSDictionary *info = [aNotification userInfo];
    //get the height of keyboard
    NSValue *value = [info objectForKey:@"UIKeyboardBoundsUserInfoKey"];
    CGSize keyboardSize = [value CGRectValue].size;
    NSLog(@"%f",self.view.frame.size.height);
    NSLog(@"%f",keyboardSize.height);
    if (self.view.frame.size.height-keyboardSize.height < 241+40) {
        UIScrollView *scrollView = (UIScrollView*)[self.view viewWithTag:998];
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.contentOffset = CGPointMake(0, 140);
        }];
    }

}

- (void)keyboardHidden:(NSNotification *)aNotification
{
    UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:998];
    [UIView animateWithDuration:0.3 animations:^{
        scrollView.contentOffset = CGPointMake(0, 0);
    }];

}


#pragma mark - btnClick

- (void)popBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"请选择" andMessage:nil];
    alertView.titleFont = [UIFont systemFontOfSize:14.0f];
    alertView.titleColor = [UIColor grayColor];
    
    switch (btn.tag) {
        case 0:
        {
            [alertView addButtonWithTitle:@"30分钟" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                _timeLabel.text = @"  30分钟";
            }];
            [alertView addButtonWithTitle:@"60分钟" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                _timeLabel.text = @"  60分钟";
            }];
            [alertView addButtonWithTitle:@"90分钟" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                _timeLabel.text = @"  90分钟";
            }];
            [alertView show];
            break;
        }
        case 1:
        {
            [_driverCountField resignFirstResponder];
            break;
        }
        case 2:
        {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            _locationLabel.text = [userDefaults objectForKey:@"UserAddress"];
            break;
        }
    }
}

- (void)doneBtnClick
{
    [_driverCountField resignFirstResponder];
}

- (void)confirmBtn
{
    [_driverCountField resignFirstResponder];
    if ([_driverCountField.text intValue] < 2 ||[_driverCountField.text intValue] > 20)
    {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"预约的司机人数不科学"];
        [self customAlertViewProperty:alertView andBlock:^{
            [alertView dismissAnimated:YES];
        }];
    }
    else {
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
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    locationinfo *userLocationInfo = [userDefaults objectForKey:@"UserLocationInfo"];
                    
                    [self.server orderdrivers:nil mobile:[userDefaults objectForKey:@"UserPhoneNum"] location:userLocationInfo reachtime:[_timeLabel.text intValue]*60 count:[_driverCountField.text intValue]];
                }
            }

            
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"订单提交成功"];
            [self customAlertViewProperty:alertView andBlock:^{
                [alertView dismissAnimated:YES];
            }];
        }
        @catch (RuntimeError *runtimeError) {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:[runtimeError errormessage]];
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
}

- (void)backBtnClick
{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
