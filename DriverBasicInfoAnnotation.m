//
//  DriverBasicInfoAnnotation.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-21.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "DriverBasicInfoAnnotation.h"
#import "UIBezierPath+BasicShapes.h"
#import "DPMeterView.h"

@implementation DriverBasicInfoAnnotation

- (id)initWithDriverBasicInfo:(DriverBasicInfo *)driverBasicInfo
{
    self = [super init];
    if (self) {
        _coordinate = driverBasicInfo.coordinate;
        _driverBasicInfo = driverBasicInfo;
    }
    return self;
}

- (MKAnnotationView *)annotationViewInMap:(MKMapView *)mapView {
    if (!_view) {
        _view = (DriverBasicInfoView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"JPSThumbnailAnnotationView"];
        if (!_view) _view = [[DriverBasicInfoView alloc] initWithAnnotation:self];
    } else {
        _view.annotation = self;
    }
    [self updateDriverBasicInfo:_driverBasicInfo animated:YES];
    return _view;
}

- (void)updateDriverBasicInfo:(DriverBasicInfo *)driverBasicInfo animated:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:0.33f animations:^{
            _coordinate = driverBasicInfo.coordinate;
        }];
    } else {
        _coordinate = driverBasicInfo.coordinate;
    }
    
    if (_view){
        _view.coordinate = self.coordinate;
        _view.driverNameLabel.text = driverBasicInfo.driverName;
        [_view.commentView add:driverBasicInfo.commentScore animated:YES];
    }
}

@end
