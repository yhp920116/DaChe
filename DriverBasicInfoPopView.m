//
//  DriverBasicInfoPopView.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-9-5.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "DriverBasicInfoPopView.h"
#import "DPMeterView.h"
#import "FlatRoundedImageView.h"
#import "UIBezierPath+BasicShapes.h"
#import <QuartzCore/QuartzCore.h>
#import "DriverBasicPopAnnotation.h"
#import "Configuration.h"



@implementation DriverBasicInfoPopView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (id)initWithAnnotation:(id<MKAnnotation>)annotation
{
    self = [super initWithAnnotation:annotation reuseIdentifier:@"DriverhjkAnnotation"];
    if (self) {
        self.myAnnotation = (DriverBasicPopAnnotation*)annotation;
        self.canShowCallout = NO;
        self.frame = CGRectMake(0,0, DriverBasicInfoPopViewWidth, DriverBasicInfoPopViewHeight);
        self.backgroundColor = [UIColor clearColor];
        
        //flatRoundedImageView
        _flatImageView = [[FlatRoundedImageView alloc] initWithFrame:CGRectMake(12, 10, 50, 50)];
        _flatImageView.borderColor = [UIColor clearColor];
        _flatImageView.borderWidth = 0.0f;
        [self addSubview:_flatImageView];
        
        //driverNameLabel
        _driverNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 15, 60, 14)];
        _driverNameLabel.font = BigFont;
        _driverNameLabel.backgroundColor = [UIColor clearColor];
        _driverNameLabel.textColor = [UIColor whiteColor];
        _driverNameLabel.alpha = 1;
        [self addSubview:_driverNameLabel];
        
        //dpmeterView
        _commentView = [[DPMeterView alloc] initWithFrame:CGRectMake(140, 13, 100, 15)];
        [_commentView setMeterType:DPMeterTypeLinearHorizontal];
        [_commentView setShape:[UIBezierPath stars:5 shapeInFrame:CGRectMake(0, 0, 100, 15)].CGPath];
        [_commentView setTrackTintColor:[UIColor lightGrayColor]];
        _commentView.progressTintColor = [UIColor colorWithRed:255/255.f green:199/255.f blue:87/255.f alpha:1.f];
        [_commentView setGradientOrientationAngle:2*M_PI];
        [self addSubview:_commentView];
        
        //driverStatusLabel
        _driverStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 40, 50, 10)];
        _driverStatusLabel.font = [UIFont systemFontOfSize:10.0f];
        _driverStatusLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_driverStatusLabel];
        
        //driverSexLabel
        _driverSexLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 40, 50, 10)];
        _driverSexLabel.font = SmallFont;
        _driverSexLabel.backgroundColor = [UIColor clearColor];
        _driverSexLabel.textColor = [UIColor whiteColor];
        [self addSubview:_driverSexLabel];
        
        //nativePlaceLabel
        _nativePlaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(185, 40, 75, 10)];
        _nativePlaceLabel.font = SmallFont;
        _nativePlaceLabel.backgroundColor = [UIColor clearColor];
        _nativePlaceLabel.textColor = [UIColor whiteColor];
        [self addSubview:_nativePlaceLabel];
        
        //arrowBtn
        _arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _arrowBtn.frame = CGRectMake(240, 45, 13.5, 13.5);
        [_arrowBtn setBackgroundImage:[UIImage imageNamed:@"rightarrow@2x.png"] forState:UIControlStateNormal];
        [_arrowBtn addTarget:self action:@selector(calloutViewBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_arrowBtn];
        
        //separatorLine
        _separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(10, 75, self.frame.size.width-20, 1)];
        _separatorLine.image = [UIImage imageNamed:@"separatorline@2x.png"];
        [self addSubview:_separatorLine];
        
        //driverTimesView
        _driverTimesView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 82.5, 15, 15)];
        _driverTimesView.image = [UIImage imageNamed:@"driver_count@2x.png"];
        [self addSubview:_driverTimesView];
        
        //driverTimesLabel
        _driverTimesLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 85, 52, 12)];
        _driverTimesLabel.font = SMediumFont;
        _driverTimesLabel.backgroundColor = [UIColor clearColor];
        _driverTimesLabel.textColor = GrayFontColor;
        [self addSubview:_driverTimesLabel];
        
        //driverAgeView
        _driverAgeView = [[UIImageView alloc] initWithFrame:CGRectMake(28+52+3, 82.5, 15, 15)];
        _driverAgeView.image = [UIImage imageNamed:@"driver_age@2x.png"];
        [self addSubview:_driverAgeView];
        
        //driverAgeLabel
        _driverAgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(28+52+3+15+3, 85, 60, 12)];
        _driverAgeLabel.font = SMediumFont;
        _driverAgeLabel.backgroundColor = [UIColor clearColor];
        _driverAgeLabel.textColor = GrayFontColor;
        [self addSubview:_driverAgeLabel];
        
        //distanceView
        _distanceView = [[UIImageView alloc] initWithFrame:CGRectMake(161+3, 83, 10, 13)];
        _distanceView.image = [UIImage imageNamed:@"driver_location@2x.png"];
        [self addSubview:_distanceView];
        
        //distanceLabel
        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(164+10.5+4, 86, 70, 12)];
        
        _distanceLabel.font = SMediumFont;
        _distanceLabel.backgroundColor = [UIColor clearColor];
        _distanceLabel.textColor = GrayFontColor;
        [self addSubview:_distanceLabel];
        
        [self didMoveToSuperview];
    }
    return self;
}

- (void)didSelectAnnotationViewInMap:(MKMapView *)mapView
{

    
}

- (void)didDiselectAnnotationViewImMap:(MKMapView *)mapView
{
    
    
}

#pragma mark - Quartz 2D

-(void)drawInContext:(CGContextRef)context
{
	
    CGContextSetLineWidth(context, 2.0);
    [[[UIColor blackColor] colorWithAlphaComponent:.6] setFill];
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
    animation.duration = 0.4;
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


- (void)calloutViewBtnClick
{
    
}


@end
