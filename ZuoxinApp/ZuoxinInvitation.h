//
//  ZuoxinInvitation.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "BasicViewModel.h"
#import <MessageUI/MessageUI.h>

@interface ZuoxinInvitation : BasicViewModel<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,MFMessageComposeViewControllerDelegate>
{
    UITextView *_textView;
    UILabel *_inviteLabel;
    UILabel *_tipsLabel;
}
@end
