//
//  UIAlertView+Animation.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-9-10.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "UIAlertView+Animation.h"
#import <QuartzCore/QuartzCore.h>
#define kDropCompressAmount 0.2

@implementation UIAlertView (Animation)

- (void)setAlertViewAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.6;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, -400, 0)];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation2.duration = 0.10;
    animation2.beginTime = animation.duration;
    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation2.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DMakeTranslation(0, self.layer.frame.size.height*kDropCompressAmount, 0), 1.0, 1.0-kDropCompressAmount, 1.0)];
    animation2.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation3.duration = 0.15;
    animation3.beginTime = animation.duration+animation2.duration;
    animation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation3.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation3.fillMode = kCAFillModeForwards;
    
//    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    animation4.duration=3.0;
//    animation4.beginTime = animation.duration+animation2.duration+animation3.duration;
//    animation4.repeatCount=0;
//    animation4.autoreverses=NO;
//    animation4.fromValue=[NSNumber numberWithFloat:1.0];
//    animation4.toValue=[NSNumber numberWithFloat:0.0];
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:animation, animation2, animation3,nil];
    group.duration = animation.duration+animation2.duration+animation3.duration
    ;
    group.fillMode = kCAFillModeForwards;
    
    [self.layer addAnimation:group forKey:nil];
    
}


@end
