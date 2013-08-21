//
//  BasicViewModel.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "BasicViewModel.h"
#import "BackBtn.h"
#import "CustomBtn.h"
#import "TabBarController.h"

@interface BasicViewModel ()

@end

@implementation BasicViewModel

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadCustomNavBar
{
    //navigationBar
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"navigationbar-background@2x" ofType:@"png"]];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    //titleLabel
    self.navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320-113, 44)];
    self.navTitleLabel.font = [UIFont fontWithName:@"Heiti SC" size:14.0f];
    self.navTitleLabel.textColor = [UIColor whiteColor];
    self.navTitleLabel.backgroundColor = [UIColor clearColor];
    self.navTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = self.navTitleLabel;
    
    //backBtn
    self.backBtn = [[BackBtn alloc] initWithFrame:CGRectMake(0, 0, 52, 32)];
    [self.backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = backBtnItem;
    
    //customBtn
    self.customBtn = [CustomBtn buttonWithType:UIButtonTypeCustom];
    self.customBtn.frame = CGRectMake(0, 0, 61, 32);
    [self.customBtn setCustomBackgroundImage];
    UIBarButtonItem *customBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.customBtn];
    self.navigationItem.rightBarButtonItem = customBtnItem;
}

- (void)setTabBarHidden:(BOOL)hidden
{
    TabBarController *tabBarController = (TabBarController*)self.tabBarController;
    [tabBarController tabBarHidden:hidden];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadCustomNavBar];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
