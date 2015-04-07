//
//  OrderDetailView.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-9-16.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "OrderDetailView.h"

@implementation OrderDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.orderNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 12)];
        self.orderNumLabel.textColor = [UIColor colorWithRed:79.0/255.0 green:142.0/255.0 blue:28.0/255.0 alpha:1];
        self.orderNumLabel.font = [UIFont systemFontOfSize:12.0f];
        self.orderNumLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.orderNumLabel];
        
        self.orderStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 10, 60, 12)];
        self.orderStatusLabel.textColor = [UIColor colorWithRed:79.0/255.0 green:142.0/255.0 blue:28.0/255.0 alpha:1];
        self.orderStatusLabel.font = [UIFont systemFontOfSize:12.0f];
        self.orderStatusLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.orderStatusLabel];
        
        self.orderWayLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 10, 60, 12)];
        self.orderWayLabel.textColor = [UIColor colorWithRed:79.0/255.0 green:142.0/255.0 blue:28.0/255.0 alpha:1];
        self.orderWayLabel.font = [UIFont systemFontOfSize:12.0f];
        self.orderWayLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.orderWayLabel];
        
        self.separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 32, 300, 1)];
        self.separatorLine.image = [UIImage imageNamed:@"separator@2x.png"];
        [self addSubview:self.separatorLine];
        
        self.orderIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 42, 280, 10)];
        [self setLabelProperties:self.orderIDLabel];
        [self addSubview:self.orderIDLabel];
        
        self.customerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 280, 10)];
        [self setLabelProperties:self.customerNameLabel];
        [self addSubview:self.customerNameLabel];
        
        self.customerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 280, 10)];
        [self setLabelProperties:self.customerNameLabel];
        [self addSubview:self.customerNameLabel];
        
        self.carnoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 78, 280, 10)];
        [self setLabelProperties:self.carnoLabel];
        [self addSubview:self.carnoLabel];
        
        self.setOutTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 96, 280, 10)];
        [self setLabelProperties:self.setOutTimeLabel];
        [self addSubview:self.setOutTimeLabel];
        
        self.arrivalTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 114, 280, 10)];
        [self setLabelProperties:self.arrivalTimeLabel];
        [self addSubview:self.arrivalTimeLabel];
        
        self.waiteTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 132, 280, 10)];
        [self setLabelProperties:self.waiteTimeLabel];
        [self addSubview:self.waiteTimeLabel];
        
        self.setOutAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, 280, 10)];
        [self setLabelProperties:self.setOutAddressLabel];
        [self addSubview:self.setOutAddressLabel];
        
        self.arrivalAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 168, 280, 10)];
        [self setLabelProperties:self.arrivalAddressLabel];
        [self addSubview:self.arrivalAddressLabel];
        
        self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 186, 280, 10)];
        [self setLabelProperties:self.distanceLabel];
        [self addSubview:self.distanceLabel];
        
        self.chargeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 204, 280, 10)];
        [self setLabelProperties:self.chargeLabel];
        [self addSubview:self.chargeLabel];
        
        self.conponLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 222, 280, 10)];
        [self setLabelProperties:self.conponLabel];
        [self addSubview:self.conponLabel];
        
        self.cashLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 240, 280, 10)];
        [self setLabelProperties:self.cashLabel];
        [self addSubview:self.cashLabel];
        
        self.receiptLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 258, 280, 10)];
        [self setLabelProperties:self.receiptLabel];
        [self addSubview:self.receiptLabel];
        
        self.complainLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 276, 280, 10)];
        [self setLabelProperties:self.complainLabel];
        [self addSubview:self.complainLabel];
        
        self.remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 294, 280, 10)];
        [self setLabelProperties:self.remarkLabel];
        [self addSubview:self.remarkLabel];
        
        UIImage *greenImg = [[UIImage imageNamed:@"greenbtn.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        self.callDriverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.callDriverBtn.opaque = YES;
        self.callDriverBtn.frame = CGRectMake(10, 312, 280, 30);
        [self.callDriverBtn setBackgroundImage:greenImg forState:UIControlStateNormal];
        [self.callDriverBtn setTitle:@"呼叫司机" forState:UIControlStateNormal];
        [self.callDriverBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self addSubview:self.callDriverBtn];
        
    }
    return self;
}

- (void)setLabelProperties:(UILabel *)label
{
    label.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    label.font = [UIFont systemFontOfSize:10.0f];
    label.backgroundColor = [UIColor whiteColor];
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
