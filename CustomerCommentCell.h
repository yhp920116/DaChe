//
//  CustomerCommentCell.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-22.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPMeterView;

@interface CustomerCommentCell : UITableViewCell

@property(nonatomic, strong) DPMeterView *commentView;
@property(nonatomic, strong) UILabel *phoneNumLabel;
@property(nonatomic, strong) UILabel *commentDateLabel;
@property(nonatomic, strong) UILabel *commentDetailLabel;
@property(nonatomic, strong) UIImageView *separatorLine;


@end
