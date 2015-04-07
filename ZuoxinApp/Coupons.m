//
//  Coupons.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-9-9.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "Coupons.h"
#import "CustomTextField.h"
#import <QuartzCore/QuartzCore.h>
#import "zuoxin.h"
#import "SIAlertView.h"

@interface Coupons ()

@end

@implementation Coupons

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
	// Do any additional setup after loading the view.
}

- (void)loadCustomBar
{
    self.rightBtn.hidden = YES;
    self.customBtn.hidden = YES;
    self.navTitleLabel.text = @"优惠卷";
}

- (void)loadMainView
{
    //backgroundView
    self.view.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1];
    
    //scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 47, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+0.5);
    [self.view addSubview:scrollView];
    
    //inputView
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 134)];
    inputView.backgroundColor = [UIColor whiteColor];
    [self setLayerCornerRadiusAndshadowInView:inputView];
    [scrollView addSubview:inputView];
    
    UILabel *couponslabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 12)];
    couponslabel.text = @"请输入优惠卷号码";
    couponslabel.font = MediumFont;
    couponslabel.backgroundColor = [UIColor clearColor];
    couponslabel.textColor = BlackFontColor;
    [inputView addSubview:couponslabel  ];
    
    _couponsNumField = [[CustomTextField alloc] initWithFrame:CGRectMake(8, 30, 284, 30)];
    _couponsNumField.font = MediumFont;
    _couponsNumField.borderStyle = UITextBorderStyleNone;
    _couponsNumField.keyboardType = UIKeyboardTypeNumberPad;
    _couponsNumField.delegate = self;
    _couponsNumField.layer.borderWidth = 0.3f;
    _couponsNumField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _couponsNumField.layer.cornerRadius = 3.0f;
    [inputView addSubview:_couponsNumField];
    
    UILabel *phonelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 74, 300, 12)];
    phonelabel.text = @"请输入您的手机号码";
    phonelabel.font = MediumFont;
    phonelabel.backgroundColor = [UIColor clearColor];
    phonelabel.textColor = BlackFontColor;
    [inputView addSubview:phonelabel];
    
    _phoneFiled = [[CustomTextField alloc] initWithFrame:CGRectMake(8, 94, 284, 30)];
    _phoneFiled.font = MediumFont;
    _phoneFiled.placeholder = @"请输入11位手机号码";
    _phoneFiled.borderStyle = UITextBorderStyleNone;
    _phoneFiled.keyboardType = UIKeyboardTypeNumberPad;
    _phoneFiled.delegate = self;
    _phoneFiled.layer.borderWidth = 0.3f;
    _phoneFiled.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _phoneFiled.layer.cornerRadius = 3.0f;
    [inputView addSubview:_phoneFiled];
    
    //confirmBtn
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(10, 154, 300, 30);
    confirmBtn.titleLabel.font = BigFont;
    [confirmBtn setBackgroundImage:GeenBtnBG forState:UIControlStateNormal];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtn) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:confirmBtn];
    
    
    //tipsView
    UIView *tipsView = [[UIView alloc] initWithFrame:CGRectMake(10, 194, 300, 160)];
    tipsView.backgroundColor = [UIColor whiteColor];
    [self setLayerCornerRadiusAndshadowInView:tipsView];
    [scrollView addSubview:tipsView];
    
    UILabel *tipsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 26)];
    tipsTitleLabel.text = @"    温馨提示";
    tipsTitleLabel.font = MediumFont;
    tipsTitleLabel.textColor = BlackFontColor;
    tipsTitleLabel.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.1];
    [tipsView addSubview:tipsTitleLabel];
    
    
    float labelHeight = 0.0;
    for (NSInteger i = 0 ; i < 4; i++) {
        UILabel *TipsLabel = [[UILabel alloc] init];
        TipsLabel.font = SmallFont;
        TipsLabel.textColor = GrayFontColor;
        TipsLabel.numberOfLines = 0;
        switch (i) {
            case 0:
            {
                TipsLabel.text = @"1.您可以通过李司机代驾发放的优惠卷或者短信获取优惠券号码。";
                break;
            }
            case 1:
            {
                TipsLabel.text = @"2.一个手机只能使用一次优惠卷。";
                break;
            }
            case 2:
            {
                TipsLabel.text = @"3.优惠卷激活充值成功后，只能通过App呼叫司机使用代驾，该优惠卷即可立即生效。";
                break;
            }
            case 3:
            {
                TipsLabel.text = @"4.优惠卷使用最终解释权归李司机代驾所有，如有疑问请拨打400-222-222咨询。";
                break;
            }
        }
        
        CGSize size = CGSizeMake(280, 1000);
        CGSize oneTipsSize = [TipsLabel.text sizeWithFont:TipsLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        TipsLabel.frame = CGRectMake(10, 10+26+labelHeight, oneTipsSize.width, oneTipsSize.height);
        labelHeight = labelHeight+(oneTipsSize.height+8);
        [tipsView addSubview:TipsLabel];
    }
    
}

#pragma mark - keyboardResign

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_couponsNumField resignFirstResponder];
    [_phoneFiled resignFirstResponder];
}

#pragma mark - textFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *nonNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0 || [string isEqualToString:@""]) {
        NSUInteger newLength = textField.text.length + string.length;
        if ([textField isEqual:_couponsNumField]) {
            if (newLength > 8) {
                SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"优惠码只能输是8位数.."];
                [self customAlertViewProperty:alertView andBlock:^{
                    [alertView dismissAnimated:YES];
                }];
                return NO;
            }
            else return YES;
        }
        if ([textField isEqual:_phoneFiled]) {
            if (newLength > 11) {
                return NO;
            }
            return YES;
        }
    }
    else
    {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"请输入数字"];
        [self customAlertViewProperty:alertView andBlock:^{
            [alertView dismissAnimated:YES];
        }];
        return NO;
    }
    
    return nil;
}

#pragma mark - ConfirmBtn

- (void)confirmBtn
{
    //vertificate coupons
    if (_couponsNumField.text == nil || [_couponsNumField.text isEqual:@""]) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"请输入优惠卷号码"];
        [self customAlertViewProperty:alertView andBlock:^{
            [alertView dismissAnimated:YES];
        }];
    }
    else if (![self isMobileNumber:_phoneFiled.text]) {
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"请输入正确的手机号码格式"];
        [self customAlertViewProperty:alertView andBlock:^{
            [alertView dismissAnimated:YES];
        }];
    }
    else
    {
        [_phoneFiled resignFirstResponder];
        
        @try {
            [self.server getvalidatecode:[_phoneFiled.text intValue]];
            
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"优惠卷激活成功"];
            [self customAlertViewProperty:alertView andBlock:^{
                [alertView dismissAnimated:YES];
            }];
        }
        //catch the RuntimeError and TTransportException
        @catch (RuntimeError *runtimeError) {

            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"优惠卷验证失败"];
            [self customAlertViewProperty:alertView andBlock:^{
                [alertView dismissAnimated:YES];
            }];
            NSLog(@"%d,%@",[runtimeError errornumber],[runtimeError errormessage]);
        }
        @catch (TException *texception) {
            NSLog(@"%@",texception);
        }
        
        @finally {
        }

    }
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
