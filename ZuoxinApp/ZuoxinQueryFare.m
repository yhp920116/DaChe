//
//  ZuoxinQueryFare.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "ZuoxinQueryFare.h"
#import "THTTPClient.h"
#import "TBinaryProtocol.h"
#import "zuoxin.h"
#import "DPMeterView.h"
#import "UIBezierPath+BasicShapes.h"
#import <QuartzCore/QuartzCore.h>
#import "TTransportException.h"
#import "Coupons.h"
#import "SIAlertView.h"

@interface ZuoxinQueryFare ()

@end

@implementation ZuoxinQueryFare

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
    [self performSelectorInBackground:@selector(loadFareData) withObject:nil];

}

#pragma mark - loadData

- (void)loadFareData
{
    @try {
        [self connectThriftServer];
        
        _cityDic = [self.server getcitylist];
        
        NSArray *cityKeys = [_cityDic allKeys];
                
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *userCity = [userDefaults objectForKey:@"UserCity"];
        NSLog(@"%@",userCity);
        NSLog(@"%@",_cityDic);

        
        for (NSNumber *cityKey in cityKeys) {
            
            NSString *city = [[_cityDic objectForKey:cityKey] stringByAppendingFormat:@"市"];
            if ([userCity isEqualToString:city]) {
                _priceDic = [self.server getpricelist:[cityKey intValue]];
                _cityLabel.text = [_cityDic objectForKey:cityKey];
            }
            else                                                                
            {
                _priceDic = [self.server getpricelist:12];
                _cityLabel.text = [_cityDic objectForKey:[NSNumber numberWithInt:12]];
            }
        }
        
    [self performSelectorOnMainThread:@selector(reloadPriceData) withObject:nil waitUntilDone:NO];
    }
    @catch (RuntimeError *runtimeError) {
        NSLog(@"%@",runtimeError);
    }
    @catch (TTransportException *transportException) {
        NSLog(@"%@",transportException);
    }
    @finally {
        
    }
    
}

- (void)reloadPriceData
{
    for (int i = 1; i < 5; i++) {
        UIView *cell = (UIView *)[_priceDetailView viewWithTag:2009+i];
        UILabel *rightLabel = (UILabel *)[cell viewWithTag:92];
        rightLabel.text = [[NSString alloc] initWithFormat:@"%@元",[_priceDic objectForKey:[NSNumber numberWithInteger:i-1]]];
    }

}

#pragma mark - loadCustomBar

- (void)loadCustomBar
{
    self.view.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1];
    
    self.navTitleLabel.text = @"价格表";
    CGRect navTitleLabelRect = self.navTitleLabel.frame;
    navTitleLabelRect.origin.x = -10;
    self.navTitleLabel.frame = navTitleLabelRect;
    
    
    _cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 22, 20, 10)];
    _cityLabel.textColor = [UIColor whiteColor];
    _cityLabel.backgroundColor = [UIColor clearColor];
    _cityLabel.font = [UIFont systemFontOfSize:10.0f];
    UIImageView *navBar = (UIImageView *)[self.view viewWithTag:10001];
    [navBar addSubview:_cityLabel];
    
    UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseBtn.backgroundColor = [UIColor clearColor];
    chooseBtn.frame = CGRectMake(184, 6, 50, 40);
    [chooseBtn setImage:[UIImage imageNamed:@"citybtnImg.png"] forState:UIControlStateNormal];
    [chooseBtn addTarget:self action:@selector(chooseCityBtn) forControlEvents:UIControlEventTouchUpInside];
    [navBar addSubview:chooseBtn];
    
    
    self.backBtn.hidden = YES;
    self.customBtn.hidden = YES;
    
    UIImage *couponsImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"coupons@2x" ofType:@"png"]];
    self.rightBtn.frame = CGRectMake(310-92/2-10, 0, 92/2+20, 47);
    [self.rightBtn setImage:couponsImg forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(couponsBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - loadMainView
- (void)loadMainView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 47, self.view.frame.size.width, self.view.frame.size.height-47*2)];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-47*2+0.5);
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    //priceDetailView
    _priceDetailView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 208)];
    _priceDetailView.backgroundColor = [UIColor whiteColor];
    [self setLayerCornerRadiusAndshadowInView:_priceDetailView];
    [scrollView addSubview:_priceDetailView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 26)];
    titleLabel.text = @"    代驾服务价格表";
    titleLabel.font = MediumFont;
    titleLabel.textColor = BlackFontColor;
    titleLabel.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.1];
    [_priceDetailView addSubview:titleLabel];
    
    for (NSInteger i = 0; i < 5; i++) {
        //cell
        UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(0, 26+36*i, 300, 36)];
        cell.tag = 2009+i;
        cell.backgroundColor = [UIColor whiteColor];
        [_priceDetailView addSubview:cell];
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, 110, 12)];
        rightLabel.backgroundColor = [UIColor clearColor];
        rightLabel.font = MediumFont;
        rightLabel.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:rightLabel];
        
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 12, 150, 12)];
        leftLabel.tag = 92;
        
        leftLabel.backgroundColor = [UIColor clearColor];
        leftLabel.font = MediumFont;
        leftLabel.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:leftLabel];
        
        UIImageView *separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35, 300, 1)];
        separatorLine.image = [UIImage imageNamed:@"separator.png"];
        [cell addSubview:separatorLine];
        
        switch (i) {
            case 0:
            {
                rightLabel.text = @"时间段";
                rightLabel.textColor = GreenFontColor;
                leftLabel.text = @"起步价（10公里以内）";
                leftLabel.textColor = GreenFontColor;
                break;
            }
            case 1:
            {
                rightLabel.text = @"07:00-21:59";
                rightLabel.textColor = GrayFontColor;
                leftLabel.text = [[NSString alloc] initWithFormat:@"%@元",[_priceDic objectForKey:[NSNumber numberWithInteger:i-1]]];
                leftLabel.textColor = GrayFontColor;
                
                break;
            }
            case 2:
            {
                rightLabel.text = @"22:00-22:59";
                rightLabel.textColor = GrayFontColor;
                leftLabel.text = [[NSString alloc] initWithFormat:@"%@元",[_priceDic objectForKey:[NSNumber numberWithInteger:i-1]]];
                leftLabel.textColor = GrayFontColor;
                break;
            }
            case 3:
            {
                rightLabel.text = @"23:00-23:59";
                rightLabel.textColor = GrayFontColor;
                leftLabel.text = [[NSString alloc] initWithFormat:@"%@元",[_priceDic objectForKey:[NSNumber numberWithInteger:i-1]]];
                leftLabel.textColor = GrayFontColor;
                break;
            }
            case 4:
            {
                rightLabel.text = @"00:00-26:59";
                rightLabel.textColor = GrayFontColor;
                leftLabel.text = [[NSString alloc] initWithFormat:@"%@元",[_priceDic objectForKey:[NSNumber numberWithInteger:i-1]]];
                leftLabel.textColor = GrayFontColor;
                [separatorLine removeFromSuperview];
                break;
            }
        }
    }
    
    //tipsView
    UIView *tipsView = [[UIView alloc] initWithFrame:CGRectMake(10, 228, 300, 110)];
    tipsView.backgroundColor = [UIColor whiteColor];
    [self setLayerCornerRadiusAndshadowInView:tipsView];
    [scrollView addSubview:tipsView];
    
    UILabel *tipsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 26)];
    tipsTitleLabel.text = @"    温馨提示";
    tipsTitleLabel.font = MediumFont;
    tipsTitleLabel.textColor = BlackFontColor;
    tipsTitleLabel.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.1];
    [tipsView addSubview:tipsTitleLabel];
    
    UILabel *firstTips = [[UILabel alloc] init];
    firstTips.font = SmallFont;
    firstTips.textColor = GrayFontColor;
    firstTips.numberOfLines = 0;
    firstTips.text = @"1. 不同时间段的代驾起步费用以约定时间为准，默认最短约定时间为客户呼叫时间延后20分钟。";
    CGSize size = CGSizeMake(280, 1000);
    CGSize oneTipsSize = [firstTips.text sizeWithFont:firstTips.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    firstTips.frame = CGRectMake(10, 10+26, oneTipsSize.width, oneTipsSize.height);
    [tipsView addSubview:firstTips];
    
    UILabel *secondTips = [[UILabel alloc] init];
    secondTips.font = SmallFont;
    secondTips.textColor = GrayFontColor;
    secondTips.numberOfLines = 0;
    secondTips.text = @"2. 不同时间段的代驾起步费用以约定时间为准，默认最短约定时间为客户呼叫时间延后20分钟。";
    CGSize secondTipsSize = [secondTips.text sizeWithFont:secondTips.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    secondTips.frame = CGRectMake(10, 36+oneTipsSize.height+8, secondTipsSize.width, secondTipsSize.height);
    [tipsView addSubview:secondTips];
    
}


#pragma mark - BtnClick

- (void)chooseCityBtn
{
    @try {
        _cityDic = [self.server getcitylist];
        NSArray *cityID = [_cityDic allKeys];
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"请选择" andMessage:nil];
        alertView.titleFont = [UIFont systemFontOfSize:14.0f];
        alertView.titleColor = [UIColor grayColor];
        
        for (NSNumber *cID in cityID) {
            
            [alertView addButtonWithTitle:[_cityDic objectForKey:cID] type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
                _cityLabel.text = [_cityDic objectForKey:cID];
                
                @try {
                    NSMutableDictionary *priceDic = [self.server getpricelist:[cID intValue]];
                    _priceDic = priceDic;
                    for (int i = 1; i < 5; i++) {
                        UIView *cell = (UIView *)[_priceDetailView viewWithTag:2009+i];
                        UILabel *rightLabel = (UILabel *)[cell viewWithTag:92];
                        rightLabel.text = [[NSString alloc] initWithFormat:@"%@元",[_priceDic objectForKey:[NSNumber numberWithInteger:i-1]]];
                    }
                    
                }
                @catch (RuntimeError *runtimeError) {
                    NSLog(@"%@",runtimeError);
                }
                @catch (TTransportException *transportException) {
                    NSLog(@"%@",transportException);
                }
                @finally {
                    
                }
            }];
        }

        [alertView show];
    }
    @catch (RuntimeError *runtimeError) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"网络连接失败"];
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

- (void)couponsBtnClick
{
    Coupons *coupon = [[Coupons alloc] init];
    [self.navigationController pushViewController:coupon animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
