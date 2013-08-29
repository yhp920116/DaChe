//
//  FlatRoundedImageView.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-28.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlatRoundedImageView : UIImageView

+ (FlatRoundedImageView *)FlatRoundedImageViewWithImage:(UIImage *)image;

@property(nonatomic,strong) UIColor *borderColor;

@end
