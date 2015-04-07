//
//  ZuoxinFeedBack.m
//  ZuoxinApp
//
//  Created by tongxia on 9/4/13.
//  Copyright (c) 2013 Zuoxin.com. All rights reserved.
//

#import "ZuoxinFeedBack.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomTextField.h"
#import "SIAlertView.h"
#import "zuoxin.h"
#import "MyLabel.h"

@interface ZuoxinFeedBack ()

@end

@implementation ZuoxinFeedBack
@synthesize _opinionCategory;
@synthesize _myScrollView;
@synthesize selectPicker = _selectPicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadCustomBar
{
    self.view.backgroundColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.82 alpha:1];
    self.navTitleLabel.text = @"意见反馈";
    
}

-(void)loadMainView
{
    _myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 47, 320, self.view.frame.size.height-47)];
    _myScrollView.tag = 100;
    _myScrollView.directionalLockEnabled = YES;
    _myScrollView.pagingEnabled = NO;
    _myScrollView.backgroundColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.82 alpha:1];
    _myScrollView.showsVerticalScrollIndicator = YES;
    _myScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    _myScrollView.showsHorizontalScrollIndicator = NO;
    _myScrollView.delegate = self;
    
    [_myScrollView setContentSize:CGSizeMake(320, self.view.frame.size.height-47+0.5)];
    [self.view addSubview:_myScrollView];
    
    UIView *inputFeedBackView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 300, 370)];
    inputFeedBackView.backgroundColor = [UIColor whiteColor];
    inputFeedBackView.layer.cornerRadius = 5.0;
    //inputFeedBackView.layer.borderWidth = 1.0;
    [_myScrollView addSubview:inputFeedBackView];
    
    UILabel *label00 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    label00.text = @" 请您填写建议及反馈";
    label00.font = MediumFont;
    label00.textColor = BlackFontColor;
    label00.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:0.5];
    label00.layer.cornerRadius = 5.0;
    [inputFeedBackView addSubview:label00];
    
    MyLabel *label01 = [[MyLabel alloc] initWithFrame:CGRectMake(10, 34, 200, 26)];
    label01.text = @"意见类别  *";
    label01.backgroundColor = [UIColor clearColor];
    [inputFeedBackView addSubview:label01];
    
    _opinionCategory = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 280, 28)];
    _opinionCategory.text = @"  投诉";
    _opinionCategory.font = [UIFont systemFontOfSize:12.0f];
    _opinionCategory.textColor = [UIColor grayColor];
    _opinionCategory.layer.borderWidth = 0.3f;
    _opinionCategory.layer.cornerRadius = 3.0f;
    _opinionCategory.layer.borderColor = [UIColor grayColor].CGColor;
    _opinionCategory.userInteractionEnabled = YES;
    [inputFeedBackView addSubview:_opinionCategory];
    
    UIButton *popBtnOne = [UIButton buttonWithType:UIButtonTypeCustom];
    popBtnOne.frame = CGRectMake(252, 0, 28, 28);
    popBtnOne.backgroundColor = [UIColor clearColor];
    popBtnOne.tag = 0;
    [popBtnOne setImage:[UIImage imageNamed:@"popimg.png"] forState:UIControlStateNormal];
    [popBtnOne addTarget:self action:@selector(popBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_opinionCategory addSubview:popBtnOne];
    
    
    MyLabel *label11 = [[MyLabel alloc] initWithFrame:CGRectMake(10, 88, 200, 26)];
    label11.text = @"意见内容  *";
    label11.font = [UIFont systemFontOfSize:12.0f];
    [inputFeedBackView addSubview:label11];
    
    _opinionComment = [[UITextView alloc]initWithFrame:CGRectMake(10, 114, 280, 90)];
    _opinionComment.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    _opinionComment.font = [UIFont systemFontOfSize:12.0f];
    _opinionComment.returnKeyType = UIReturnKeyDone;
    _opinionComment.delegate = self;
    _opinionComment.backgroundColor = [UIColor whiteColor];
    _opinionComment.editable = YES;
    _opinionComment.scrollEnabled = YES;
    _opinionComment.layer.cornerRadius = 5.0;
    _opinionComment.layer.borderWidth = 0.3f;
    _opinionComment.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [inputFeedBackView addSubview:_opinionComment];
    
    
    MyLabel *label1 = [[MyLabel alloc] initWithFrame:CGRectMake(10, 204, 200, 26)];
    label1.text = @"您的邮箱 *";
    label1.backgroundColor = [UIColor clearColor];
    [inputFeedBackView addSubview:label1];
    
    _emailNumField = [[CustomTextField alloc] initWithFrame:CGRectMake(10, 230, 280, 28)];
    _emailNumField.font = [UIFont systemFontOfSize:12.0f];
    //_emailNumField.borderStyle = UITextBorderStyleNone;
    _emailNumField.keyboardType = UIKeyboardTypeEmailAddress;
    _emailNumField.delegate = self;
    _emailNumField.layer.cornerRadius = 3.0;
    // _emailNumField.returnKeyType = UIReturnKeyNext;
    //_emailNumField.borderStyle = UITextBorderStyleRoundedRect;
    //_emailNumField.returnKeyType = UIReturnKeyDone;
    _emailNumField.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    _emailNumField.layer.borderWidth = 0.3f;
    _emailNumField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [inputFeedBackView addSubview:_emailNumField];
    
    
    MyLabel *label2 = [[MyLabel alloc] initWithFrame:CGRectMake(10, 258, 200, 26)];
    label2.text = @"您的手机 *";
    label2.backgroundColor = [UIColor clearColor];
    [inputFeedBackView addSubview:label2];
    
    _phoneNumField = [[CustomTextField alloc] initWithFrame:CGRectMake(10, 285, 280, 28)];
    _phoneNumField.font = [UIFont systemFontOfSize:12.0f];
    //_phoneNumField.borderStyle = UITextBorderStyleNone;
    _phoneNumField.keyboardType = UIKeyboardTypeNumberPad;
    //_phoneNumField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    // _phoneNumField.borderStyle = UITextBorderStyleNone;
    //_phoneNumField.keyboardType = UIKeyboardTypeNumberPad;
    //_phoneNumField.returnKeyType = UIReturnKeyDefault;
    _phoneNumField.delegate = self;
    _phoneNumField.layer.cornerRadius = 3.0;
    //_phoneNumField.borderStyle = UITextBorderStyleRoundedRect;
    _phoneNumField.layer.borderWidth = 0.3f;
    _phoneNumField.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    _phoneNumField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [inputFeedBackView addSubview:_phoneNumField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(10, _phoneNumField.frame.origin.y+_phoneNumField.frame.size.height+10, 280, 30);
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn setBackgroundImage:GeenBtnBG forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtn) forControlEvents:UIControlEventTouchUpInside];
    [inputFeedBackView addSubview:confirmBtn];
    
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gesture.numberOfTapsRequired = 1;//手势敲击的次数
    [self.view addGestureRecognizer:gesture];
    
    
}


#pragma mark - btnClick


 - (void)popBtnClick:(id)sender
 {
 UIButton *btn = (UIButton *)sender;
 if (btn.tag == 0)
    {
     SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"请选择" andMessage:nil];
     alertView.titleFont = [UIFont systemFontOfSize:14.0f];
     alertView.titleColor = [UIColor grayColor];
 
     [alertView addButtonWithTitle:@"投诉" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
         _opinionCategory.text = @"  投诉";
     }];
     [alertView addButtonWithTitle:@"建议" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
         _opinionCategory.text = @"  建议";
 }];
     [alertView addButtonWithTitle:@"其他" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView)
     {
         _opinionCategory.text = @"  其他";
     }];
     [alertView show];
    }
 }
 

#pragma mark - keyboard responder

- (void)keyboardShow:(NSNotification *)aNotification
{
    NSDictionary *info = [aNotification userInfo];
    //get the height of keyboard
    NSValue *value = [info objectForKey:@"UIKeyboardBoundsUserInfoKey"];
    CGSize keyboardSize = [value CGRectValue].size;
    
    if ([_phoneNumField isFirstResponder]) {
       

        UIScrollView *scrollView = (UIScrollView*)[self.view viewWithTag:100];
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.contentOffset = CGPointMake(0, keyboardSize.height-30);
        }];
    }
    
    if ([_opinionComment isFirstResponder])
    {
        //[_doneInKeyboardBtn removeFromSuperview];
        UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:100];
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.contentOffset = CGPointMake(0, keyboardSize.height-198);
        }];
    }
    
    if ([_emailNumField isFirstResponder]) {
        
        //[_doneInKeyboardBtn removeFromSuperview];
        UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:100];
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.contentOffset = CGPointMake(0, keyboardSize.height-140);
        }];
        
    }
    
}

- (void)keyboardHidden:(NSNotification *)aNotification
{
    UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:100];
    //    [UIView animateWithDuration:0.3 animations:^{
    //        scrollView.contentOffset = CGPointMake(0, 0);
    //    }];
    [UIView animateWithDuration:0.3 animations:^{
        scrollView.contentOffset = CGPointMake(0, 0);
    }];
    
    if ([_phoneNumField isFirstResponder]) {
        
    }
    else
    {
        UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:100];
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.contentOffset = CGPointMake(0, 0);
        }];
    }
}

//隐藏键盘方法
-(void)hideKeyboard{
    [_opinionComment resignFirstResponder];
    [_emailNumField resignFirstResponder];
    [_phoneNumField resignFirstResponder];
    [_opinionCategory endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_phoneNumField resignFirstResponder];
    [_emailNumField resignFirstResponder];
    return YES;
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

- (void)keyboardResign
{
    [_phoneNumField resignFirstResponder];
    
}


#pragma mark - keyboard responder
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self loadCustomBar];
    [self loadMainView];
    
    //指定编辑时键盘的return键类型
}

-(void)backBtnClick
{
    [self setTabBarHidden:NO];
    [self.navigationController popViewControllerAnimated:YES ];
}



-(void)viewDidAppear:(BOOL)animated
{
    [self setTabBarHidden:YES];
    [super viewDidAppear:YES];
}


- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSPredicate *regexTestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    if ([regexTestMobile evaluateWithObject:mobileNum] == YES) {
    
        return YES;
    }
    else
    {
        
        return NO;
    }
}


- (void)confirmBtn
{
    //[self sendsuggestion: _opinionCategory  message: _opinionComment mobile: _phoneNumField email: _emailNumField];
     
    if ([self isMobileNumber:_phoneNumField.text] ) {
        [_phoneNumField resignFirstResponder];
        NSInteger i = 0,j;
        @try {
            if ([_opinionCategory.text isEqual:@"  投诉"]) {
                j = i;
            }
            else
                if ([_opinionCategory.text isEqual:@"  建议"]) {
                    j = i + 1;
                }
                else
                {
                    j = i + 2;
                }
            
            [self connectThriftServer];
            [self.server sendsuggestion:j message:_opinionComment.text mobile:[_phoneNumField.text longLongValue] email:_emailNumField.text];
            NSLog(@"%d",[_opinionCategory.text intValue]);
            NSLog(@"%@",_opinionCategory.text);
            SIAlertView *alterView = [[SIAlertView alloc]initWithTitle:nil andMessage:@"意见反馈提交成功"];
            [self customAlertViewProperty:alterView andBlock:^{
                [alterView dismissAnimated:YES];
            }];
            
        }
        @catch (RuntimeError *runtimeError) {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:[runtimeError errormessage]];
            [self customAlertViewProperty:alertView andBlock:^{
                [alertView dismissAnimated:YES];
            }];
            NSLog(@"%d,%@",[runtimeError errornumber],[runtimeError errormessage]);
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
        
    else
    {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"请输入正确的手机格式!"];
        [self customAlertViewProperty:alertView andBlock:^{
            [alertView dismissAnimated:YES];
        }];

    }
        
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
