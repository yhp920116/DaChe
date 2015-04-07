//
//  ZuoxinAboutUs.m
//  ZuoxinApp
//
//  Created by tongxia on 9/18/13.
//  Copyright (c) 2013 Zuoxin.com. All rights reserved.
//

#import "ZuoxinAboutUs.h"

@interface ZuoxinAboutUs ()

@end

@implementation ZuoxinAboutUs

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
    self.view.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1];
    self.navTitleLabel.text = @"关于我们";

}

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self loadCustomBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
