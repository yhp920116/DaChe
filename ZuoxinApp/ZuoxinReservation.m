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
#import "DPMeterView.h"
#import "UIBezierPath+BasicShapes.h"
#import <QuartzCore/QuartzCore.h>

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadCustomBar];
    [self.starsView setMeterType:DPMeterTypeLinearHorizontal];
    //    [self.shape4View setShape:[UIBezierPath stars:3 shapeInFrame:self.shape4View.frame].CGPath];
    
    self.starsView = [[DPMeterView alloc] initWithFrame:CGRectMake(10, 20, 80, 20)];
    [[DPMeterView appearance] setTrackTintColor:[UIColor lightGrayColor]];
    [[DPMeterView appearance] setProgressTintColor:[UIColor darkGrayColor]];
    [self.starsView setShape:[UIBezierPath stars:5 shapeInFrame:CGRectMake(10, 20, 80, 20)].CGPath];
    self.starsView.progressTintColor = [UIColor colorWithRed:255/255.f green:199/255.f blue:87/255.f alpha:1.f];
    [self.starsView add:0.5 animated:YES];
    [self.starsView setGradientOrientationAngle:2*M_PI];
    [self.view addSubview:self.starsView];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
