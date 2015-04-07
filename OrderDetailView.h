//
//  OrderDetailView.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-9-16.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailView : UIView

@property(nonatomic, strong) UILabel *orderNumLabel;
@property(nonatomic, strong) UILabel *orderStatusLabel;
@property(nonatomic, strong) UILabel *orderWayLabel;
@property(nonatomic, strong) UIImageView *separatorLine;

@property(nonatomic, strong) UILabel *orderIDLabel;
@property(nonatomic, strong) UILabel *customerNameLabel;
@property(nonatomic, strong) UILabel *carnoLabel;
@property(nonatomic, strong) UILabel *setOutTimeLabel;
@property(nonatomic, strong) UILabel *arrivalTimeLabel;
@property(nonatomic, strong) UILabel *waiteTimeLabel;
@property(nonatomic, strong) UILabel *setOutAddressLabel;
@property(nonatomic, strong) UILabel *arrivalAddressLabel;
@property(nonatomic, strong) UILabel *distanceLabel;
@property(nonatomic, strong) UILabel *chargeLabel;
@property(nonatomic, strong) UILabel *conponLabel;
@property(nonatomic, strong) UILabel *cashLabel;
@property(nonatomic, strong) UILabel *receiptLabel;
@property(nonatomic, strong) UILabel *complainLabel;
@property(nonatomic, strong) UILabel *remarkLabel;

@property(nonatomic, strong) UIButton *callDriverBtn;

@end
