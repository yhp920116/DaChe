//
//  ZuoxinInvitation.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "ZuoxinInvitation.h"
#import "SIAlertView.h"
#import <QuartzCore/QuartzCore.h>
#import "CUShareCenter.h"
#import "CUSinaShareClient.h"
#import "CUTencentShareClient.h"


@interface ZuoxinInvitation ()

@end

@implementation ZuoxinInvitation

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
    [super viewWillAppear:animated];
    
    [[[CUShareCenter sharedInstanceWithType:SINACLIENT] shareClient] addDelegate:self];
    [[[CUShareCenter sharedInstanceWithType:RENRENCLIENT] shareClient] addDelegate:self];
    [[[CUShareCenter sharedInstanceWithType:TTWEIBOCLIENT] shareClient] addDelegate:self];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[[CUShareCenter sharedInstanceWithType:SINACLIENT] shareClient] removeDelegate:self];
    [[[CUShareCenter sharedInstanceWithType:RENRENCLIENT] shareClient] removeDelegate:self];
    [[[CUShareCenter sharedInstanceWithType:TTWEIBOCLIENT] shareClient] removeDelegate:self];
}

- (void)loadCustomBar
{
    self.navTitleLabel.text = @"邀请好友";
    self.backBtn.hidden = YES;
    self.customBtn.hidden = YES;
    self.rightBtn.hidden = YES;
}

- (void)loadInviteView
{
    self.view.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 47, self.view.frame.size.width, self.view.frame.size.height-47*2)];
    scrollView.tag = 998;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-47*2+0.5);
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    float deltaX = 10.0;
    float deltaY = 10.0;
    for (NSInteger i = 0; i < 4; i++) {
    
        UIButton *messageView = [[UIButton alloc] initWithFrame:CGRectMake(deltaX, deltaY, 146, 60)];
        messageView.tag = i;
        messageView.backgroundColor = [UIColor whiteColor];
        [messageView addTarget:self action:@selector(inviteBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self setLayerCornerRadiusAndshadowInView:messageView];
        [scrollView addSubview:messageView];
        
        UIImageView *thumbnail = [[UIImageView alloc] init];
        [messageView addSubview:thumbnail];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = MediumFont;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = BlackFontColor;
        [messageView addSubview:titleLabel];
        
        CGSize size = CGSizeMake(146, 1000);
        CGSize titlelSize;
        
        switch (i) {
            case 0:
            {
                UIImage *messageImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"invite-message@2x" ofType:@"png"]];
                thumbnail.image = messageImg;
                
                titleLabel.text = @"短信邀请";
                titlelSize = [titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
                
                
                break;
            }
            case 1:
            {
                UIImage *xinlangImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"invite-xinlang@2x" ofType:@"png"]];
                thumbnail.image = xinlangImg;
                
                titleLabel.text = @"新浪微博邀请";
                titlelSize = [titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
                break;
            }
            case 2:
            {
                UIImage *tecentImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"invite-tencent@2x" ofType:@"png"]];
                thumbnail.image = tecentImg;
                
                titleLabel.text = @"腾讯微博邀请";
                titlelSize = [titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
                break;
            }
            case 3:
            {
                UIImage *weixinImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"invite-weixin@2x" ofType:@"png"]];
                thumbnail.image = weixinImg;
                
                titleLabel.text = @"微信邀请";
                titlelSize = [titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
                break;
            }
        }
        
        thumbnail.frame = CGRectMake((146-35-titlelSize.width)/2, (messageView.frame.size.height-25)/2, 25, 25);
        
        titleLabel.frame = CGRectMake(thumbnail.frame.origin.x + thumbnail.frame.size.width +10, (messageView.frame.size.height-12)/2, titlelSize.width, 12);
    
        deltaX = deltaX+146+8;
        
        if (deltaX > 317) {
            deltaX = 10;
            deltaY = deltaY + 60+ 8;
        }
        
    }
    
    UIView *inviteView = [[UIView alloc] initWithFrame:CGRectMake(10, 148, 300, 40)];
    inviteView.backgroundColor = [UIColor whiteColor];
    [self setLayerCornerRadiusAndshadowInView:inviteView];
    [scrollView addSubview:inviteView];
    
    UIImageView *inviteImgview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7.5, 25, 25)];
    UIImage *inviteImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"invite-default@2x" ofType:@"png"]];
    inviteImgview.image = inviteImg;
    [inviteView addSubview:inviteImgview];

    
    _inviteLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 14, 140, 12)];
    _inviteLabel.font = MediumFont;
    _inviteLabel.textColor = BlackFontColor;
    _inviteLabel.backgroundColor = [UIColor clearColor];
    [inviteView addSubview:_inviteLabel];
    
    _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 14, 60, 12)];
    _tipsLabel.font = MediumFont;
    _tipsLabel.textColor = [UIColor colorWithRed:90.0/255.0 green:156.0/255.0 blue:0 alpha:1];
    _tipsLabel.backgroundColor = [UIColor clearColor];
    [inviteView addSubview:_tipsLabel];
    
    [self reloadInviteData];
    
    //texifield
    
    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(10, 198, 300, self.view.frame.size.height-235-10-80-47)];
    textView.backgroundColor = [UIColor whiteColor];
    [self setLayerCornerRadiusAndshadowInView:textView];
    [scrollView addSubview:textView];
    
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 300, self.view.frame.size.height-235-10-80-47)];
    [self setLayerCornerRadiusAndshadowInView:_textView];
    _textView.delegate = self;
    _textView.textColor = GrayFontColor;
    _textView.font = SMediumFont;
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.text = @"哥们儿, 送你小易代驾的10元邀请码:XXXXXX, 下载客户端>>http://XXXXXXXXXXXXXX, 输入绑定。小易代驾还是挺实用的，司机一会儿就到, 还当场给发票。关键是便宜! 22点前起步价才¥39, 告诉你的酒友哦! ";
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.scrollEnabled = YES;
    [textView addSubview:_textView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    
    //sendBtn
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(10, textView.frame.origin.y+textView.frame.size.height+10, 300, 30);
    sendBtn.titleLabel.font = BigFont;
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:GeenBtnBG forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendBtn) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:sendBtn];
    
}

#pragma mark - reloadInviteData

- (void)reloadInviteData
{
    NSString *inviteNum = [[MyUserDefault objectForKey:@"InviteNum"] objectAtIndex:0];
  
    if (inviteNum) {
        _inviteLabel.text = [[NSString alloc] initWithFormat:@"邀请码: %@",inviteNum];
        _tipsLabel.text = [[NSString alloc] initWithFormat:@"可用: %@",[[MyUserDefault objectForKey:@"InviteNum"] objectAtIndex:1]];
    }
    else
    {
        int randomNum = (arc4random() % 10000001)+90000000;
        NSString *randomNumStr = [NSString stringWithFormat:@"%d",randomNum];
        NSNumber *count = [NSNumber numberWithInt:20];
        
        _inviteLabel.text = [[NSString alloc] initWithFormat:@"邀请码: %@",randomNumStr];
        _tipsLabel.text = [[NSString alloc] initWithFormat:@"可用: %@",count];
        
        NSMutableArray *inviteArr  = [[NSMutableArray alloc] initWithObjects:randomNumStr,count,nil];
        [MyUserDefault setObject:inviteArr forKey:@"InviteNum"];
    }
}

#pragma mark - keyboard responder

- (void)keyboardShow:(NSNotification *)aNotification
{
    NSDictionary *info = [aNotification userInfo];
    //get the height of keyboard
    NSValue *value = [info objectForKey:@"UIKeyboardBoundsUserInfoKey"];
    CGSize keyboardSize = [value CGRectValue].size;
    
    UIScrollView *scrollView = (UIScrollView*)[self.view viewWithTag:998];
    [UIView animateWithDuration:0.3 animations:^{
        scrollView.contentOffset = CGPointMake(0, keyboardSize.height-47-20);
    }];
    
}

- (void)keyboardHidden:(NSNotification *)aNotification
{
    UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:998];
//    [UIView animateWithDuration:0.3 animations:^{
//        scrollView.contentOffset = CGPointMake(0, 0);
//    }];
    [UIView animateWithDuration:0.3 animations:^{
        scrollView.contentOffset = CGPointMake(0, 0);
    } completion:^(BOOL finished) {
       [UIView animateWithDuration:0.25 animations:^{
           scrollView.contentOffset = CGPointMake(0, 8);
       } completion:^(BOOL finished) {
           [UIView animateWithDuration:0.2 animations:^{
               scrollView.contentOffset = CGPointMake(0, 0);
           } completion:^(BOOL finished) {
               [UIView animateWithDuration:0.12 animations:^{
                   scrollView.contentOffset = CGPointMake(0, 3);
               } completion:^(BOOL finished) {
                   [UIView animateWithDuration:0.08 animations:^{
                       scrollView.contentOffset = CGPointMake(0, 0);
                   } completion:^(BOOL finished) {
                    
                   }];
               }];
           }];
       }];
    }];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

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

#pragma mark - messageMethod

- (void)showSMSPicker
{
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass != nil) {
        if ([messageClass canSendText]) {
            if ([_textView.text isEqualToString:nil]||[_textView.text isEqualToString:@""]||[_textView.text isEqualToString:@" "]) {
                [self alertViewPopWithTitle:nil andMessage:@"请在下面输入框输入发送信息" andOkTitle:@"确定"];
            }
            else
            {
                [self displaySMSComposerSheet];
            }
        }       
        else {
            [self alertViewPopWithTitle:nil andMessage:@"设备没有短信功能" andOkTitle:@"确定"];
            
        }
    }
    else {
        [self alertViewPopWithTitle:nil andMessage:@"iOS版本过低,iOS4.0以上才支持程序内发送短信" andOkTitle:nil];
        
    }
}

- (void)displaySMSComposerSheet {
    
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = self;
    
//    NSString *msg = [NSString stringWithFormat:@"李司机代驾实在是太好用了，大家赶紧来试试看！"];
    picker.body = [[NSString alloc] initWithString:_textView.text];
    
    picker.recipients = [NSArray arrayWithObject:@"10086"];

    [self presentViewController:picker animated:YES completion:^{
    }];
    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    switch (result)
    {
        case MessageComposeResultCancelled:
            //LOG_EXPR(@"Result: SMS sending canceled");
            break;
        case MessageComposeResultSent:
        {
            [self alertViewPopWithTitle:nil andMessage:@"短信发送成功" andOkTitle:@"确定"];
            
            //每发送成功一次，次数少一次
    
            NSNumber *count = [[NSNumber alloc] initWithInt:[[[MyUserDefault objectForKey:@"InviteNum"] objectAtIndex:1] intValue]-1];
             [[MyUserDefault objectForKey:@"InviteNum"] replaceObjectAtIndex:1 withObject:count];
        }
            break;
        case MessageComposeResultFailed:
        {
            [self alertViewPopWithTitle:nil andMessage:@"短信发送失败" andOkTitle:@"确定"];
            
        }
            break;
        default:
            //LOG_EXPR(@"Result: SMS not sent");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}

#pragma mark - setAlertview

- (void)alertViewPopWithTitle:(NSString *)title andMessage:(NSString *)message andOkTitle:(NSString *)ok
{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:title andMessage:message];
    alertView.messageFont = [UIFont systemFontOfSize:14.0f];
    alertView.messageColor = [UIColor grayColor];
    alertView.transitionStyle = SIAlertViewTransitionStyleDropDown;

    [alertView addButtonWithTitle:ok type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
        [alertView dismissAnimated:YES];
    }];
    alertView.buttonFont = [UIFont systemFontOfSize:14.0f];
    
    [alertView show];
}


#pragma mark - btnClick

- (void)inviteBtn:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 0:
        {
            [self showSMSPicker];
            break;
        }
        case 1:
        {
            if (![[CUShareCenter sharedInstanceWithType:SINACLIENT] isBind]) {
                return [[CUShareCenter sharedInstanceWithType:SINACLIENT] Bind:self];
            }
            [[CUShareCenter sharedInstanceWithType:SINACLIENT] sendWithText:_textView.text];
            break;
        }
        case 2:
        {
            if (![[CUShareCenter sharedInstanceWithType:TTWEIBOCLIENT] isBind]) {
                return [[CUShareCenter sharedInstanceWithType:TTWEIBOCLIENT] Bind:self];
            }
            [[CUShareCenter sharedInstanceWithType:TTWEIBOCLIENT] sendWithText:_textView.text];
            break;
        }
        case 3:
        {
            break;
        }
    }
}

- (void)sendBtn
{
  [self showSMSPicker];  
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadCustomBar];
    [self loadInviteView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
