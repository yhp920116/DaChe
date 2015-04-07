//
//  BasicViewModel.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//




#import <UIKit/UIKit.h>
#import "Configuration.h"
#import "Reachability.h"
@class DriverServiceClient;
@class SIAlertView;

enum {
    NetworkModeConnected = 0,
    NetworkModeUnconnected
};
typedef NSUInteger NetworkMode;


@interface BasicViewModel : UIViewController
{
    UIView *_unconnectedView;
}

//@property(nonatomic, strong) UIView *unconnectedView;
@property(nonatomic, assign) NetworkMode networkMode;
@property(nonatomic, strong) UIButton *backBtn;
@property(nonatomic, strong) UIButton *rightBtn;
@property(nonatomic, strong) UIButton *customBtn;
@property(nonatomic, strong) UILabel *navTitleLabel;
@property(nonatomic, strong) DriverServiceClient *server;
@property(nonatomic) BOOL isNetworkConneted;


- (void)setTabBarHidden:(BOOL)hidden;

- (void)loadUnconnectedView;

//internet connect

- (void)setNetworkMode:(NetworkMode)networkMode;
- (BOOL)connected;
- (void)registerNetworkNotification;

//connect server
- (void)connectThriftServer;

//layer property
- (void)setLayerCornerRadiusAndshadowInView:(UIView *)sender;

//alertView
- (void)customAlertViewProperty:(SIAlertView *)alertView andBlock:(void(^)(void) )block ;


@end
