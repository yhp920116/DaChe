//
//  DriverBasicInfoView.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-21.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import <MapKit/MapKit.h>
@class DPMeterView;


@protocol DriverBasicInfoViewProtocol <NSObject>

- (void)didSelectAnnotationViewInMap:(MKMapView *)mapView;
- (void)didDiselectAnnotationViewImMap:(MKMapView *)mapView;

@end

@interface DriverBasicInfoView : MKAnnotationView<DriverBasicInfoViewProtocol>
{
    UIButton *_disclosureBtn;
}

@property(nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property(nonatomic, strong) UILabel *driverNameLabel;
@property(nonatomic, strong) DPMeterView *commentView;

- (id)initWithAnnotation:(id<MKAnnotation>)annotation;

@end
