//
//  CollapseClickCell.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-26.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "CollapseClickCell.h"
#import <QuartzCore/QuartzCore.h>
#define HeaderHeight 56

@implementation CollapseClickCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //headerView
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, HeaderHeight)];
        [self addSubview:_headerView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 294, 14)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [_headerView addSubview:_titleLabel];
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(6, 26, 286, 30)];
        _textField.font = [UIFont systemFontOfSize:12.0f];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.delegate = self;
        _textField.layer.borderWidth = 0.2f;
        _textField.layer.cornerRadius = 2.0f;
        _textField.layer.borderColor = [UIColor grayColor].CGColor;
        [_headerView addSubview:_textField];
        
        _headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headerBtn.frame = CGRectMake(0,0,300,HeaderHeight);
        _headerBtn.adjustsImageWhenHighlighted = NO;
        [_headerView addSubview:_headerBtn];
        
        
        //contentView
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, HeaderHeight+10, 300, 100)];
        [self addSubview:_contentView];
        
        //Take care!!!
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+(CollapseClickCell *)newCollapseClickCellWithTitle:(NSString *)title Index:(NSInteger)index content:(UIView *)contentView
{
    CollapseClickCell *cell = [[CollapseClickCell alloc] initWithFrame:CGRectMake(0, 0, 300, HeaderHeight)];
    cell.titleLabel.text = title;
    cell.index = index;
    cell.headerBtn.tag = index;
    cell.contentView.frame = CGRectMake(cell.contentView.frame.origin.x, cell.contentView.frame.origin.y, cell.contentView.frame.size.width, contentView.frame.size.height);
    [cell.contentView addSubview:contentView];
//    cell.contentView = contentView;
    
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
