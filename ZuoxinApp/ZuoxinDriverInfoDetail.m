//
//  ZuoxinDriverInfoDetail.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-9-16.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "ZuoxinDriverInfoDetail.h"
#import "OrderDetailView.h"
#import <QuartzCore/QuartzCore.h>
#import "SIAlertView.h"

@interface ZuoxinDriverInfoDetail ()

@end

@implementation ZuoxinDriverInfoDetail

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _orderDic = [[NSDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self loadCustomBar];
    [self loadDriverInfoDetail];
}

- (void)loadCustomBar
{
    self.navTitleLabel.text = @"订单详情与修订";
    self.rightBtn.hidden = YES;
    
    self.view.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1];
}

- (void)loadDriverInfoDetail
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 47, 320, self.view.frame.size.height-47)];
    scrollView.tag = 998;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    OrderDetailView *orderDetailView = [[OrderDetailView alloc] initWithFrame:CGRectMake(10, 10, 300, 350)];
    [self setLayerCornerRadiusAndshadowInView:orderDetailView];
    [scrollView addSubview:orderDetailView];
    
    orderDetailView.orderNumLabel.text = [[NSString alloc] initWithFormat:@"订单号：%@",[_orderDic valueForKey:@"orderid"]];
    switch ([[_orderDic valueForKey:@"orderstate"] intValue]) {
        case 0:
        {
            orderDetailView.orderStatusLabel.text = @"新单";
            break;
        }
        case 1:
        {
            orderDetailView.orderStatusLabel.text = @"服务开始";
            break;
        }
        case 2:
        {
            orderDetailView.orderStatusLabel.text = @"服务结束";
            break;
        }
        case 3:
        {
            orderDetailView.orderStatusLabel.text = @"已上报";
            break;
        }
        case 5:
        {
            orderDetailView.orderStatusLabel.text = @"已消单";
            break;
        }
    }
    switch ([[_orderDic valueForKey:@"ordertype"] intValue]) {
        case 0:
        {
            orderDetailView.orderWayLabel.text = @"400下单";
            break;
        }
        case 1:
        {
            orderDetailView.orderWayLabel.text = @"手机下单";
            break;
        }
        case 2:
        {
            orderDetailView.orderWayLabel.text = @"补单";
            break;
        }
        case 3:
        {
            orderDetailView.orderWayLabel.text = @"客户直接呼叫";
            break;
        }
    }
    
    orderDetailView.orderIDLabel.text = [[NSString alloc] initWithFormat:@"代驾协议单号：%@",[[_orderDic valueForKey:@"driver"] valueForKey:@"driverid"]];
    orderDetailView.customerNameLabel.text = [[NSString alloc] initWithFormat:@"顾客姓名：%@",[[_orderDic valueForKey:@"customer"] valueForKey:@"customername"]];
    orderDetailView.carnoLabel.text = [[NSString alloc] initWithFormat:@"车牌号：%@",[_orderDic valueForKey:@"carno"]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];

    NSDate *startTime = [[NSDate alloc] initWithTimeIntervalSince1970:[[_orderDic valueForKey:@"rstarttime"] intValue]];
    NSString *startTimeStr = [dateFormatter stringFromDate:startTime];
    orderDetailView.setOutTimeLabel.text = [[NSString alloc] initWithFormat:@"出发时间：%@",startTimeStr];
    
    NSDate *arrivalTime = [[NSDate alloc] initWithTimeIntervalSince1970:[[_orderDic valueForKey:@"rendtime"] intValue]];
    NSString *arrivalTimeStr = [dateFormatter stringFromDate:arrivalTime];
    orderDetailView.arrivalTimeLabel.text = [[NSString alloc] initWithFormat:@"到达时间：%@",arrivalTimeStr];
    
    orderDetailView.waiteTimeLabel.text = [[NSString alloc] initWithFormat:@"等待时间：%@",[_orderDic valueForKey:@"waitminutes"]];
    orderDetailView.setOutAddressLabel.text = [[NSString alloc] initWithFormat:@"出发地点：%@",[_orderDic valueForKey:@"rstartaddress"]];

    orderDetailView.arrivalAddressLabel.text = [[NSString alloc] initWithFormat:@"到达地点：%@",[_orderDic valueForKey:@"rendaddress"]];
    orderDetailView.distanceLabel.text = [[NSString alloc] initWithFormat:@"里程：%@",[_orderDic valueForKey:@"distance"]];
    orderDetailView.chargeLabel.text = [[NSString alloc] initWithFormat:@"应收代驾费用：%f元",[[_orderDic valueForKey:@"totalamount"] floatValue]];
    
    orderDetailView.conponLabel.text = [[NSString alloc] initWithFormat:@"[VIP][优惠卷]抵扣卷：%f元",[[_orderDic valueForKey:@"vipamount"] floatValue] + [[_orderDic valueForKey:@"coupon"] floatValue]];
    orderDetailView.cashLabel.text = [[NSString alloc] initWithFormat:@"实收现金：%f元",[[_orderDic valueForKey:@"cash"] floatValue]];

    switch ([[_orderDic valueForKey:@"invoice"] intValue]) {
        case 0:
        {
            orderDetailView.receiptLabel.text = @"是否给发票：是";
            break;
        }
        case 1:
        {
            orderDetailView.receiptLabel.text = @"是否给发票：否";
            break;
        }
    }
    
    switch ([[_orderDic valueForKey:@"complaint"] boolValue]) {
        case YES:
        {
           orderDetailView.complainLabel.text = @"是否投诉客户：是"; 
            break;
        }
        case NO:
        {
            orderDetailView.complainLabel.text = @"是否投诉客户：否";
            break;
        }
    }
    
    orderDetailView.remarkLabel.text = [[NSString alloc] initWithFormat:@"备注：%@",[_orderDic valueForKey:@"remark"]];
    [orderDetailView.callDriverBtn addTarget:self action:@selector(callDriverBtn) forControlEvents:UIControlEventTouchUpInside];

    switch ([[_orderDic valueForKey:@"orderstate"] intValue]) {
        case 0:
        case 1:
        {    UIView *tipsView = [[UIView alloc] initWithFrame:CGRectMake(10, 370, 300, 180)];
            tipsView.backgroundColor = [UIColor whiteColor];
            [self setLayerCornerRadiusAndshadowInView:tipsView];
            [scrollView addSubview:tipsView];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 26)];
            titleLabel.text = @"    请您及时告诉司机您的具体要求 *";
            titleLabel.font = [UIFont systemFontOfSize:12.0f];
            titleLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
            titleLabel.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.1];
            [tipsView addSubview:titleLabel];
            
            UILabel *timeTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 36, 200, 10)];
            timeTitle.text = @"您要求司机到达的时间 *";
            timeTitle.font = [UIFont systemFontOfSize:10.0f];
            timeTitle.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
            [self setLayerCornerRadiusAndshadowInView:timeTitle];
            [tipsView addSubview:timeTitle];
            
            _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 280, 30)];
            _timeLabel.text = @"［30|60|90分钟后到］";
            _timeLabel.font = [UIFont systemFontOfSize:12.0f];
            _timeLabel.textColor = [UIColor grayColor];
            _timeLabel.layer.borderWidth = 0.2f;
            _timeLabel.layer.cornerRadius = 2.0f;
            _timeLabel.layer.borderColor = [UIColor grayColor].CGColor;
            _timeLabel.userInteractionEnabled = YES;
            [tipsView addSubview:_timeLabel];
            
            UIButton *popBtnOne = [UIButton buttonWithType:UIButtonTypeCustom];
            popBtnOne.frame = CGRectMake(248, 0, 30, 30);
            popBtnOne.backgroundColor = [UIColor clearColor];
            popBtnOne.tag = 0;
            [popBtnOne setImage:[UIImage imageNamed:@"popimg.png"] forState:UIControlStateNormal];
            [popBtnOne addTarget:self action:@selector(popBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_timeLabel addSubview:popBtnOne];
            
            UILabel *locationTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 200, 10)];
            locationTitle.text = @"您的位置 *";
            locationTitle.font = [UIFont systemFontOfSize:10.0f];
            locationTitle.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
            [self setLayerCornerRadiusAndshadowInView:locationTitle];
            [tipsView addSubview:locationTitle];
            
            _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 104, 280, 30)];
            _locationLabel.font = [UIFont systemFontOfSize:12.0f];
            _locationLabel.textColor = [UIColor grayColor];
            _locationLabel.layer.borderWidth = 0.2f;
            _locationLabel.layer.cornerRadius = 2.0f;
            _locationLabel.layer.borderColor = [UIColor grayColor].CGColor;
            _locationLabel.userInteractionEnabled = YES;
            [tipsView addSubview:_locationLabel];
            
            UIButton *popBtnThree = [UIButton buttonWithType:UIButtonTypeCustom];
            popBtnThree.backgroundColor = [UIColor whiteColor];
            popBtnThree.frame = CGRectMake(248, 0, 30, 30);
            popBtnThree.contentMode = UIViewContentModeScaleAspectFit;
            popBtnThree.tag = 1;
            [popBtnThree setImage:[UIImage imageNamed:@"locationimg_r.png"] forState:UIControlStateNormal];
            [popBtnThree addTarget:self action:@selector(popBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_locationLabel addSubview:popBtnThree];
            
            
            //confirmButton
            
            UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            confirmBtn.frame = CGRectMake(10, 144, 280, 30);
            confirmBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
            [confirmBtn setTitle:@"发送给司机" forState:UIControlStateNormal];
            [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [confirmBtn setBackgroundImage:BlueBtnBG forState:UIControlStateNormal];
            [confirmBtn addTarget:self action:@selector(confirmBtn) forControlEvents:UIControlEventTouchUpInside];
            [tipsView addSubview:confirmBtn];
            
            scrollView.contentSize = CGSizeMake(320,560);

            break;
        }
        case 2:
        case 3:
        case 5:
        {
            UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(10, 370, 300, 210)];
            commentView.backgroundColor = [UIColor whiteColor];
            [self setLayerCornerRadiusAndshadowInView:commentView];
            [scrollView addSubview:commentView];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 26)];
            titleLabel.text = @"    请您对本次服务进行点评 *";
            titleLabel.font = [UIFont systemFontOfSize:12.0f];
            titleLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
            titleLabel.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.1];
            [commentView addSubview:titleLabel];
            
            UILabel *timeTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 36, 200, 10)];
            timeTitle.text = @"您对本次服务的评价 *";
            timeTitle.font = [UIFont systemFontOfSize:10.0f];
            timeTitle.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
            [self setLayerCornerRadiusAndshadowInView:timeTitle];
            [commentView addSubview:timeTitle];
            
            _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 280, 30)];
            _commentLabel.text = @"非常满意";
            _commentLabel.font = [UIFont systemFontOfSize:12.0f];
            _commentLabel.textColor = [UIColor grayColor];
            _commentLabel.layer.borderWidth = 0.2f;
            _commentLabel.layer.cornerRadius = 2.0f;
            _commentLabel.layer.borderColor = [UIColor grayColor].CGColor;
            _commentLabel.userInteractionEnabled = YES;
            [commentView addSubview:_commentLabel];
            
            UIButton *popBtnOne = [UIButton buttonWithType:UIButtonTypeCustom];
            popBtnOne.frame = CGRectMake(248, 0, 30, 30);
            popBtnOne.backgroundColor = [UIColor clearColor];
            popBtnOne.tag = 2;
            [popBtnOne setImage:[UIImage imageNamed:@"popimg.png"] forState:UIControlStateNormal];
            [popBtnOne addTarget:self action:@selector(popBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_commentLabel addSubview:popBtnOne];
            
            UILabel *locationTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 200, 10)];
            locationTitle.text = @"您对本次服务的意见和建议 *";
            locationTitle.font = [UIFont systemFontOfSize:10.0f];
            locationTitle.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
            [self setLayerCornerRadiusAndshadowInView:locationTitle];
            [commentView addSubview:locationTitle];
            
            _commentTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 104, 280, 60)];
            _commentTextView.font = [UIFont systemFontOfSize:12.0f];
            _commentTextView.delegate = self;
            _commentTextView.textColor = [UIColor grayColor];
            _commentTextView.layer.borderWidth = 0.2f;
            _commentTextView.layer.cornerRadius = 2.0f;
            _commentTextView.layer.borderColor = [UIColor grayColor].CGColor;
            _commentTextView.userInteractionEnabled = YES;
            [commentView addSubview:_commentTextView];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
            
            //confirmButton
            
            UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            confirmBtn.frame = CGRectMake(10, 174, 280, 30);
            confirmBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
            [confirmBtn setTitle:@"我确定点评" forState:UIControlStateNormal];
            [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [confirmBtn setBackgroundImage:BlueBtnBG forState:UIControlStateNormal];
            [confirmBtn addTarget:self action:@selector(confirmBtn) forControlEvents:UIControlEventTouchUpInside];
            [commentView addSubview:confirmBtn];
            
            scrollView.contentSize = CGSizeMake(320,590);

        }
        default:
            break;
    }
    
    
    
}

#pragma mark - keyboard
- (void)keyboardShow:(NSNotification *)aNotification
{
    
    UIScrollView *scrollView = (UIScrollView*)[self.view viewWithTag:998];
    [UIView animateWithDuration:0.3 animations:^{
        scrollView.contentOffset = CGPointMake(0, 300);
    }];
    
}

- (void)keyboardHidden:(NSNotification *)aNotification
{
    UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:998];
    [UIView animateWithDuration:0.3 animations:^{
        scrollView.contentOffset = CGPointMake(0, 0);

    }];

}

#pragma mark - textViewdelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSCharacterSet *doneButtonCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSRange replacementTextRange = [text rangeOfCharacterFromSet:doneButtonCharacterSet];
    NSUInteger location = replacementTextRange.location;
    
    if (textView.text.length + text.length > 280) {
        if (location != NSNotFound) {
            [textView resignFirstResponder];
        }
        return NO;
    }
    else if (location != NSNotFound)
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


#pragma mark - btnClick
- (void)popBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"请选择" andMessage:nil];
    alertView.titleFont = [UIFont systemFontOfSize:14.0f];
    alertView.titleColor = [UIColor grayColor];
    
    switch (btn.tag) {
        case 0:
        {
            [alertView addButtonWithTitle:@"30分钟" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
                _timeLabel.text = @"  30分钟";
            }];
            [alertView addButtonWithTitle:@"60分钟" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
                _timeLabel.text = @"  60分钟";
            }];
            [alertView addButtonWithTitle:@"90分钟" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
                _timeLabel.text = @"  90分钟";
            }];
            [alertView show];
            break;
        }
        case 1:
        {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            _locationLabel.text = [userDefaults objectForKey:@"UserAddress"];
            break;
        }
        case 2:
        {
            [alertView addButtonWithTitle:@"非常满意" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
                _commentLabel.text = @"  非常满意";
            }];
            [alertView addButtonWithTitle:@"满意" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
                _commentLabel.text = @"  满意";
            }];
            [alertView addButtonWithTitle:@"不满意" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
                _commentLabel.text = @"  不满意";
            }];
            [alertView show];
            break;
        }
    }
}


-(void)callDriverBtn
{
    NSString *tel = [[NSString alloc] initWithFormat:@"tel://%@",[[_orderDic valueForKey:@"driver"] valueForKey:@"mobile"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];

}

- (void)confirmBtn
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
