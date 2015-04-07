//
//  DriverBasicInfoView.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-21.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "DriverBasicInfoView.h"
#import "DPMeterView.h"
#import "UIBezierPath+BasicShapes.h"
#import <QuartzCore/QuartzCore.h>
#import "DriverDetail.h"
#import "FlatRoundedImageView.h"
#import "DriverBasicInfoPopView.h"
#import "DriverBasicPopAnnotation.h"
#import "DriverBasicInfoAnnotation.h"

#define DriverBasicInfoViewWidth 65
#define DriverBasicInfoViewHeight 65
#define DriverBasicInfoViewVerticalOffset -92.0f
#define  Arror_height 15
#define kDropCompressAmount 0.1


@implementation DriverBasicInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithAnnotation:(id<MKAnnotation>)annotation
{
    self = [super initWithAnnotation:annotation reuseIdentifier:@"DriverAnnotation"];
    if (self) {
        self.canShowCallout = NO;
        self.frame = CGRectMake(0, 0, DriverBasicInfoViewWidth, DriverBasicInfoViewHeight);
        self.backgroundColor = [UIColor clearColor];
        self.centerOffset = CGPointMake(0, -DriverBasicInfoViewVerticalOffset);
        
        self.thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
        [self addSubview:self.thumbnail];
        
        self.scoreView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
        [self addSubview:self.scoreView];
        
        [self didMoveToSuperview];
    }
    return self;
}


#pragma mark - DriverBasicInfoProtocol

- (void)didSelectAnnotationViewInMap:(MKMapView *)mapView
{
    [mapView setCenterCoordinate:_coordinate animated:YES];

    DriverBasicInfoAnnotation *annotation = (DriverBasicInfoAnnotation*)self.annotation;
    self.popAnnotation = [[DriverBasicPopAnnotation alloc] initWithDriverBasicInfo:annotation.driverBasicInfo];
    [mapView addAnnotation:self.popAnnotation];
    
}

- (void)didDiselectAnnotationViewImMap:(MKMapView *)mapView
{
    [mapView setCenterCoordinate:_coordinate animated:YES];
    //popAnnotation will be removed when diselected, so in the popView, you need to have a variable to point it ;
    [mapView removeAnnotation:self.popAnnotation];
    
}

#pragma mark - add animation to the DriverBasicInfoView

- (void)didMoveToSuperview {
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
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:animation, animation2, animation3, nil];
    group.duration = animation.duration+animation2.duration+animation3.duration;
    group.fillMode = kCAFillModeForwards;
    
    [self.layer addAnimation:group forKey:nil];
}


@end
