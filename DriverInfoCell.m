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
#import "SIAlertView.h"
#import "Configuration.h"

#define  Arror_height 15
#define kDropCompressAmount 0.1

static const CGSize thumbnailSize = {50,50};
static const CGRect thumbnailRect = {{0,0},{50,50}};


@implementation DriverInfoCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //thumbnail
        self.frame = CGRectMake(10, 0, 300, 80);
        self.opaque = YES;
        
        
        self.thumbnail = [[FlatRoundedImageView alloc] initWithFrame:CGRectMake(10, 15, 50, 50)];
        self.thumbnail.borderColor = [UIColor grayColor];
        self.thumbnail.borderWidth = 1.0f;
        self.thumbnail.opaque = YES;
        [self.contentView addSubview:self.thumbnail];
        
        self.driverNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 60, 14)];
        self.driverNameLabel.font = [UIFont systemFontOfSize:14.0f];
        self.driverNameLabel.textColor = [UIColor blackColor];
        self.driverNameLabel.backgroundColor = [UIColor whiteColor];
        self.driverNameLabel.opaque = YES;
        [self.contentView addSubview:self.driverNameLabel];
        
        self.starsProcess = [[DPMeterView alloc] initWithFrame:CGRectMake(150, 5, 80, 20)];
        self.starsProcess.opaque = YES;
        [self.starsProcess setMeterType:DPMeterTypeLinearHorizontal];
        [self.starsProcess setShape:[UIBezierPath stars:5 shapeInFrame:CGRectMake(10, 20, 80, 20)].CGPath];
        [self.starsProcess setTrackTintColor:[UIColor lightGrayColor]];
        
        [self.starsProcess setProgressTintColor:[UIColor darkGrayColor]];
        self.starsProcess.progressTintColor = [UIColor colorWithRed:255/255.f green:199/255.f blue:87/255.f alpha:1.f];
        [self.starsProcess setGradientOrientationAngle:2*M_PI];
        [self.contentView addSubview:self.starsProcess];

        
        self.driverStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 40, 12)];
        self.driverStatusLabel.font = SmallFont;
        self.driverStatusLabel.backgroundColor = [UIColor whiteColor];
        self.driverStatusLabel.opaque = YES;
        [self.contentView addSubview:self.driverStatusLabel];
        
        self.driverSexLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 30, 40, 12)];
        self.driverSexLabel.opaque = YES;
        self.driverSexLabel.font = SmallFont;
        self.driverSexLabel.textColor = GrayFontColor;
        self.driverSexLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.driverSexLabel
         ];
        
        self.nativePlaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 30, 60, 12)];
        self.nativePlaceLabel.opaque = YES;
        self.nativePlaceLabel.font = SmallFont;
        self.nativePlaceLabel.textColor = GrayFontColor;
        self.nativePlaceLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.nativePlaceLabel];

        
        _driverTimesView = [[UIImageView alloc] initWithFrame:CGRectMake(68, 48, 15, 15)];
        _driverTimesView.opaque = YES;
        _driverTimesView.image = [UIImage imageNamed:@"driver_count@2x.png"];
        [self addSubview:_driverTimesView];
        
        self.driveTimesLabel = [[UILabel alloc] initWithFrame:CGRectMake(84, 50, 40, 12)];
        self.driveTimesLabel.opaque = YES;
        self.driveTimesLabel.font = SmallFont;
        self.driveTimesLabel.textColor = GrayFontColor;
        self.driveTimesLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.driveTimesLabel];
        
        
        _driverAgeView = [[UIImageView alloc] initWithFrame:CGRectMake(128, 48, 15, 15)];
        _driverAgeView.image = [UIImage imageNamed:@"driver_age@2x.png"];
        _driverAgeView.opaque = YES;
        [self addSubview:_driverAgeView];
        
        self.driveAgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(144, 50, 50, 12)];
        self.driveAgeLabel.font = SmallFont;
        self.driveAgeLabel.textColor = GrayFontColor;
        self.driveAgeLabel.backgroundColor = [UIColor whiteColor];
        self.driveAgeLabel.opaque = YES;
        [self.contentView addSubview:self.driveAgeLabel];

        _distanceView = [[UIImageView alloc] initWithFrame:CGRectMake(186, 48, 10, 14)];
        _distanceView.image = [UIImage imageNamed:@"driver_location@2x.png"];
        _distanceView.opaque = YES;
        [self addSubview:_distanceView];
        
        self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(197, 50, 60, 12)];
        self.distanceLabel.font = SmallFont;
        self.distanceLabel.textColor = GrayFontColor;
        self.distanceLabel.backgroundColor = [UIColor whiteColor];
        self.distanceLabel.opaque = YES;
        [self.contentView addSubview:self.distanceLabel];
        
        
        self.callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.callBtn.frame = CGRectMake(250, 37/2, 43, 43);
        self.callBtn.opaque = YES;
        
        [self.contentView addSubview:self.callBtn];
                        
       //backgroundView
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width+2, self.frame.size.height)];
        backgroundView.backgroundColor = [UIColor whiteColor];
        backgroundView.opaque = YES;
        
        self.backgroundView = backgroundView;
        self.backgroundView.layer.cornerRadius = 4.0f;
        self.backgroundView.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.backgroundView.layer.shadowOpacity = 0.2;
        self.backgroundView.layer.shadowOffset = CGSizeMake(0, 1);
        self.backgroundView.layer.shadowRadius = 1;
        self.backgroundView.layer.shouldRasterize = YES;
        self.backgroundView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;


    }
    return self;
}

- (UIImage*)renderThumbnail:(UIImage *)image
{
    if (image) {
        if (NULL != UIGraphicsBeginImageContextWithOptions) {
            UIGraphicsBeginImageContextWithOptions(thumbnailSize, YES, 0);
        }
        else
        {
            UIGraphicsBeginImageContext(thumbnailSize);
        }
        [image drawInRect:thumbnailRect];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
    return nil;
    
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
