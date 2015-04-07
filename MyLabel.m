//
//  MyLabel.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-9-22.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "MyLabel.h"
#import <CoreText/CoreText.h>
#import "Configuration.h"

@implementation MyLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, self.bounds.size.height+4)
    ;
    CGContextConcatCTM(context, flipVertical);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    UIFont *font = MediumFont;
    CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
    [attributedString addAttribute:(NSString*)kCTFontAttributeName value:(__bridge id)fontRef range:NSMakeRange(0, [attributedString length])];
    [attributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(__bridge id)BlackFontColor.CGColor range:NSMakeRange(0, [attributedString length])];
    [attributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(__bridge id)[UIColor orangeColor].CGColor range:NSMakeRange([attributedString length]-1, 1)];
    CTFramesetterRef ctFrameSetter = CTFramesetterCreateWithAttributedString((__bridge CFMutableAttributedStringRef)attributedString);
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect bounds = CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height);
    CGPathAddRect(path, NULL, bounds);
    
    CTFrameRef ctFrame = CTFramesetterCreateFrame(ctFrameSetter,CFRangeMake(0, 0), path, NULL);
    CTFrameDraw(ctFrame, context);
    
}

@end
