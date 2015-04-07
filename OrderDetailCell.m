//
//  OrderDetailCell.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-9-13.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "OrderDetailCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation OrderDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(10, 0, 300, 180);
        
        self.orderNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 12)];
        self.orderNumLabel.textColor = [UIColor colorWithRed:79.0/255.0 green:142.0/255.0 blue:28.0/255.0 alpha:1];
        self.orderNumLabel.font = [UIFont systemFontOfSize:12.0f];
        self.orderNumLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.orderNumLabel];
        
        self.orderStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 10, 60, 12)];
        self.orderStatusLabel.textColor = [UIColor colorWithRed:79.0/255.0 green:142.0/255.0 blue:28.0/255.0 alpha:1];
        self.orderStatusLabel.font = [UIFont systemFontOfSize:12.0f];
        self.orderStatusLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.orderStatusLabel];
        
        self.orderWayLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 10, 60, 12)];
        self.orderWayLabel.textColor = [UIColor colorWithRed:79.0/255.0 green:142.0/255.0 blue:28.0/255.0 alpha:1];
        self.orderWayLabel.font = [UIFont systemFontOfSize:12.0f];
        self.orderWayLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.orderWayLabel];
        
        self.separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 32, 300, 1)];
        self.separatorLine.image = [UIImage imageNamed:@"separator@2x.png"];
        [self.contentView addSubview:self.separatorLine];
        
        self.driverPhoneNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 42, 150, 10)];
        self.driverPhoneNumLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        self.driverPhoneNumLabel.font = [UIFont systemFontOfSize:10.0f];
        self.driverPhoneNumLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.driverPhoneNumLabel];
        
        self.driverNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(165, 42, 50, 10)];
        self.driverNameLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        self.driverNameLabel.font = [UIFont systemFontOfSize:10.0f];
        self.driverNameLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.driverNameLabel];
        
        self.driverSexLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 42, 50, 10)];
        self.driverSexLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        self.driverSexLabel.font = [UIFont systemFontOfSize:10.0f];
        self.driverSexLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.driverSexLabel];
        
        self.orderCreatTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 150, 10)];
        self.orderCreatTimeLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        self.orderCreatTimeLabel.font = [UIFont systemFontOfSize:10.0f];
        self.orderCreatTimeLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.orderCreatTimeLabel];
        
        self.reservationTimLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 78, 150, 10)];
        self.reservationTimLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        self.reservationTimLabel.font = [UIFont systemFontOfSize:10.0f];
        self.reservationTimLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.reservationTimLabel];
        
        self.driverNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 96, 150, 10)];
        self.driverNumLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        self.driverNumLabel.font = [UIFont systemFontOfSize:10.0f];
        self.driverNumLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.driverNumLabel];
        
        self.userLocationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 114, 290, 10)];
        self.userLocationLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        self.userLocationLabel.font = [UIFont systemFontOfSize:10.0f];
        self.userLocationLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.userLocationLabel];
        
        
        UIImage *greenImg = [[UIImage imageNamed:@"greenbtn.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        self.callDriverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.callDriverBtn.opaque = YES;
        self.callDriverBtn.frame = CGRectMake(10, 134, 280, 77/2);
        [self.callDriverBtn setBackgroundImage:greenImg forState:UIControlStateNormal];
        [self.callDriverBtn setTitle:@"呼叫司机" forState:UIControlStateNormal];
        [self.callDriverBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.callDriverBtn];
        
        
        
        //backgroundView
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
        backgroundView.backgroundColor = [UIColor whiteColor];
        
        self.backgroundView = backgroundView;
        self.backgroundView.layer.cornerRadius = 4.0f;
        self.backgroundView.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.backgroundView.layer.shadowOpacity = 0.2;
        self.backgroundView.layer.shadowOffset = CGSizeMake(0, 1);
        self.backgroundView.layer.shadowRadius = 1;
        self.backgroundView.layer.shouldRasterize = YES;
        self.backgroundView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        //selectedBackgroundView
        UIImage *renderImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"renderimg" ofType:@"png"]];
        UIImageView *renderImgView = [[UIImageView alloc] initWithImage:renderImg];
        self.selectedBackgroundView = renderImgView;
        
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
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
