//
//  DriverBasicInfoPopView.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-9-5.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "DriverBasicInfoViewProtocol.h"
@class DPMeterView;
@class FlatRoundedImageView;
@class DriverBasicPopAnnotation;

@interface DriverBasicInfoPopView : MKAnnotationView<DriverBasicInfoViewProtocol>

//when selected the PopAnnotation,the infoAnnotation will disappear,and the PopAnnotation will disappear too, so you need to save it!
@property(nonatomic, strong)DriverBasicPopAnnotation *myAnnotation;
@property(nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property(nonatomic, strong) DPMeterView *commentView;
@property(nonatomic, strong) FlatRoundedImageView *flatImageView;
@property(nonatomic, strong) UILabel *driverNameLabel;
@property(nonatomic, strong) UILabel *driverStatusLabel;
@property(nonatomic, strong) UILabel *driverSexLabel;
@property(nonatomic, strong) UILabel *nativePlaceLabel;
@property(nonatomic, strong) UILabel *driverTimesLabel;
@property(nonatomic, strong) UILabel *driverAgeLabel;
@property(nonatomic, strong) UILabel *distanceLabel;
@property(nonatomic, strong) UIButton *arrowBtn;
@property(nonatomic, strong) UIImageView *separatorLine;
@property(nonatomic, strong) UIImageView *driverAgeView;
@property(nonatomic, strong) UIImageView *driverTimesView;
@property(nonatomic, strong) UIImageView *distanceView;

- (id)initWithAnnotation:(id<MKAnnotation>)annotation;

@end
