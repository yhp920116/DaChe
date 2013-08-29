//
//  DriverBasicInfoView.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-21.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import <MapKit/MapKit.h>
@class DPMeterView;
@class FlatRoundedImageView;


@protocol DriverBasicInfoViewProtocol <NSObject>

- (void)didSelectAnnotationViewInMap:(MKMapView *)mapView;
- (void)didDiselectAnnotationViewImMap:(MKMapView *)mapView;

@end

@interface DriverBasicInfoView : MKAnnotationView<DriverBasicInfoViewProtocol>
{
    UIButton *_disclosureBtn;
}

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

- (id)initWithAnnotation:(id<MKAnnotation>)annotation;

@end
