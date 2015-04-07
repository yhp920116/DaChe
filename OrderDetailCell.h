//
//  OrderDetailCell.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-9-13.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailCell : UITableViewCell

@property(nonatomic, strong) UILabel *orderNumLabel;
@property(nonatomic, strong) UILabel *orderStatusLabel;
@property(nonatomic, strong) UILabel *orderWayLabel;
@property(nonatomic, strong) UIImageView *separatorLine;

@property(nonatomic, strong) UILabel *driverPhoneNumLabel;
@property(nonatomic, strong) UILabel *driverNameLabel;
@property(nonatomic, strong) UILabel *driverSexLabel;
@property(nonatomic, strong) UILabel *orderCreatTimeLabel;
@property(nonatomic, strong) UILabel *reservationTimLabel;
@property(nonatomic, strong) UILabel *driverNumLabel;
@property(nonatomic, strong) UILabel *userLocationLabel;

@property(nonatomic, strong) UIButton *callDriverBtn;
@property(nonatomic, strong) UIButton *orderModifyBtn;
@property(nonatomic, strong) UIButton *cancelOrderBtn;

@end
