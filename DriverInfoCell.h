//
//  DriverInfoCell.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-21.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPMeterView;
@class FlatRoundedImageView;

@interface DriverInfoCell : UITableViewCell

@property(nonatomic, strong) FlatRoundedImageView *thumbnail;
@property(nonatomic, strong) UILabel *driverNameLabel;
@property(nonatomic, strong) UILabel *distanceLabel;
@property(nonatomic, strong) UILabel *driveTimesLabel;
@property(nonatomic, strong) UILabel *driverStatusLabel;
@property(nonatomic, strong) UILabel *driveAgeLabel;
@property(nonatomic, strong) UILabel *driverSexLabel;
@property(nonatomic, strong) DPMeterView *starsProcess;
@property(nonatomic, strong) UIButton *callBtn;
@property(nonatomic, strong) UILabel *nativePlaceLabel;
@property(nonatomic, strong) UIImageView *driverAgeView;
@property(nonatomic, strong) UIImageView *driverTimesView;
@property(nonatomic, strong) UIImageView *distanceView;

- (UIImage *)renderThumbnail:(UIImage *)image;


@end
