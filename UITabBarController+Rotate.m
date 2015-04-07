//
//  UITabBarController+Rotate.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-9-22.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "UITabBarController+Rotate.h"

@implementation UITabBarController (Rotate)

- (BOOL)shouldAutorotate
{
    return self.modalViewController.shouldAutorotate;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return self.modalViewController.supportedInterfaceOrientations;
}

@end
