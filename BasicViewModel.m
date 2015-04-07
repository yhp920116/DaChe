//
//  BasicViewModel.m
//  ZuoxinApp
//  http://211.155.27.214:82/anyurl.thrift
//  Created by 新工厂 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "BasicViewModel.h"
#import "TabBarController.h"
#import "zuoxin.h"
#import "THTTPClient.h"
#import "TBinaryProtocol.h"
#import "Reachability.h"
#import <QuartzCore/QuartzCore.h>
#import "SIAlertView.h"


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

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self connectThriftServer];
    [self loadCustomNavBar];
    
    
	// Do any additional setup after loading the view.
}

#pragma mark - Check network

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    if (networkStatus  == ReachableViaWiFi || networkStatus == ReachableViaWWAN) {
        return YES;
    }
    else
    {
        return NO;
    }
    return YES;
    
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

#pragma mark - loadCustomNavBar

- (void)loadCustomNavBar
{
    //hide navigationBar
    self.navigationController.navigationBar.hidden = YES;
    
    //navigationBarView
    UIImageView *navigationBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 47)];
    navigationBarView.tag = 10001;
    navigationBarView.image = NavigationBarImage;
    navigationBarView.userInteractionEnabled = YES;
    [self.view addSubview:navigationBarView];
    

    //navtitleLabel
    self.navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15.5, 320, 16)];
    self.navTitleLabel.font = BigBigFont;
    self.navTitleLabel.textColor = [UIColor whiteColor];
    self.navTitleLabel.shadowColor = [UIColor whiteColor];
    self.navTitleLabel.shadowOffset = CGSizeMake(-0.1, 0.3);
    self.navTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.navTitleLabel.backgroundColor = [UIColor clearColor];
    [navigationBarView addSubview:self.navTitleLabel];
    
    
    //backbtn
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(0, 0, 109/2+10, 47);
    self.backBtn.adjustsImageWhenHighlighted = NO;
    UIImage *backBtnImg = BackBtnImage;
    [self.backBtn setImage:backBtnImg forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navigationBarView addSubview:self.backBtn];
    
    //rigthBtn
//    UIImage *customImg = [[UIImage imageNamed:@"custombtnImage.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch];
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.adjustsImageWhenHighlighted = NO;
//    [self.rightBtn setBackgroundImage:customImg forState:UIControlStateNormal];
    [navigationBarView addSubview:self.rightBtn];
    
}

- (void)loadUnconnectedView
{
    _unconnectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 47, 320, self.view.frame.size.height-47-47)];
    _unconnectedView.backgroundColor = [UIColor whiteColor];
    
    //alertView
    UIImageView *alertView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alert@2x.png"]];
    alertView.frame = CGRectMake(78.25, 0, 163.5, 163.5);
    [_unconnectedView addSubview:alertView];
    
    //label
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:10.0f];
    label.textColor = [UIColor grayColor];
    CGSize size = CGSizeMake(280, 1000);
    label.text = @"抱歉，你的网络连接中断，请拨打我们的400服务热线，继续享受李司机代驾提供的优质服务，或者尝试重新连接网络。";
    CGSize textSize = [label.text sizeWithFont:label.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    label.numberOfLines = 0;
    label.frame = CGRectMake(20, 163.5, textSize.width, textSize.height);
    [_unconnectedView addSubview:label];
    
    //callbtn

    UIImage *phoneImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"phoneicon@2x" ofType:@"png"]];
    UIImage *connectImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"connecting@2x" ofType:@"png"]];
    UIButton *callbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    callbtn.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    callbtn.frame = CGRectMake(10, 163.5+40, 300, 33.5);
    callbtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [callbtn setBackgroundImage:GeenBtnBG forState:UIControlStateNormal];
    [callbtn setImage:phoneImg forState:UIControlStateNormal];
    [callbtn setTitle:@"400－627-8866" forState:UIControlStateNormal];
    [callbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [callbtn addTarget:self action:@selector(callBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_unconnectedView addSubview:callbtn];
    
    //reconnect
    UIButton *reconnectbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reconnectbtn.frame = CGRectMake(10, 163.5+40+43.5, 300, 33.5);
    reconnectbtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [reconnectbtn setBackgroundImage:BlueBtnBG forState:UIControlStateNormal];
    [reconnectbtn setImage:connectImg forState:UIControlStateNormal];
    [reconnectbtn setTitle:@"自动连接网络中..." forState:UIControlStateNormal];
    [reconnectbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_unconnectedView addSubview:reconnectbtn];
    
}

#pragma mark - register a notificationCenter

- (void)registerNetworkNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    [reach startNotifier];
}

#pragma mark - setTabBarHidden

- (void)setTabBarHidden:(BOOL)hidden
{
    TabBarController *tabBarController = (TabBarController*)self.tabBarController;
    [tabBarController tabBarHidden:hidden];
}

#pragma mark - btnClick

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - LayerCornerRadius and shadow

- (void)setLayerCornerRadiusAndshadowInView:(UIView *)sender
{
//    sender.layer.cornerRadius = 3.0f;
//    sender.layer.shadowColor = [[UIColor blackColor] CGColor];
//    sender.layer.shadowOpacity = 0.4;
//    sender.layer.shadowOffset = CGSizeMake(0, 0.3);
//    sender.layer.shadowRadius = 0.2;
//    sender.layer.borderWidth = 0.2f;
//    sender.layer.borderColor = [UIColor lightGrayColor].CGColor;
    sender.layer.cornerRadius = 3.0f;
    sender.layer.shadowColor = [UIColor grayColor].CGColor;
    sender.layer.shadowOffset = CGSizeMake(0, 0.3);
    sender.layer.shadowOpacity = 0.8;
    sender.layer.shadowRadius = 0.5;
}

#pragma mark - alertView

- (void)customAlertViewProperty:(SIAlertView *)alertView andBlock:(void (^)(void))block
{
    alertView.titleColor = GrayFontColor;
    alertView.titleFont = BigBigFont;
    alertView.messageColor = GrayFontColor;
    alertView.messageFont = BigFont;
    
    alertView.transitionStyle = SIAlertViewTransitionStyleDropDown;
    alertView.backgroundStyle = SIAlertViewBackgroundStyleGradient;
    
    [alertView show];
    
    double delayInSeconds = 0.8;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(),block);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
