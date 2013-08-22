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

#define DriverBasicInfoViewWidth 87.0f
#define DriverBasicInfoViewHeight 60.0f
#define DriverBasicInfoViewVerticalOffset 34.0f
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
        
        //driverNameLabel
        _driverNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, DriverBasicInfoViewWidth, 14)];
        _driverNameLabel.font = [UIFont systemFontOfSize:14.0f];
        _driverNameLabel.backgroundColor = [UIColor clearColor];
        _driverNameLabel.textAlignment = NSTextAlignmentCenter;
        _driverNameLabel.textColor = [UIColor blackColor];
        _driverNameLabel.alpha = 1;
        [self addSubview:_driverNameLabel];
        
        //dpmeterView
        _commentView = [[DPMeterView alloc] initWithFrame:CGRectMake(3.5, 20, 80, 20)];
        [_commentView setShape:[UIBezierPath stars:5 shapeInFrame:CGRectMake(0, 0, 80, 20)].CGPath];
        [_commentView setTrackTintColor:[UIColor lightGrayColor]];
//        [_commentView setProgressTintColor:[UIColor darkGrayColor]];
        _commentView.progressTintColor = [UIColor colorWithRed:255/255.f green:199/255.f blue:87/255.f alpha:1.f];
        [_commentView setGradientOrientationAngle:2*M_PI];
        [self addSubview:_commentView];
        [self didMoveToSuperview];
    }
    return self;
}

- (void)didSelectAnnotationViewInMap:(MKMapView *)mapView
{
    [mapView setCenterCoordinate:self.coordinate];
}

- (void)didDiselectAnnotationViewImMap:(MKMapView *)mapView
{
    
}

#pragma mark - Quartz 2D 

-(void)drawInContext:(CGContextRef)context
{
	
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
    
    //    CGContextSetLineWidth(context, 1.0);
    //     CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    //    [self getDrawPath:context];
    //    CGContextStrokePath(context);
    
}
- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
	CGFloat radius = 4.0;
    
	CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
	CGFloat miny = CGRectGetMinY(rrect),
    // midy = CGRectGetMidY(rrect),
    maxy = CGRectGetMaxY(rrect)-Arror_height;
    CGContextMoveToPoint(context, midx+Arror_height, maxy);
    CGContextAddLineToPoint(context,midx, maxy+Arror_height);
    CGContextAddLineToPoint(context,midx-Arror_height, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}

- (void)drawRect:(CGRect)rect
{
	[self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = .8;
    //  self.layer.shadowOffset = CGSizeMake(-5.0f, 5.0f);
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
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
