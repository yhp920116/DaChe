//
//  CustomerCommentCell.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-22.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "CustomerCommentCell.h"
#import "DPMeterView.h"
#import "UIBezierPath+BasicShapes.h"

@implementation CustomerCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //commentView
        self.commentView = [[DPMeterView alloc] initWithFrame:CGRectMake(10, 10, 100, 15)];
        [self.commentView setMeterType:DPMeterTypeLinearHorizontal];
        [self.commentView setShape:[UIBezierPath stars:5 shapeInFrame:CGRectMake(0, 0, 100, 15)].CGPath];
        [self.commentView setTrackTintColor:[UIColor lightGrayColor]];
        
        [self.commentView setProgressTintColor:[UIColor darkGrayColor]];
        [self.commentView add:0.8 animated:YES];
        self.commentView.progressTintColor = [UIColor colorWithRed:255/255.f green:199/255.f blue:87/255.f alpha:1.f];
        [self.commentView setGradientOrientationAngle:2*M_PI];
        [self.contentView addSubview:self.commentView];
        
        //phoneNumLable and commentDateLabel
        self.phoneNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 13, 110, 10)];
        self.phoneNumLabel.font = [UIFont systemFontOfSize:10.0f];
        self.phoneNumLabel.textColor = [UIColor lightGrayColor];
        self.phoneNumLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.phoneNumLabel];
        
        self.commentDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(245, 13, 55, 10)];
        self.commentDateLabel.font = [UIFont systemFontOfSize:10.0f];
        self.commentDateLabel.textColor = [UIColor lightGrayColor];
        self.commentDateLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.commentDateLabel];
        
        
        self.commentDetailLabel = [[UILabel alloc] init];
        self.commentDetailLabel.font = [UIFont systemFontOfSize:12.0f];
        self.commentDetailLabel.textColor = [UIColor blackColor];
        self.commentDetailLabel.backgroundColor = [UIColor clearColor];
        self.commentDetailLabel.numberOfLines = 0;
       
        [self.contentView addSubview:self.commentDetailLabel];
        
        //separatorLine
        self.separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 79, 310, 1)];
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
