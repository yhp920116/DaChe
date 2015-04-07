//
//  ZuoxinMore.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "ZuoxinMore.h"
#import "ZuoxinDriverInfo.h"
#import "SIAlertView.h"
#import "ZuoxinAboutUs.h"
#import "ZuoxinFeedBack.h"
#import "ZuoxinDelegateProtocol.h"


@interface ZuoxinMore ()

@end

@implementation ZuoxinMore

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
    [self setTabBarHidden:NO];
    [self loadCustomerLoginState];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadCustomBar];
    [self loadMainView]; 
}

- (void)loadCustomBar
{
    self.navTitleLabel.text = @"更多";
    self.backBtn.hidden = YES;
    self.customBtn.hidden = YES;
}

- (void)loadMainView
{
    
   self.view.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 47, self.view.frame.size.width, self.view.frame.size.height-47*2)];
    scrollView.tag = 998;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-47*2+0.5);
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    
    static NSInteger btnTag = 0;
    
    for (NSInteger i = 0; i < 3; i++) {
        
        UIView *fieldView = [[UIView alloc] initWithFrame:CGRectMake(10, 71*i+10*(i+1), 300, 71)];
        fieldView.backgroundColor = [UIColor whiteColor];
        [self setLayerCornerRadiusAndshadowInView:fieldView];
        [scrollView addSubview:fieldView];
        
       
        
        for (NSInteger j = 0; j < 2; j++) {
            
            UIButton *cellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            cellBtn.tag = btnTag;
            btnTag++;
            cellBtn.frame = CGRectMake(0, 0+35*j+1*j, 300, 35);
            [cellBtn addTarget:self action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cellBtn setBackgroundImage:[UIImage imageNamed:@"rendering.png"] forState:UIControlStateHighlighted];
            [fieldView addSubview:cellBtn];
            
            UILabel *rightLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 11.5, 200, 12)];
            rightLable.backgroundColor = [UIColor clearColor];
            rightLable.font = MediumFont;
            rightLable.textColor = BlackFontColor;
            [cellBtn addSubview:rightLable];
            
            UIImageView *accessoyView = [[UIImageView alloc] initWithFrame:CGRectMake(280, 10.75, 13.5, 13.5)];
            accessoyView.image = [UIImage imageNamed:@"rightarrow@2x.png"];
            [cellBtn addSubview:accessoyView];
            
            
            switch (i) {
                case 0:
                {
                    if (j == 0) {
                        rightLable.text = @"我的代驾";
                        UIImageView *separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 34, 300, 1)];
                        separatorLine.image = [UIImage imageNamed:@"separator@2x.png"];
                        [fieldView addSubview:separatorLine];
                    }
                    if (j == 1) {
                        rightLable.text = @"委托代驾服务协议";
            
                    }
                    break;
                }
                case 1:
                {
                    if (j == 0) {
                        rightLable.text = @"意见反馈";
                        UIImageView *separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 34, 300, 1)];
                        separatorLine.image = [UIImage imageNamed:@"separator@2x.png"];
                        [fieldView addSubview:separatorLine];
                    }
                    if (j == 1) {
                        rightLable.text = @"客户热线";
                        UILabel *callLable = [[UILabel alloc] initWithFrame:CGRectMake(200, 11.5, 100, 12)];
                        callLable.font = MediumFont;
                        callLable.backgroundColor = [UIColor clearColor];
                        callLable.textColor = GreenFontColor;
                        callLable.text = @"400-123-232";
                        [cellBtn addSubview:callLable];
                    }
                    break;
                }
                case 2:
                {
                    if (j == 0) {
                        rightLable.text = @"版本检测";
                        UIImageView *separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 34, 300, 1)];
                        separatorLine.image = [UIImage imageNamed:@"separator@2x.png"];
                        [fieldView addSubview:separatorLine];
                    }
                    if (j == 1) {
                        rightLable.text = @"关于我们";
                    }
                    break;
                }
            }
            
        }
        
        
    }
    
}

- (void)loadCustomerLoginState
{
    UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:998];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"SessionID"]) {
        if (_logOffBtn) {
            [_logOffBtn removeFromSuperview];
            _logOffBtn = nil;
        }
        _logOffBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _logOffBtn.titleLabel.font = BigFont;
        _logOffBtn.opaque = YES;
        _logOffBtn.frame = CGRectMake(10, 253, 300, 30);
        [_logOffBtn setBackgroundImage:RedBtnBG forState:UIControlStateNormal];
        [_logOffBtn setTitle:@"退出登陆" forState:UIControlStateNormal];
        [_logOffBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_logOffBtn addTarget:self action:@selector(logOffBtn) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:_logOffBtn];
    }
}

#pragma mark - cellBtnClick

- (void)cellBtnClick:(id)sender
{
    UIButton *cellBtn = (UIButton *)sender;
    switch (cellBtn.tag) {
        case 0:
        {
            ZuoxinDriverInfo *driverInfo = [[ZuoxinDriverInfo alloc] init];
            [self.navigationController pushViewController:driverInfo animated:NO];
            break;
        }
        case 1:
        {
            ZuoxinDelegateProtocol *zuoxinProtocol = [[ZuoxinDelegateProtocol alloc] init];
            [self.navigationController pushViewController:zuoxinProtocol animated:NO];
             NSLog(@"%d",cellBtn.tag);
            break;
        }
        case 2:
        {
            ZuoxinFeedBack *feedBack = [[ZuoxinFeedBack alloc] init];
            [self.navigationController pushViewController:feedBack animated:NO];
             NSLog(@"%d",cellBtn.tag);
            break;
        }
        case 3:
        {
             NSLog(@"%d",cellBtn.tag);
            break;
        }
        case 4:
        {
             NSLog(@"%d",cellBtn.tag);
            break;
        }
        case 5:
        {
            ZuoxinAboutUs *aboutUs = [[ZuoxinAboutUs alloc] init];
            [self.navigationController pushViewController:aboutUs animated:NO];
            NSLog(@"%d",cellBtn.tag);
            break;
        }
    }
}

- (void)logOffBtn
{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"确定要退出登陆？"];
    alertView.messageFont = [UIFont systemFontOfSize:14.0f];
    alertView.messageColor = [UIColor grayColor];
    alertView.buttonFont = [UIFont systemFontOfSize:14.0f];
    
    
    [alertView addButtonWithTitle:@"取消" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
        [alertView dismissAnimated:YES];
    }];
    
    [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults removeObjectForKey:@"SessionID"];
        [_logOffBtn removeFromSuperview];
        [alertView dismissAnimated:YES];
    }];
    
    [alertView show];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
