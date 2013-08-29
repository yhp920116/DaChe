//
//  FlatRoundedImageView.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-28.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "FlatRoundedImageView.h"
#import <QuartzCore/QuartzCore.h>

@implementation FlatRoundedImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 1.0f;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = CGRectGetWidth(self.bounds)/2;
}

+ (FlatRoundedImageView *)FlatRoundedImageViewWithImage:(UIImage *)image
{
    FlatRoundedImageView *flatImgView = [[FlatRoundedImageView alloc] initWithImage:image];
    flatImgView.layer.masksToBounds = YES;
    return flatImgView;
}


@end
