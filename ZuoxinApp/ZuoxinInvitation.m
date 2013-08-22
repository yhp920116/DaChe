//
//  ZuoxinInvitation.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "ZuoxinInvitation.h"
#import "BackBtn.h"
#import "CustomBtn.h"

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

- (void)loadCustomBar
{
    self.navTitleLabel.text = @"邀请好友";
    self.backBtn.hidden = YES;
    self.customBtn.hidden = YES;
}

- (void)loadInviteView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-44)];
    scrollView.contentSize = CGSizeMake(320, 560);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = NO;
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    
    
    UIImage *inviteImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"invite-backimage@2x" ofType:@"png"]];
    UIImageView *inviteImgView = [[UIImageView alloc] initWithImage:inviteImg];
    inviteImgView.frame = CGRectMake(0, 0, 320, 407/2);
    [scrollView addSubview:inviteImgView];
    
    UITableView *inviteTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 407/2, 320, 560-407/2) style:UITableViewStyleGrouped];
    inviteTable.dataSource = self;
    inviteTable.delegate = self;
    inviteTable.backgroundView = nil;
    inviteTable.showsHorizontalScrollIndicator = NO;
    inviteTable.showsVerticalScrollIndicator = NO;
    [scrollView addSubview:inviteTable];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 1;
            break;
        }
        case 1:
        {
            return 4;
            break;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIndentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
        //thumbnail
        UIImageView *thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(10, 14, 22, 22)];
        thumbnail.tag = 888;
        [cell.contentView addSubview:thumbnail];
        
        //cellTitle
        UILabel *cellTitle = [[UILabel alloc] initWithFrame:CGRectMake(42, 17, 160, 16)];
        cellTitle.tag = 889;
        cellTitle.font = [UIFont systemFontOfSize:16.0f];
        cellTitle.textColor = [UIColor blackColor];
        cellTitle.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:cellTitle];
        
        switch (indexPath.section) {
            case 0:
            {
                UILabel *accessoryLable = [[UILabel alloc] initWithFrame:CGRectMake(210, 17, 90, 16)];
                accessoryLable.tag = 990;
                accessoryLable.font  = [UIFont systemFontOfSize:16.0f];
                accessoryLable.textColor = [UIColor blackColor];
                accessoryLable.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:accessoryLable];
                break;
            }
            case 1:
            {
                UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(280, 17.5, 10.5, 15)];
                arrowView.tag = 991;
                [cell.contentView addSubview:arrowView];
                break;
            }

        }
    }
    
    UIImageView *thumbnail = (UIImageView *)[cell viewWithTag:888];
    UILabel *cellTitle = (UILabel *)[cell viewWithTag:889];
    switch (indexPath.section) {
        case 0:
        {
            thumbnail.image = [UIImage imageNamed:@"invite-gift@2x.png"];
            cellTitle.text = @"邀请码：23098490";
            UILabel *accessoryLabel = (UILabel *)[cell viewWithTag:990];
            accessoryLabel.text = @"剩余：10次";
            break;
        }
        case 1:
        {
            UIImageView *arrowView = (UIImageView *)[cell viewWithTag:991];
            arrowView.image = [UIImage imageNamed:@"search-cell-accessory@2x.png"];
            if (indexPath.row == 0) {
                thumbnail.image = [UIImage imageNamed:@"invite-message@2x.png"];
                cellTitle.text = @"短信邀请";
            }
            if (indexPath.row == 1) {
                thumbnail.image = [UIImage imageNamed:@"invite-sina@2x.png"];
                cellTitle.text = @"新浪微博邀请";
            }
            if (indexPath.row == 2) {
                thumbnail.image = [UIImage imageNamed:@"invite-tencent@2x.png"];
                cellTitle.text = @"腾讯微博邀请";
            }
            if (indexPath.row == 3) {
                thumbnail.image = [UIImage imageNamed:@"invite-weixin@2x.png"];
                cellTitle.text = @"微信邀请";
            }
            break;
        }
    }
    
    return cell;
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
