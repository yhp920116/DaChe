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

#define DriverBasicInfoViewWidth 87.0f * 3
#define DriverBasicInfoViewHeight 60.0f * 2
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
        
        //flatRoundedImageView
        _flatImageView = [FlatRoundedImageView FlatRoundedImageViewWithImage:[UIImage imageNamed:@"cn.png"]];
        _flatImageView.borderColor = [UIColor whiteColor];
        _flatImageView.frame = CGRectMake(15, 10, 45, 45);
        [self addSubview:_flatImageView];
        
        //driverNameLabel
        _driverNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 15, 50, 14)];
        _driverNameLabel.font = [UIFont systemFontOfSize:14.0f];
        _driverNameLabel.backgroundColor = [UIColor clearColor];
        _driverNameLabel.textColor = [UIColor whiteColor];
        _driverNameLabel.alpha = 1;
        [self addSubview:_driverNameLabel];
        
        //dpmeterView
        _commentView = [[DPMeterView alloc] initWithFrame:CGRectMake(150, 10, 80, 20)];
        [_commentView setMeterType:DPMeterTypeLinearHorizontal];
        [_commentView setShape:[UIBezierPath stars:5 shapeInFrame:CGRectMake(0, 0, 80, 20)].CGPath];
        [_commentView setTrackTintColor:[UIColor lightGrayColor]];
        _commentView.progressTintColor = [UIColor colorWithRed:255/255.f green:199/255.f blue:87/255.f alpha:1.f];
        [_commentView setGradientOrientationAngle:2*M_PI];
        [self addSubview:_commentView];
        
        //driverStatusLabel
        _driverStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 40, 50, 14)];
        _driverStatusLabel.font = [UIFont systemFontOfSize:12.0f];
        _driverStatusLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_driverStatusLabel];
        
        //driverSexLabel
        _driverSexLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 40, 50, 12)];
        _driverSexLabel.font = [UIFont systemFontOfSize:12.0f];
        _driverSexLabel.backgroundColor = [UIColor clearColor];
        _driverSexLabel.textColor = [UIColor whiteColor];
        [self addSubview:_driverSexLabel];
        
        //nativePlaceLabel
        _nativePlaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(185, 40, 75, 12)];
        _nativePlaceLabel.font = [UIFont systemFontOfSize:12.0f];
        _nativePlaceLabel.backgroundColor = [UIColor clearColor];
        _nativePlaceLabel.textColor = [UIColor whiteColor];
        [self addSubview:_nativePlaceLabel];
        
        //driverTimesLabel
        _driverTimesLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 70, 84, 14)];
        _driverTimesLabel.font = [UIFont systemFontOfSize:14.0f];
        _driverTimesLabel.backgroundColor = [UIColor clearColor];
        _driverTimesLabel.textColor = [UIColor whiteColor];
        [self addSubview:_driverTimesLabel];
        
        //driverAgeLabel
        _driverAgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+84, 70, 84, 14)];
        _driverAgeLabel.font = [UIFont systemFontOfSize:14.0f];
        _driverAgeLabel.backgroundColor = [UIColor clearColor];
        _driverAgeLabel.textColor = [UIColor whiteColor];
        [self addSubview:_driverAgeLabel];
        
        //
        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+84+84, 70, 84, 14)];

        _distanceLabel.font = [UIFont systemFontOfSize:14.0f];
        _distanceLabel.backgroundColor = [UIColor clearColor];
        _distanceLabel.textColor = [UIColor whiteColor];
        [self addSubview:_distanceLabel];
        
        [self didMoveToSuperview];
    }
    return self;
}

#pragma mark - Quartz 2D 

-(void)drawInContext:(CGContextRef)context
{
	
    CGContextSetLineWidth(context, 2.0);
    [[[UIColor blackColor] colorWithAlphaComponent:.5] setFill];
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

- (void)didSelectAnnotationViewInMap:(MKMapView *)mapView
{
    NSLog(@"slected");
}

- (void)didDiselectAnnotationViewImMap:(MKMapView *)mapView
{
    
}

@end
