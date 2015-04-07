//
//  ZuoxinDriverInfo.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-9-13.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "BasicViewModel.h"

@interface ZuoxinDriverInfo : BasicViewModel<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_orderView;
    UIImageView *_tapView;
    UIButton *_leftBtn;
    UIButton *_rightBtn;
    
    NSMutableArray *_servingOrders;
    NSMutableArray *_endServingOrders;
    NSMutableArray *_ordersArr;
}
@end
