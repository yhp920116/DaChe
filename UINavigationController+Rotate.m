//
//  UINavigationController+Rotate.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-9-22.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "UINavigationController+Rotate.h"

@implementation UINavigationController (Rotate)

- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

@end
