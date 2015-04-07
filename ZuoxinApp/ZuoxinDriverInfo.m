//
//  ZuoxinDriverInfo.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-9-13.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "ZuoxinDriverInfo.h"
#import <QuartzCore/QuartzCore.h>
#import "zuoxin.h"
#import "OrderDetailCell.h"
#import "SIAlertView.h"
#import "ZuoxinMyInfo.h"
#import "ZuoxinDriverInfoDetail.h"
#import "OrderBasicInfo.h"


@interface ZuoxinDriverInfo ()

@end

@implementation ZuoxinDriverInfo

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _ordersArr = [[NSMutableArray alloc] initWithCapacity:0];
        _servingOrders = [[NSMutableArray alloc] initWithCapacity:0];
        _endServingOrders = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

//__NSCFData getBytes:range:]: range {0, 4} exceeds data length 0'
- (void)viewDidLoad
{
   
    [super viewDidLoad];
	[self loadCustomBar];
    [self registerNetworkNotification];
    
}

#pragma mark - observe the network condition

-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    if([reach isReachable])
    {
        for (int i = 1; i <= [[self.view subviews] count]-1; i++) {
            [[[self.view subviews] objectAtIndex:i] removeFromSuperview];
        }
        // if logined
        if ([MyUserDefault objectForKey:@"SessionID"]) {
            [self loadbtnView];
            [self loadOrderView];
            [self performSelectorInBackground:@selector(loadData) withObject:nil];
        }
        else
        {
            [self loadUnloginView];
        }
    }
    else
    {
        for (int i = 1; i <= [[self.view subviews] count]-1; i++) {
            [[[self.view subviews] objectAtIndex:i] removeFromSuperview];
        }
        [self loadUnconnectedView];
        [self.view addSubview:_unconnectedView];
    }
}

#pragma mark - loadData

- (void)loadData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    @try {
        [self connectThriftServer];
        //serving Orders
        [_servingOrders addObjectsFromArray:[self.server getcustomerorders:[userDefaults objectForKey:@"SessionID"] pageindex:0 state:1]];
        _ordersArr = _servingOrders;
        
        //endServing orders
        [_endServingOrders addObjectsFromArray:[self.server getcustomerorders:[userDefaults objectForKey:@"SessionID"] pageindex:1 state:0]];
        [self performSelectorOnMainThread:@selector(reloadOrderView) withObject:nil waitUntilDone:YES];
       
        
    }
    @catch (RuntimeError *runtimeError) {
        NSLog(@"%@",runtimeError);
    }
    @catch (TException *texception) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"出现异常"];
        [self customAlertViewProperty:alertView andBlock:^{
            [alertView dismissAnimated:YES];
        }];
        NSLog(@"%@",texception);
    }
    @finally {
        
       
        
    }
}

#pragma mark - loadViews

- (void)loadCustomBar
{
    self.navTitleLabel.text = @"我的代驾";
    self.rightBtn.frame = CGRectMake(310-111/2-10, 0, 111/2+20, 47);
    
    UIImage *myInfoImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"myinfo@2x" ofType:@"png"]];
    [self.rightBtn setImage:myInfoImg forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(myInfoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self setTabBarHidden:YES];
}

- (void)loadUnloginView
{
    UIView *unLoginView = [[UIView alloc] initWithFrame:CGRectMake(0, 47, 320, self.view.frame.size.height-47)];
    unLoginView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:unLoginView];
    
    //alertView
    UIImageView *alertView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alert@2x.png"]];
    alertView.frame = CGRectMake(78.25, 0, 163.5, 163.5);
    [unLoginView addSubview:alertView];
    
    //label
    UILabel *label = [[UILabel alloc] init];
    label.font = MediumFont;
    label.textColor = [UIColor grayColor];
    CGSize size = CGSizeMake(280, 1000);
    label.text = @"您尚未登陆过李司机代驾，当您登陆李司机代驾，这里会显示您的订单!";
    CGSize textSize = [label.text sizeWithFont:label.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    label.numberOfLines = 0;
    label.frame = CGRectMake(20, 163.5, textSize.width, textSize.height);
    [unLoginView addSubview:label];
    

}

- (void)loadbtnView
{
//    self.view.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1];
    
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 47, 320, 28)];
    btnView.backgroundColor = [UIColor whiteColor];
    btnView.layer.shadowColor = [UIColor grayColor].CGColor;
    btnView.layer.shadowOffset = CGSizeMake(0, 0.3);
    btnView.layer.shadowOpacity = 0.8;
    btnView.layer.shadowRadius = 0.5;
    [self.view addSubview:btnView];
    
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.frame = CGRectMake(0, 0, 160, 28);
    _leftBtn.tag = 1992;
    _leftBtn.backgroundColor = [UIColor clearColor];
    _leftBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [_leftBtn setTitle:@"代服务订单" forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor colorWithRed:90.0/255.0 green:156.0/255.0 blue:0 alpha:1] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(tapBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(160, 0, 160, 28);
    _rightBtn.tag = 1993;
    _rightBtn.backgroundColor = [UIColor clearColor];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [_rightBtn setTitle:@"已结束订单" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(tapBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [btnView addSubview:_leftBtn];
    [btnView addSubview:_rightBtn];
    
    UIImage *tapImg = [[UIImage imageNamed:@"tapimg@2x.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    _tapView = [[UIImageView alloc] initWithImage:tapImg];
    _tapView.frame = CGRectMake(0, 24, 160, 4);
    [btnView addSubview:_tapView];
    
}

- (void)loadOrderView
{
    _orderView = [[UITableView alloc] initWithFrame:CGRectMake(0, 47+28+1, 320, self.view.frame.size.height-47-28) style:UITableViewStylePlain];
    _orderView.tag = 999;
    _orderView.delegate = self;
    _orderView.dataSource = self;
    _orderView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _orderView.showsVerticalScrollIndicator = NO;
    _orderView.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1];
    [self.view addSubview:_orderView];
}

#pragma mark - orderViewMethod

- (void)reloadOrderView
{
    [_orderView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_ordersArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIndentifier =[NSString stringWithFormat:@"cell%d",indexPath.section];
    OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if (cell == nil) {
        cell = [[OrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
    }
    
    //orderNum
    cell.orderNumLabel.text = [NSString stringWithFormat:@"订单号:%@",[[_ordersArr objectAtIndex:indexPath.section] valueForKey:@"orderid"]];
    
    //orderSate
    switch ([[[_ordersArr objectAtIndex:indexPath.section] valueForKey:@"orderstate"] intValue]) {
        case 0:
        {
            cell.orderStatusLabel.text = @"新单";
            break;
        }
        case 1:
        {
            cell.orderStatusLabel.text = @"服务开始";
            break;
        }
        case 2:
        {
            cell.orderStatusLabel.text = @"服务结束";
            break;
        }
        case 3:
        {
            cell.orderStatusLabel.text = @"已上报";
            break;
        }
            
      
    }
    //orderWay
    switch ([[[_ordersArr objectAtIndex:indexPath.section] valueForKey:@"ordertype"] intValue]) {
        case 0:
        {
            cell.orderWayLabel.text = @"400下单";
            break;
        }
        case 1:
        {
            cell.orderWayLabel.text  = @"手机下单";
            break;
        }
        case 2:
        {
            cell.orderWayLabel.text  = @"补单";
            break;
        }
        case 3:
        {
            cell.orderWayLabel.text  = @"客户直接呼叫";
            break;
        }
    }
    
    //driverPhone
    
    cell.driverPhoneNumLabel.text = [[NSString alloc] initWithFormat:@"司机电话：%@",[[[_ordersArr objectAtIndex:0] valueForKey:@"driver"] valueForKey:@"mobile"]];
    
    
    cell.driverNameLabel.text = [[NSString alloc] initWithFormat:@"%@",[[[_ordersArr objectAtIndex:0] valueForKey:@"driver"] valueForKey:@"name"]];
    
    switch ([[[[_ordersArr objectAtIndex:0] valueForKey:@"driver"] valueForKey:@"sex"] intValue]) {
        case 0:
        {
            cell.driverSexLabel.text = @"性别：男";
            break;
        }
        case 1:
        {
            cell.driverSexLabel.text = @"性别：女";
            break;
        }
    }
    
    //dateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    NSDate *creatTime = [[NSDate alloc] initWithTimeIntervalSince1970:[[[_ordersArr objectAtIndex:indexPath.section] valueForKey:@"createtime"] intValue]];
    NSString *creatTimeStr = [dateFormatter stringFromDate:creatTime];
    cell.orderCreatTimeLabel.text = [[NSString alloc] initWithFormat:@"下单时间：%@",creatTimeStr];
    
    NSDate *reservationTime = [[NSDate alloc] initWithTimeIntervalSince1970:[[[_ordersArr objectAtIndex:indexPath.section] valueForKey:@"pretime"] intValue]];
    NSString *reservationTimeStr = [dateFormatter stringFromDate:reservationTime];
    cell.reservationTimLabel.text = [[NSString alloc] initWithFormat:@"预约时间：%@",reservationTimeStr];
    cell.driverNumLabel.text = [[NSString alloc] initWithFormat:@"预约司机：%@位",[[_ordersArr objectAtIndex:indexPath.section] valueForKey:@"drivercount"]];
    cell.userLocationLabel.text = [[NSString alloc] initWithFormat:@"出发地点：%@",[[_ordersArr objectAtIndex:indexPath.section] valueForKey:@"preaddress"]];
    cell.callDriverBtn.tag = indexPath.section;
    [cell.callDriverBtn addTarget:self action:@selector(callDriverBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZuoxinDriverInfoDetail *driverInfoDetail = [[ZuoxinDriverInfoDetail alloc] init];
    driverInfoDetail.orderDic  = [_ordersArr objectAtIndex:indexPath.section];
    [self.navigationController pushViewController:driverInfoDetail animated:NO];
    
}

#pragma mark - btnClik

- (void)myInfoBtnClick
{
    ZuoxinMyInfo *myInfo = [[ZuoxinMyInfo alloc] init];
    [self.navigationController pushViewController:myInfo animated:YES];
}

- (void)tapBtnClick:(id)sender
{
    UIButton *tapBtn = (UIButton *)sender;
    switch (tapBtn.tag) {
        case 1992:
        {
            [UIView animateWithDuration:0.3 animations:^{
                [_tapView setFrame:CGRectMake(0, 24, 160, 4)];
                [tapBtn setTitleColor:[UIColor colorWithRed:90.0/255.0 green:156.0/255.0 blue:0 alpha:1] forState:UIControlStateNormal];
                [_rightBtn setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
            }];
            
            _ordersArr = _servingOrders;
            [_orderView reloadData];
            break;
        }
        case 1993:
        {
            [UIView animateWithDuration:0.3 animations:^{
                [_tapView setFrame:CGRectMake(160, 24, 160, 4)];
                [tapBtn setTitleColor:[UIColor colorWithRed:90.0/255.0 green:156.0/255.0 blue:0 alpha:1] forState:UIControlStateNormal];
                [_leftBtn setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
            }];
            
            _ordersArr = _endServingOrders;
            [_orderView reloadData];
            break;
        }
    }
}


- (void)callBtnClick:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4006278866"]];
}

- (void)reconnectbtnClick:(id)sender
{

    
}

- (void)callDriverBtn:(id)sender
{
    UIButton *callDriverBtn = (UIButton *)sender;
    
    switch ([[[[_ordersArr objectAtIndex:callDriverBtn.tag] valueForKey:@"driver"] valueForKey:@"state"] intValue]) {
        case 1:
        {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"拨打该电话？"];
            alertView.messageColor = [UIColor grayColor];
            alertView.messageFont = [UIFont systemFontOfSize:14.0f];
            alertView.buttonFont = [UIFont systemFontOfSize:12.0f];
            [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
                
                NSString *tel = [[NSString alloc] initWithFormat:@"tel://%@",[[[_ordersArr objectAtIndex:callDriverBtn.tag] valueForKey:@"driver"] valueForKey:@"mobile"]];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
            }];
            [alertView addButtonWithTitle:@"取消" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
                [alertView dismissAnimated:YES];
            }];
            [alertView show];
            break;
        }
        case 0:
        case 2:
        case 3:
        {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"该司机暂时没空..."];
            [self customAlertViewProperty:alertView andBlock:^{
                [alertView dismissAnimated:YES];
            }];
            [alertView show];
            break;
        }
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
