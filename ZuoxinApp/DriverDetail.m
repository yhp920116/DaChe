//
//  DriverDetail.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-22.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "DriverDetail.h"
#import "BackBtn.h"
#import "CustomBtn.h"
#import "DriverInfoCell.h"
#import "CustomerCommentCell.h"

@interface DriverDetail ()

@end

@implementation DriverDetail

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
    self.customBtn.hidden = YES;
    self.navTitleLabel.text = @"司机详情";
}

- (void)loadDriverInfo
{
    UITableView *driverInfoTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, 300, 140) style:UITableViewStylePlain];
    driverInfoTable.tag = 998;
    driverInfoTable.dataSource = self;
    driverInfoTable.delegate = self;
    driverInfoTable.scrollEnabled = NO;
    driverInfoTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:driverInfoTable];
    
}

- (void)loadCustomerComment
{
    UITableView *customerCommentTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 160, 300, 300) style:UITableViewStylePlain];
    customerCommentTable.tag = 999;
    customerCommentTable.dataSource = self;
    customerCommentTable.delegate = self;
    customerCommentTable.scrollEnabled = YES;
    customerCommentTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:customerCommentTable];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView isEqual:(UITableView *)[self.view viewWithTag:998]]) {
        return 140;
    }
    else if ([tableView isEqual:(UITableView *)[self.view viewWithTag:999]]){
        return 80;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:(UITableView *)[self.view viewWithTag:998]]) {
        return 1;
    }
    else if ([tableView isEqual:(UITableView*)[self.view viewWithTag:999]]){
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:(UITableView *)[self.view viewWithTag:998]]) {
        static NSString *CellIdentifier = @"Cell";
        DriverInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[DriverInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        UIImage *accessoryArrow = [UIImage imageNamed:@"search-cell-accessory@2x.png"];
        UIImage *thumbnail = [UIImage imageNamed:@"apple.jpg"];
        UIImage *separator = [UIImage imageNamed:@"contentSprarator.png"];
        
        cell.thumbnail.image = thumbnail;
        cell.driverNameLabel.text = @"路飞";
        cell.distanceLabel.text = [cell.distanceLabel.text stringByAppendingFormat:@"10公里"];
        cell.driveTimesLabel.text = [cell.driveTimesLabel.text stringByAppendingFormat:@"100次"];
        // set startProcess property
        
        
        cell.driverStatusLabel.text = @"冒险中";
        cell.driverStatusLabel.textColor = [UIColor redColor];
        
        cell.driveAgeLabel.text = [cell.driveAgeLabel.text stringByAppendingFormat:@"10年"];
        cell.nativePlaceLabel.text = [cell.nativePlaceLabel.text stringByAppendingFormat:@"新世界"];
        cell.arrowView.image = accessoryArrow;
        cell.separatorLine.image = separator;
        return cell;
    }
    else if ([tableView isEqual:(UITableView*)[self.view viewWithTag:999]])
    {
        static NSString *CellIndentifier = @"Cell";
        CustomerCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
        if (cell == nil) {
            cell = [[CustomerCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
        }
        cell.phoneNumLabel.text = @"122****2222";
        cell.commentDateLabel.text = @"2013-1-1";
        cell.commentDetailLabel.text = @"这家伙服务态度真是好，驾驶技术也很稳定，最重要的是送到目的地不收钱走人，深藏功与名！";
        return cell;
    }
    return nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadCustomBar];
    [self loadDriverInfo];
    [self loadCustomerComment];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
