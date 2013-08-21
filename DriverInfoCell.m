//
//  DriverInfoCell.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-21.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "DriverInfoCell.h"
#import "DPMeterView.h"
#import "UIBezierPath+BasicShapes.h"

@implementation DriverInfoCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //thumbnail
        self.thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, 40, 52)];
        [self.contentView addSubview:self.thumbnail];
        
        self.driverNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(54, 8, 48, 14)];
        self.driverNameLabel.font = [UIFont systemFontOfSize:16.0f];
        self.driverNameLabel.textColor = [UIColor blackColor];
        self.driverNameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.driverNameLabel];
        
        self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(54, 28, 100, 12)];
        self.distanceLabel.font = [UIFont systemFontOfSize:12.0f];
        self.distanceLabel.text = @"距离:";
        self.distanceLabel.textColor = [UIColor blackColor];
        self.distanceLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.distanceLabel];
        
        self.driveTimesLabel = [[UILabel alloc] initWithFrame:CGRectMake(54, 46, 80, 12)];
        self.driveTimesLabel.text = @"代驾:";
        self.driveTimesLabel.font = [UIFont systemFontOfSize:12.0f];
        self.driveTimesLabel.textColor = [UIColor blackColor];
        self.driveTimesLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.driveTimesLabel];
        
        self.driverStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 8, 50, 14)];
        self.driverStatusLabel.font = [UIFont systemFontOfSize:14.0f];
        self.driverStatusLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.driverStatusLabel];
        
        self.driveAgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 46, 60, 12)];
        self.driveAgeLabel.text = @"驾龄";
        self.driveAgeLabel.font = [UIFont systemFontOfSize:12.0f];
        self.driveAgeLabel.textColor = [UIColor blackColor];
        self.driveAgeLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.driveAgeLabel];
        
        self.starsProcess = [[DPMeterView alloc] initWithFrame:CGRectMake(220, 4, 80, 20)];
        [self.starsProcess setShape:[UIBezierPath stars:5 shapeInFrame:CGRectMake(10, 20, 80, 20)].CGPath];
        [self.starsProcess setTrackTintColor:[UIColor lightGrayColor]];
        
        [self.starsProcess setProgressTintColor:[UIColor darkGrayColor]];	
        [self.starsProcess add:0.8 animated:YES];
        self.starsProcess.progressTintColor = [UIColor colorWithRed:255/255.f green:199/255.f blue:87/255.f alpha:1.f];
        [self.starsProcess setGradientOrientationAngle:2*M_PI];
        [self.contentView addSubview:self.starsProcess];
        
        self.nativePlaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 46, 70, 12)];
        self.nativePlaceLabel.text = @"籍贯";
        self.nativePlaceLabel.font = [UIFont systemFontOfSize:12.0f];
        self.nativePlaceLabel.textColor = [UIColor blackColor];
        self.nativePlaceLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.nativePlaceLabel];
        
        self.arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(306, 26, 10.5, 15)];
        [self.contentView addSubview:self.arrowView];
        
        //separatorLine
        self.separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 62, 320, 2)];
        [self.contentView addSubview:self.separatorLine];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
