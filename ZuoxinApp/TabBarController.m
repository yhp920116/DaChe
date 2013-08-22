//
//  TabBarController.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "TabBarController.h"
#import "ZuoxinTaxiInfo.h"
#import "ZuoxinReservation.h"
#import "ZuoxinQueryFare.h"
#import "ZuoxinInvitation.h"
#import "ZuoxinMore.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadViewControllers
{
    
    ZuoxinTaxiInfo *taxiInfo = [[ZuoxinTaxiInfo alloc] init];
    UINavigationController *taxiInfoNav = [[UINavigationController alloc] initWithRootViewController:taxiInfo];
    
    ZuoxinReservation *appointment = [[ZuoxinReservation alloc] init];
    UINavigationController *reservationNav = [[UINavigationController alloc] initWithRootViewController:appointment];
    
    ZuoxinQueryFare *queryFare = [[ZuoxinQueryFare alloc] init];
    UINavigationController *qureyFareNav = [[UINavigationController alloc] initWithRootViewController:queryFare];
    
    ZuoxinInvitation *invitation = [[ZuoxinInvitation alloc] init];
    UINavigationController *invitationNav = [[UINavigationController alloc] initWithRootViewController:invitation];
    
    ZuoxinMore *more = [[ZuoxinMore alloc] init];
    UINavigationController *moreNav = [[UINavigationController alloc] initWithRootViewController:more];
    
    NSArray *views = [[NSArray alloc] initWithObjects:taxiInfoNav,reservationNav,qureyFareNav,invitationNav,moreNav,nil];
    
    self.viewControllers = views;
}
/*设置TabBar隐藏，该段代码主要设置UItansitionView为self.tabBarContoller.View*/
- (void)setTabBarHidden:(BOOL)hidden
{
    UIView * tab = self.view;
    if ([tab.subviews count] < 2) {
        return;
    }
    UIView * view;
    if ([[tab.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]) {
        view = [tab.subviews objectAtIndex:1];
    }
    else {
        view = [tab.subviews objectAtIndex:0];
    }
    
    if (hidden) {
        view.frame = tab.bounds;
        self.tabBar.hidden = hidden;
    }
    else view.frame = CGRectMake(tab.bounds.origin.x, tab.bounds.origin.y, tab.bounds.size.width, tab.bounds.size.height);
    
}

- (void)loadCustomTabBar
{
//    [self setTabBarHidden:YES];
    
    _myTabBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 480-49, 320, 49)];
    UIImage *tabBarBg = [UIImage imageNamed:@"tabbar-background@2x.png"];
    _myTabBar.image = tabBarBg;
    _myTabBar.userInteractionEnabled = YES;
    [self.view addSubview:_myTabBar];
    
    UIImage *taxiInfoImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar-1@2x" ofType:@"png"]];
    UIImage *taxiInfoImg_s = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar-1s@2x" ofType:@"png"]];
    UIImage *appointmentImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar-2@2x" ofType:@"png"]];
    UIImage *appointmentImg_s = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar-2s@2x" ofType:@"png"]];
    UIImage *queryFareImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar-3@2x" ofType:@"png"]];
    UIImage *queryFareImg_s = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar-3s@2x" ofType:@"png"]];
    UIImage *invitationImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar-4@2x" ofType:@"png"]];
    UIImage *invitationImg_s = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar-4s@2x" ofType:@"png"]];
    UIImage *moreImg= [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar-5@2x" ofType:@"png"]];
    UIImage *moreImg_s= [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar-5s@2x" ofType:@"png"]];
    
    
    NSDictionary *imagesDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:taxiInfoImg,appointmentImg,queryFareImg,invitationImg,moreImg,nil],@"normal",
                               [NSArray arrayWithObjects:taxiInfoImg_s,appointmentImg_s,queryFareImg_s,invitationImg_s,moreImg_s,nil],@"selected",nil];
    
    for (NSUInteger i = 0; i < 5; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0+64*i, 0, 64, 49)];
        [button setTag:i];
        [button setAdjustsImageWhenHighlighted:NO];
        [button setBackgroundImage:[[imagesDic objectForKey:@"normal"] objectAtIndex:i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tarbarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_myTabBar addSubview:button];
    }
    
    UIImageView *selectedView = [[UIImageView alloc] init];
    [selectedView setFrame:CGRectMake(0, 0, 64, 49)];
    [selectedView setImage:[[imagesDic objectForKey:@"selected"] objectAtIndex:0]];
    [_myTabBar addSubview:selectedView];
    
    _switchTabBarBtn = ^(NSUInteger tag){
        [selectedView setFrame:CGRectMake(0+64*tag, 0, 64, 49)];
        [selectedView setImage:[[imagesDic objectForKey:@"selected"] objectAtIndex:tag]];
    };
    
}

#pragma mark - tarbarBtnClick

- (void)tarbarBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    self.selectedIndex = btn.tag;
    _switchTabBarBtn(btn.tag);
}

- (void)tabBarHidden:(BOOL)hidden
{
    _myTabBar.hidden = hidden;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self loadViewControllers];
    [self loadCustomTabBar];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
