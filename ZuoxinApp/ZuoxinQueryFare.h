//
//  ZuoxinQueryFare.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "BasicViewModel.h"
#import "CustomFieldView.h"

@interface ZuoxinQueryFare : BasicViewModel<UITableViewDataSource,UITableViewDelegate>
{
    NSDictionary *_priceDic;
    NSDictionary *_cityDic;
    UIView *_priceDetailView;
    UILabel *_cityLabel;
}

@end
