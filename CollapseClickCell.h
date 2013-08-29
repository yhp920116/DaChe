//
//  CollapseClickCell.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-26.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollapseClickCell : UIView<UITextFieldDelegate>

//header
@property(nonatomic, strong) UIView *headerView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, strong) UIButton *headerBtn;
@property(nonatomic, strong) UIImageView *arrowView;

//body
@property(nonatomic, strong) UIView *contentView;

//properties
@property(nonatomic, assign) BOOL isClicked;
@property(nonatomic, assign) NSInteger index;

//init

+(CollapseClickCell *)newCollapseClickCellWithTitle:(NSString *)title Index:(NSInteger)index content:(UIView *)contentView;

@end
