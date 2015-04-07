//
//  ZuoxinMyInfo.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-9-16.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "ZuoxinMyInfo.h"
#import <QuartzCore/QuartzCore.h>
#import "SIAlertView.h"

@interface ZuoxinMyInfo ()

@end

@implementation ZuoxinMyInfo

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
    [self registerNetworkNotification];
    [self loadCustomerBar];
    
    
}

#pragma mark - observe the network condition

-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    //remove subviews
    for (int i = 1; i <= [self.view subviews].count-1; i++) {
        [[[self.view subviews] objectAtIndex:i] removeFromSuperview];
    }
    
    if([reach isReachable])
    {
        [self loadMainView];
        [self performSelectorInBackground:@selector(loadData) withObject:nil];
        
    }
    else
    {
        [self loadUnconnectedView];
    }
}

- (void)loadData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    @try {
        if ([userDefaults objectForKey:@"UserPhoneNum"]) {
            [self connectThriftServer];
            _customer = [[Customer alloc] init];
            _customer = [self.server getcustomerinfo:[[userDefaults objectForKey:@"UserPhoneNum"] longLongValue]];

            
            [self performSelectorOnMainThread:@selector(reloadMyInfo) withObject:nil waitUntilDone:YES];
        }
    }
    @catch (RuntimeError *runtimeError) {
       
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

- (void)loadCustomerBar
{
    self.rightBtn.hidden = YES;
    self.navTitleLabel.text = @"我的信息";
}

- (void)loadMainView
{
   self.view.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 47, 320, self.view.frame.size.height-47)];
    scrollView.contentSize = CGSizeMake(320, self.view.frame.size.height-47+0.5);
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    _myInfoView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 250)];
    _myInfoView.backgroundColor = [UIColor whiteColor];
    [self setLayerCornerRadiusAndshadowInView:_myInfoView];
    [scrollView addSubview:_myInfoView];
    
    for (int i = 0; i < 7 ; i++) {
        UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 20+32*i, 72, 12.0f)];
        labelTitle.font = [UIFont systemFontOfSize:12.0f];
        labelTitle.textAlignment = NSTextAlignmentRight;
        labelTitle.textColor = [UIColor colorWithRed:90.0/255.0 green:156.0/255.0 blue:0 alpha:1];
        [_myInfoView addSubview:labelTitle];
        
        UILabel *labelContent = [[UILabel alloc] initWithFrame:CGRectMake(105, 20+32*i, 300-105, 12.0f)];
        labelContent.tag = 2009+i;
        labelContent.font = [UIFont systemFontOfSize:12.0f];
        labelContent.textAlignment = NSTextAlignmentLeft;
        labelContent.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        [_myInfoView addSubview:labelContent];
        
        
        switch (i) {
            case 0:
            {
                labelTitle.text = @"姓名";
                break;
            }
            case 1:
            {
                labelTitle.text = @"性别";
                break;
            }
            case 2:
            {
                labelTitle.text = @"手机号码";
                break;
            }
            case 3:
            {
                labelTitle.text = @"顾客类型";
                break;
            }
            case 4:
            {
                labelTitle.text = @"充值帐户";
                break;
            }
            case 5:
            {
                labelTitle.text = @"优惠卷帐户";
                break;
            }
            case 6:
            {
                labelTitle.text = @"副手机号码";
                break;
            }
        }
        
    }
    
}

- (void)reloadMyInfo
{
    for (int i = 0; i < 7; i++) {
        UILabel *label = (UILabel *)[_myInfoView viewWithTag:2009+i];
        switch (i) {
            case 0:
            {
                label.text = [_customer valueForKey:@"customername"];
                break;
            }
            case 1:
            {
                switch ([[_customer valueForKey:@"sex"] intValue]) {
                    case 0:
                    {
                        label.text = @"男";
                        break;
                    }
                    case 1:
                    {
                        label.text = @"女";
                        break;
                    }
                }
                break;
            }
            case 2:
            {
                label.text = [[NSString alloc] initWithFormat:@"%lld",[[_customer valueForKey:@"customermobile"] longLongValue]] ;
                break;
            }
            case 3:
            {
                switch ([[_customer valueForKey:@"customertype"] integerValue]) {
                    case 0:
                    {
                        label.text = @"普通用户";
                        break;
                    }
                    case 1:
                    {
                        label.text = @"VIP";
                        break;
                    }
                }
                break;
            }
            case 4:
            {
                label.text = [[NSString alloc] initWithFormat:@"%f元",[[_customer valueForKey:@"amount"] doubleValue]];
                break;
            }
            case 5:
            {
                label.text = [[NSString alloc] initWithFormat:@"%f元",[[_customer valueForKey:@"coupon"] doubleValue]];
                break;
            }
            case 6:
            {
                label.text = [[NSString alloc] initWithFormat:@"%f元",[[_customer valueForKey:@"othermobiles"] doubleValue]];
                break;
            }
        }
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
