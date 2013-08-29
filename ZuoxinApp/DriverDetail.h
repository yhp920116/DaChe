//
//  DriverDetail.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-22.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "BasicViewModel.h"
#import "EGORefreshTableHeaderView.h"
#import "DriverBasicInfo.h"

@interface DriverDetail : BasicViewModel<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}

@property(nonatomic,strong) DriverBasicInfo *driverBasicInfo;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@end
