//
//  CustomFieldView.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-30.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//
@class CustomFieldView;
//@protocol CustomFieldViewDelegate <NSObject>
//@required
//- (UIView *)contentViewForCustomFieldView:(CustomFieldView*)fieldview;
//@optional
//- (NSString *)titleLabelForCustomFieldvView:(CustomFieldView*)fieldview;
//
//@end


#import <UIKit/UIKit.h>

@interface CustomFieldView : UIScrollView<UITableViewDataSource,UITableViewDelegate>
{
    UIView *_titleView;
    UIView *_filedContentView;
    float _totalHeight;
}

//Methode

- (void)setTitleView:(NSString *)title;

- (void)setcontentView:(UIView *)contentView;

@end
