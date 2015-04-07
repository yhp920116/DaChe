//
//  ZuoxinFeedBack.h
//  ZuoxinApp
//
//  Created by tongxia on 9/4/13.
//  Copyright (c) 2013 Zuoxin.com. All rights reserved.
//

#import "BasicViewModel.h"

@interface ZuoxinFeedBack : BasicViewModel<UITextViewDelegate,UITextFieldDelegate>
{
    UITextField *_emailNumField;
    UITextField *_phoneNumField;
    UITextView *_opinionComment;
    UILabel *_opinionCategory;
    UIScrollView *_myScrollView;
    NSMutableArray *pickerArray;
}

@property(strong,nonatomic)UILabel *_opinionCategory;
@property(strong,nonatomic)UIScrollView *_myScrollView;
@property (strong, nonatomic)UIPickerView *selectPicker;

- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@end
