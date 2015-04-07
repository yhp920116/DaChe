//
//  DriverBasicPopAnnotation.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-9-6.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "DriverBasicPopAnnotation.h"
#import "DriverBasicInfoPopView.h"
#import "DPMeterView.h"
#import "FlatRoundedImageView.h"
#import "Configuration.h"


@implementation DriverBasicPopAnnotation

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
        _view = (DriverBasicInfoPopView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"DriverBasicPopAnnotation"];
        if (!_view) _view = [[DriverBasicInfoPopView alloc] initWithAnnotation:self];
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
        
        //driverImg
        
        UIImage *driverDefault = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"defaultthumbnail@2x" ofType:@"png"]];
        UIImage *driverThumbnail = [[UIImage alloc] initWithData:_driverBasicInfo.thumbnailData];
        
        if (driverThumbnail) {
            _view.flatImageView.image = driverThumbnail;
        }
        else
        {
            _view.flatImageView.image = driverDefault;
        }
        //driverName
        _view.driverNameLabel.text = _driverBasicInfo.driverName;
        
        //driver status
        switch (driverBasicInfo.driverState) {
            case 0:
            {
                _view.driverStatusLabel.text = @"休息中";
                _view.driverStatusLabel.textColor = GrayFontColor;
                break;
            }
            case 1:
            {
                _view.driverStatusLabel.text = @"空闲状态";
                _view.driverStatusLabel.textColor = GreenFontColor;
                break;
            }
            case 2:
            {
                _view.driverStatusLabel.text = @"服务中";
                _view.driverStatusLabel.textColor = OrangeFontColor;
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
    
        
        if (driverBasicInfo.distance >= 1000) {
            NSString *distanceStr = [[NSString alloc] initWithFormat:@"%f",driverBasicInfo.distance/1000.0];
            NSRange dotLocationRange = [distanceStr rangeOfString:@"."];
            NSRange range = {0,dotLocationRange.location+2};
            distanceStr = [distanceStr substringWithRange:range];
            _view.distanceLabel.text = [NSString stringWithFormat:@"%@千米",distanceStr];
        }
        else
        {
            NSString *distanceStr = [[NSString alloc] initWithFormat:@"%f",driverBasicInfo.distance];
            NSRange dotLocationRange = [distanceStr rangeOfString:@"."];
            NSRange range = {0,dotLocationRange.location+2};
            distanceStr = [distanceStr substringWithRange:range];
            _view.distanceLabel.text = [NSString stringWithFormat:@"%@米",distanceStr];
        }
        
        
        
        [_view.commentView add:_driverBasicInfo.commentScore/5.0 animated:YES];
        
    }
}


@end
