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
        [_view.commentView add:driverBasicInfo.commentScore];
        
        //driver status
        switch (driverBasicInfo.driverState) {
            case 0:
            {
                _view.driverStatusLabel.text = @"空闲状态";
                _view.driverStatusLabel.textColor = [UIColor greenColor];
                break;
            }
            case 1:
            {
                _view.driverStatusLabel.text = @"服务中";
                _view.driverStatusLabel.textColor = [UIColor redColor];
                break;
            }
            case 2:
            {
                _view.driverStatusLabel.text = @"休息中";
                _view.driverStatusLabel.textColor = [UIColor grayColor];
                break;
            }
        }
        
        //driver sex
        switch (driverBasicInfo.driverSex) {
            case 0:
            {
                _view.driverSexLabel.text = @"性别:男";
                break;
            }
            case 1:
            {
                _view.driverSexLabel.text = @"性别:女";
                break;
            }
        }
        
        //driver native place
        
        _view.nativePlaceLabel.text = [NSString stringWithFormat:@"籍贯：%@",_driverBasicInfo.driverNativePlace];
        _view.driverTimesLabel.text = [NSString stringWithFormat:@"代驾%@次",_driverBasicInfo.driverCount];
        _view.driverAgeLabel.text = [NSString stringWithFormat:@"驾龄%@年",_driverBasicInfo.driverAge];
        _view.distanceLabel.text = [NSString stringWithFormat:@"距离12米"];
        
        [_view.commentView add:driverBasicInfo.commentScore animated:YES];
    }
}

@end
