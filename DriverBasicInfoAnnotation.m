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
#import "DriverBasicInfoPopView.h"

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
        _view = (DriverBasicInfoView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"DriverBasicInfoAnnotation"];
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
        switch (driverBasicInfo.driverSex) {
            case 0:
            {
                UIImage *manFreeImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"manfree@2x" ofType:@"png"]];
                UIImage *manBusyImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"manbusy@2x" ofType:@"png"]];
                
                if (driverBasicInfo.driverState == 1) {
                    _view.thumbnail.image = manFreeImg;
                }
                else if (driverBasicInfo.driverState == 2)
                {
                    _view.thumbnail.image = manBusyImg;
                }
                break;
            }
            case 1:
            {
                UIImage *womanFreeImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"womanfree@2x" ofType:@"png"]];
                UIImage *womanBusyImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"womanbusy@2x" ofType:@"png"]];
                
                if (driverBasicInfo.driverState == 1) {
                    _view.thumbnail.image = womanFreeImg;
                }
                else if (driverBasicInfo.driverState == 2)
                {
                    _view.thumbnail.image = womanBusyImg;
                }
                break;
            }
        }
        
        //scoreView
        UIImage *scoreImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[[NSString alloc] initWithFormat:@"rating_%d",driverBasicInfo.commentScore] ofType:@"png"]];
        _view.scoreView.image = scoreImg;
        
        
    }
}

@end
