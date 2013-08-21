//
//  ZuoxinTaxiInfo.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-20.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "ZuoxinTaxiInfo.h"
#import "BackBtn.h"
#import "CustomBtn.h"
#import "DriverInfoCell.h"

@interface ZuoxinTaxiInfo ()

@end

@implementation ZuoxinTaxiInfo

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
    self.backBtn.hidden = YES;
    [self.customBtn setTitle:@"优惠卷" forState:UIControlStateNormal];
    
//    UIImage *listImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"search-list-button-normal@2x" ofType:@"png"] ];
//    UIImage *listImg_s = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"search-list-button-selected@2x" ofType:@"png"]];
//
//    UIImage *mapImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"search-map-button-normal@2x" ofType:@"png"]];
//
//    UIImage *mapImg_s = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"search-map-button-selected@2x" ofType:@"png"]];

    UISegmentedControl *listAndMap = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"列表",@"地图",nil]];
    listAndMap.frame = CGRectMake(0, 0, 177, 24);
    listAndMap.segmentedControlStyle = UISegmentedControlStyleBar;
    listAndMap.selectedSegmentIndex = 1;
    [listAndMap addTarget:self action:@selector(segmentSwitch:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView =  listAndMap;
}

- (void)segmentSwitch:(id)sender
{
    UISegmentedControl *listAndMap = (UISegmentedControl *)sender;
    switch (listAndMap.selectedSegmentIndex) {
        case 0:
        {
            break;
        }
        case 1:
        {
            break;
        }
    }
}

#pragma mark - TaxiInfoMode

- (void)setTaxiInfoMode:(TaxiInfoMode)taxiInfoMode
{
    _taxiInfoMode = taxiInfoMode;
    switch (_taxiInfoMode) {
        case 0:
        {
            
            break;
        }
        case 1:
        {
            UITableView *taxiInfoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-49) style:UITableViewStylePlain];
            taxiInfoTable.tag = 999;
            taxiInfoTable.delegate = self;
            taxiInfoTable.dataSource = self;
            taxiInfoTable.showsVerticalScrollIndicator = NO;
            taxiInfoTable.backgroundColor = [UIColor clearColor];
            [self.view addSubview:taxiInfoTable];
            break;
        }
        case 2:
        {
            break;
        }

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIndentifier =@"Cell";
    DriverInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if (cell == nil) {
        cell = [[DriverInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self loadCustomBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
