//
//  ZuoxinReservationDetail.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-22.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "ZuoxinReservationDetail.h"
#import "CustomBtn.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomTextField.h"
#import "TabBarController.h"
#import "CollapseClick.h"

@interface ZuoxinReservationDetail ()

@end

@implementation ZuoxinReservationDetail

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    TabBarController *tabBarController = (TabBarController*)self.tabBarController;
    [tabBarController tabBarHidden:YES];
}

- (void)loadCustomBar
{
    //backgroundView
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg.jpg"]];
    self.customBtn.hidden = YES;
    self.navTitleLabel.text = @"预约多位司机";
}

- (void)loadMainView
{
    //inputPhoneNumView
    UIView *inputPhoneNumView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 62)];
    inputPhoneNumView.backgroundColor = [UIColor whiteColor];
//    inputPhoneNumView.layer.borderWidth = 1.0f;
//    inputPhoneNumView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:inputPhoneNumView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 200, 14.0f)];
    label.text = @"您的联系电话:";
    label.font = [UIFont systemFontOfSize:14.0f];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    [inputPhoneNumView addSubview:label];
    
    _phoneNumField = [[CustomTextField alloc] initWithFrame:CGRectMake(6, 27, 288, 25)];
    _phoneNumField.font = [UIFont systemFontOfSize:16.0f];
    _phoneNumField.borderStyle = UITextBorderStyleNone;
    _phoneNumField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumField.delegate = self;
    _phoneNumField.layer.borderWidth = 1.0f;
    _phoneNumField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [inputPhoneNumView addSubview:_phoneNumField];
    
    //myCollapseClickView
    _myCollapseClick = [[CollapseClick alloc] initWithFrame:CGRectMake(10,82, 300,460-44-82)];
//    _myCollapseClick.contentSize = CGSizeMake(320, 500);
    _myCollapseClick.collapseClickDelegate = self;
    _myCollapseClick.scrollEnabled = YES;
    
    [_myCollapseClick reloadCollapseClick];
    [self.view addSubview:_myCollapseClick];
    
     
    //confirmButton
    
//    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    confirmBtn.frame = CGRectMake(10, 320, 300, 30);
//    confirmBtn.backgroundColor = [UIColor orangeColor];
//    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
//    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
//    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [confirmBtn addTarget:self action:@selector(confirmBtn) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:confirmBtn];
}

#pragma mark - Collapse Click delegate
- (NSInteger)numberOfCellsForCollapseClick
{
    return 3
    ;
}

- (NSString *)titleForCollapseClickAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            return @"您要求司机到达的时间：";
            break;
        }
        case 1:
        {
            return @"您要预约多少位司机：";
            break;
        }
        case 2:
        {
            return @"您的位置：";
            break;
        }
    }
    return nil;
}

- (UIView *)viewForCollapseClickContentViewAtIndex:(int)index
{
    UIView *firstView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 280, 62)];
    firstView.backgroundColor = [UIColor whiteColor];
    UILabel * thrity = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 260,14)];
    UILabel * oneHour = [[UILabel alloc] initWithFrame:CGRectMake(10, 24, 260,14)];
    UILabel * oneHourAndThrity = [[UILabel alloc] initWithFrame:CGRectMake(10, 48, 260,14)];
    
    thrity.text = @"30分钟";
    oneHour.text = @"60分钟";
    oneHourAndThrity.text = @"90分钟";
    
    [firstView addSubview:thrity];
    [firstView addSubview:oneHour];
    [firstView addSubview:oneHourAndThrity];

    switch (index) {
        case 0:
        {
            return firstView;
            break;
        }
        case 1:
        {
            return  firstView;
            break;
        }
        case 2:
        {
            return firstView;
            break;
        }
    }
    return nil;
}

#pragma mark - option Method

- (UIColor *)colorForCollapseClickTitleViewAtIndex:(int)index
{
    return [UIColor whiteColor];
}

- (UIColor *)colorForTitleLabelAtIndex:(int)index
{
    return [UIColor blackColor];
}

- (void)didClickCollapseClickCellAtIndex:(int)index isNowOpen:(BOOL)open
{
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadCustomBar];
    [self loadMainView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
