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

#define DriverBasicInfoViewWidth 87.0f
#define DriverBasicInfoViewHeight 60.0f
#define DriverBasicInfoViewVerticalOffset 34.0f

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
        _driverNameLabel.alpha = 0;
        [self addSubview:_driverNameLabel];
        
        //dpmeterView
        _commentView = [[DPMeterView alloc] initWithFrame:CGRectMake(0, 30, DriverBasicInfoViewWidth, 20)];
        [_commentView setShape:[UIBezierPath stars:5 shapeInFrame:CGRectMake(10, 20, 80, 20)].CGPath];
        [_commentView setTrackTintColor:[UIColor lightGrayColor]];
        [_commentView setProgressTintColor:[UIColor darkGrayColor]];
        _commentView.progressTintColor = [UIColor colorWithRed:255/255.f green:199/255.f blue:87/255.f alpha:1.f];
        [_commentView setGradientOrientationAngle:2*M_PI];
        [self addSubview:_commentView];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
