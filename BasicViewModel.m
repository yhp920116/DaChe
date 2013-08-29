//
//  BasicViewModel.m
//  ZuoxinApp
//  http://211.155.27.214:82/anyurl.thrift
//  Created by 新工厂 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "BasicViewModel.h"
#import "BackBtn.h"
#import "CustomBtn.h"
#import "TabBarController.h"
#import "zuoxin.h"
#import "THTTPClient.h"
#import "TBinaryProtocol.h"
#import "Reachability.h"

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

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self connectThriftServer];
    [self loadCustomNavBar];
	// Do any additional setup after loading the view.
}


#pragma mark - check internet status

- (void)connectThriftServer
{
    if ([self connected]) {
        THTTPClient *transport = [[THTTPClient alloc] initWithURL:[NSURL URLWithString:@"http://211.155.27.214:82/anyurl.thrift"]];
        TBinaryProtocol *protocol = [[TBinaryProtocol alloc] initWithTransport:transport];
        self.server = [[DriverServiceClient alloc] initWithProtocol:protocol];

    }
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

- (void)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
