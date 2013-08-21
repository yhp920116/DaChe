//
//  TabBarController.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarController : UITabBarController
{
    UIImageView *_myTabBar;
    void(^_switchTabBarBtn)(NSUInteger tag);
}

- (void)tabBarHidden:(BOOL)hidden;

@end
