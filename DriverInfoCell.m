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
#import "FlatRoundedImageView.h"
#import <QuartzCore/QuartzCore.h>

#define  Arror_height 15
#define kDropCompressAmount 0.1


@implementation DriverInfoCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //thumbnail
        self.frame = CGRectMake(10, 0, 300, 80);
        
        
        self.thumbnail = [[FlatRoundedImageView alloc] initWithFrame:CGRectMake(10, 15, 50, 50)];
        self.thumbnail.borderColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.thumbnail];
        
        self.driverNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 50, 14)];
        self.driverNameLabel.font = [UIFont systemFontOfSize:14.0f];
        self.driverNameLabel.textColor = [UIColor blackColor];
        self.driverNameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.driverNameLabel];
        
        self.starsProcess = [[DPMeterView alloc] initWithFrame:CGRectMake(140, 5, 80, 20)];
        [self.starsProcess setMeterType:DPMeterTypeLinearHorizontal];
        [self.starsProcess setShape:[UIBezierPath stars:5 shapeInFrame:CGRectMake(10, 20, 80, 20)].CGPath];
        [self.starsProcess setTrackTintColor:[UIColor lightGrayColor]];
        
        [self.starsProcess setProgressTintColor:[UIColor darkGrayColor]];
        self.starsProcess.progressTintColor = [UIColor colorWithRed:255/255.f green:199/255.f blue:87/255.f alpha:1.f];
        [self.starsProcess setGradientOrientationAngle:2*M_PI];
        [self.contentView addSubview:self.starsProcess];

        
        self.driverStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 60, 12)];
        self.driverStatusLabel.font = [UIFont systemFontOfSize:14.0f];
        self.driverStatusLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.driverStatusLabel];
        
        self.driverSexLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 30, 50, 12)];
        self.driverSexLabel.font = [UIFont systemFontOfSize:12.0f];
        self.driverSexLabel.textColor = [UIColor grayColor];
        self.driverSexLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.driverSexLabel
         ];
        
        self.nativePlaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 30, 70, 12)];
        self.nativePlaceLabel.font = [UIFont systemFontOfSize:12.0f];
        self.nativePlaceLabel.textColor = [UIColor grayColor];
        self.nativePlaceLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.nativePlaceLabel];

        
        self.driveTimesLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 50, 70, 12)];
        self.driveTimesLabel.font = [UIFont systemFontOfSize:12.0f];
        self.driveTimesLabel.textColor = [UIColor grayColor];
        self.driveTimesLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.driveTimesLabel];
        
        self.driveAgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 50, 60, 12)];
        self.driveAgeLabel.font = [UIFont systemFontOfSize:12.0f];
        self.driveAgeLabel.textColor = [UIColor grayColor];
        self.driveAgeLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.driveAgeLabel];


        self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 50, 90, 12)];
        self.distanceLabel.font = [UIFont systemFontOfSize:12.0f];
        self.distanceLabel.textColor = [UIColor grayColor];
        self.distanceLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.distanceLabel];
        
                
        
                
        
        
        
        self.arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(280, 26, 10.5, 15)];
        [self.contentView addSubview:self.arrowView];
                        
//        //backgroundView
        UIView *backgroundView = [[UIView alloc] initWithFrame:self.frame];
        backgroundView.backgroundColor = [UIColor whiteColor];
        backgroundView.layer.cornerRadius = 5.0;
        self.backgroundView = backgroundView;
        
        
        //selectedBackgroundView
        UIImage *renderImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"renderimg" ofType:@"png"]];
        UIImageView *renderImgView = [[UIImageView alloc] initWithImage:renderImg];
        self.selectedBackgroundView = renderImgView;
        
        self.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.layer.shadowOpacity = .2;
        self.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect myFrame = self.frame;
    myFrame.origin.x  = 10;
    myFrame.size.width = 300;
    self.frame = myFrame;
}

@end
