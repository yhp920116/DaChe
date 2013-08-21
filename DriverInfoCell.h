//
//  DriverInfoCell.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-21.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPMeterView;

@interface DriverInfoCell : UITableViewCell

@property(nonatomic, strong) UIImageView *thumbnail;
@property(nonatomic, strong) UILabel *driverNameLabel;
@property(nonatomic, strong) UILabel *distanceLabel;
@property(nonatomic, strong) UILabel *driveTimesLabel;
@property(nonatomic, strong) UILabel *driverStatusLabel;
@property(nonatomic, strong) UILabel *driveAgeLabel;
@property(nonatomic, strong) DPMeterView *starsProcess;
@property(nonatomic, strong) UIImageView *arrowView;
@property(nonatomic, strong) UILabel *nativePlaceLabel;
@property(nonatomic, strong) UIImageView *separatorLine;

@end
