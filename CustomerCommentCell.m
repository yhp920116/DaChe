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
        self.commentView = [[DPMeterView alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
        [self.commentView setShape:[UIBezierPath stars:5 shapeInFrame:CGRectMake(10, 20, 80, 20)].CGPath];
        [self.commentView setTrackTintColor:[UIColor lightGrayColor]];
        
        [self.commentView setProgressTintColor:[UIColor darkGrayColor]];
        [self.commentView add:0.8 animated:YES];
        self.commentView.progressTintColor = [UIColor colorWithRed:255/255.f green:199/255.f blue:87/255.f alpha:1.f];
        [self.commentView setGradientOrientationAngle:2*M_PI];
        [self.contentView addSubview:self.commentView];
        
        //phoneNumLable and commentDateLabel
        self.phoneNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, 110, 14)];
        self.phoneNumLabel.font = [UIFont systemFontOfSize:14.0f];
        self.phoneNumLabel.textColor = [UIColor blackColor];
        self.phoneNumLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.phoneNumLabel];
        
        self.commentDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 10, 50, 14)];
        self.commentDateLabel.font = [UIFont systemFontOfSize:14.0f];
        self.commentDateLabel.textColor = [UIColor blackColor];
        self.commentDateLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.commentDateLabel];
        
        //
        CGSize size = CGSizeMake(280, 1000);
        
        self.commentDetailLabel = [[UILabel alloc] init];
        self.commentDetailLabel.font = [UIFont systemFontOfSize:14.0f];
        self.commentDetailLabel.textColor = [UIColor blackColor];
        self.commentDetailLabel.backgroundColor = [UIColor clearColor];
        self.commentDetailLabel.numberOfLines = 0;
        self.fitCommentDetailText = ^(NSString *text){
            CGSize textSize = [text sizeWithFont:self.commentDetailLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
            self.commentDetailLabel.frame = CGRectMake(10, 34, textSize.width, textSize.height);
        };
        [self.contentView addSubview:self.commentDetailLabel];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
