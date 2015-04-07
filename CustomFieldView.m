//
//  CustomFieldView.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-30.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "CustomFieldView.h"
#import <QuartzCore/QuartzCore.h>

#define TitleViewHeight 24

@implementation CustomFieldView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.layer.cornerRadius = 4.0f;

        UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        shadowView.backgroundColor = [UIColor whiteColor];
        shadowView.layer.shadowColor = [UIColor blackColor].CGColor
        ;
        shadowView.layer.shadowOpacity = 0.2;
        shadowView.layer.shadowOffset = CGSizeMake(4, 8);
        shadowView.layer.shadowRadius = 5;
        [self addSubview:shadowView];
    
        _totalHeight = 0.0;
        
    }
    return self;
}

- (void)setTitleView:(NSString *)title
{
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, TitleViewHeight)];
    _titleView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self addSubview:_titleView];
    
    UILabel *titileLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 5, 300-28, 14)];
    titileLabel.backgroundColor = [UIColor clearColor];
    titileLabel.textColor = [UIColor blackColor];
    titileLabel.text = title;
    titileLabel.font = [UIFont systemFontOfSize:14.0f];
    
    _totalHeight += TitleViewHeight;
    [_titleView addSubview:titileLabel];
}

- (void)setcontentView:(UIView *)contentView
{
    _filedContentView = contentView;
    if (_titleView) {
        _filedContentView.frame = CGRectMake(_filedContentView.frame.origin.x, TitleViewHeight, 300, _filedContentView.frame.size.height);
        
    }
    else
    {
        _filedContentView.frame = CGRectMake(_filedContentView.frame.origin.x, 0, 300, _filedContentView.frame.size.height);
    }
    _totalHeight += _filedContentView.frame.size.height;
    [self addSubview:_filedContentView];
    
    [self setContentSize:CGSizeMake(self.frame.size.width, _totalHeight)];
    [self setContentOffset:CGPointZero];


}

@end
