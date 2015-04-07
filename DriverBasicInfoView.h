//
//  DriverBasicInfoView.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-21.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "DriverBasicInfoViewProtocol.h"
@class DriverBasicPopAnnotation;

@interface DriverBasicInfoView : MKAnnotationView<DriverBasicInfoViewProtocol>

@property(nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property(nonatomic, strong) UIImageView *thumbnail;
@property(nonatomic, strong) UIImageView *scoreView;
@property(nonatomic, strong) DriverBasicPopAnnotation *popAnnotation;



- (id)initWithAnnotation:(id<MKAnnotation>)annotation;

@end
