//
//  ZuoxinQueryFare.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "ZuoxinQueryFare.h"
#import "BackBtn.h"
#import "CustomBtn.h"
#import "THTTPClient.h"
#import "TBinaryProtocol.h"
#import "zuoxin.h"
#import "DPMeterView.h"
#import "UIBezierPath+BasicShapes.h"

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

- (void)loadFareData
{    
    NSDictionary *priceDic = [self.server getpricelist:1];
    NSLog(@"%@",priceDic);
}

- (void)loadCustomBar
{
    self.navTitleLabel.text = @"价格表";
    self.backBtn.hidden = YES;
    [self.customBtn setTitle:@"优惠卷" forState:UIControlStateNormal];
    [self.customBtn addTarget:self action:@selector(customBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)customBtnClick:(id)sender
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadFareData];
    [self loadCustomBar];
    
    DPMeterView *starView = [[DPMeterView alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
    //important
    [starView setMeterType:DPMeterTypeLinearHorizontal];

    [starView setShape:[UIBezierPath stars:5 shapeInFrame:CGRectMake(10,300, 150,30)].CGPath];
    [starView setTrackTintColor:[UIColor lightGrayColor]];
    
    [starView setProgressTintColor:[UIColor darkGrayColor]];
    [starView add:0.5 animated:YES];
    starView.progressTintColor = [UIColor colorWithRed:255/255.f green:199/255.f blue:87/255.f alpha:1.f];
    [starView setGradientOrientationAngle:2*M_PI];
    [self.view addSubview:starView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
