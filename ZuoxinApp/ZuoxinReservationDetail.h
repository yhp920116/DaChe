//
//  ZuoxinReservationDetail.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-22.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "BasicViewModel.h"
#import "CollapseClick.h"

@interface ZuoxinReservationDetail : BasicViewModel<UITextFieldDelegate,CollapseClickDelegate>
{
    UITextField *_phoneNumField;
    CollapseClick *_myCollapseClick;
}
@end
