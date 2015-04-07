//
//  DriverDetail.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-22.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "DriverDetail.h"
#import "DriverInfoCell.h"
#import "CustomerCommentCell.h"
#import "FlatRoundedImageView.h"
#import "DPMeterView.h"
#import "UIBezierPath+BasicShapes.h"
#import <QuartzCore/QuartzCore.h>
#import "zuoxin.h"
#import "SIAlertView.h"


@interface DriverDetail ()

@end

@implementation DriverDetail

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.driverBasicInfo = [[DriverBasicInfo alloc] init];
        self.commentArr = [[NSMutableArray alloc] initWithCapacity:8];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // load UI
    [self loadCustomBar];
    [self loadDriverInfo];
    //check Network
    if ([self connected]) {
        [self loadData];
        [self loadCustomerComment];
    }
    else
    {
        
    }
    [self resizeCustomerTableAndScrollView];
    
}


#pragma mark - loadData

- (void)loadData
{
    @try {
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
        arr = [self.server getdrivercomment:self.driverBasicInfo.driverID pageindex:2];
        [self.commentArr addObjectsFromArray:arr];
    }
    @catch (RuntimeError *runtimeError) {
        //    NSLog(@"%d,%@",[runtimeError errornumber],[runtimeError errormessage]);
    }
    @catch (TException *texception) {
        NSLog(@"%@",texception);
    }
    @finally {

    }
    
//    NSArray *arr = [[NSArray alloc] initWithObjects:@"这家伙服务态度真是好，驾驶技术也很稳定，最重要的是送到目的地不收钱走人，深藏功与名！",@"这家伙服务心态不错，塞了2个小时车只骂了100句***",@"凡是不能太认真，认真你就熟了！",@"这家伙服务态度真是好，驾驶技术也很稳定，最重要的是送到目的地不收钱走人，深藏功与名！",nil];
    
}

- (void)loadCustomBar
{
    self.customBtn.hidden = YES;
    self.rightBtn.hidden = YES;
    self.navTitleLabel.text = @"司机详情";
    self.view.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1];
}

- (void)loadDriverInfo
{
    //scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 47, 320, self.view.frame.size.height-47)];
    scrollView.tag = 999;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = NO;
//    [self.view insertSubview:scrollView atIndex:0];
    [self.view addSubview:scrollView];
    
    
    //defaultImgView
    UIImage *defaultImg = [UIImage imageNamed:@"defaultbg@2x.png"];
    UIImageView *defaultImgView = [[UIImageView alloc] initWithImage:defaultImg];
    defaultImgView.frame = CGRectMake(0, 0, 320, 467/2);
    [scrollView addSubview:defaultImgView];
    
    DPMeterView *dpmeterView = [[DPMeterView alloc] initWithFrame:CGRectMake(205, 15, 110, 15)];
    [dpmeterView add:self.driverBasicInfo.commentScore/5.0];
    [dpmeterView setMeterType:DPMeterTypeLinearHorizontal];
    [dpmeterView setShape:[UIBezierPath stars:5 shapeInFrame:CGRectMake(0, 0, 110, 15)].CGPath];
    [dpmeterView setTrackTintColor:[UIColor lightGrayColor]];
    [dpmeterView setProgressTintColor:[UIColor darkGrayColor]];
    dpmeterView.progressTintColor = [UIColor colorWithRed:255/255.f green:199/255.f blue:87/255.f alpha:1.f];
    [dpmeterView setGradientOrientationAngle:2*M_PI];
    [defaultImgView addSubview:dpmeterView];
    
    FlatRoundedImageView *thumnail = [[FlatRoundedImageView alloc] init];
    UIImage *driverThumbnail = [[UIImage alloc] initWithData:self.driverBasicInfo.thumbnailData];
    UIImage *driverDefault = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"moren1@2x" ofType:@"png"]];
    if (driverThumbnail) {
        thumnail.image = driverThumbnail;
    }
    else
    {
        thumnail.image = driverDefault;
    }

    thumnail.frame = CGRectMake(110, 30, 100, 100);
    thumnail.borderColor = [UIColor whiteColor];
    thumnail.borderWidth = 2.0f;
    [defaultImgView addSubview:thumnail];
    
    //driver status
    UILabel *statusTitle = [[UILabel alloc] initWithFrame:CGRectMake(210, 40,40, 14)];
    statusTitle.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [self setLabelCommonProperty:statusTitle];
    statusTitle.text = @"状态:";
    [defaultImgView addSubview:statusTitle];
    
    UILabel *statusContent = [[UILabel alloc] initWithFrame:CGRectMake(250, 40, 60, 14)];
    statusContent.textColor = [UIColor orangeColor];
    [self setLabelCommonProperty:statusContent];
    
    switch (self.driverBasicInfo.driverState) {
        case 0:
        {
            statusContent.text = @"休息中";
            statusContent.textColor = GrayFontColor;
           
            break;
        }
        case 1:
        {
            statusContent.text = @"空闲状态";
            statusContent.textColor = GreenFontColor;
            
            break;
        }
        case 2:
        {
            statusContent.text = @"服务中";
            statusContent.textColor = OrangeFontColor;
            break;
        }
    }
    [defaultImgView addSubview:statusContent];

    
    //driverName
    UILabel *driverName = [[UILabel alloc] init];
    driverName.font = BigBigFont;
    driverName.textColor = BlackFontColor;
    driverName.backgroundColor = [UIColor clearColor];
    driverName.text = [self.driverBasicInfo driverName];
    CGSize size = CGSizeMake(320, 1000);
    CGSize nameSize = [driverName.text sizeWithFont:driverName.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    driverName.frame = CGRectMake((320-nameSize.width)/2, 135 , nameSize.width, 15.0);
    [defaultImgView addSubview:driverName];
    
    
    //sex and native
    
    UILabel *sexContent = [[UILabel alloc] init];
    sexContent.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    sexContent.backgroundColor = [UIColor clearColor];
    sexContent.font = MediumFont;
    
    switch (self.driverBasicInfo.driverSex) {
        case 0:
        {
            sexContent.text = @"性别：男";
            break;
        }
        case 1:
        {
            sexContent.text = @"性别：女";
            break;
        }
    }
    [defaultImgView addSubview:sexContent];
    
    
    UILabel *nativeContent = [[UILabel alloc] init];
    nativeContent.textColor = BlackFontColor;
    nativeContent.backgroundColor = [UIColor clearColor];
    nativeContent.font = MediumFont;
    nativeContent.text = [NSString stringWithFormat:@"籍贯：%@",self.driverBasicInfo.driverNativePlace];
    [defaultImgView addSubview:nativeContent];
    
    CGSize sexContentSize = [sexContent.text sizeWithFont:sexContent.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    CGSize nativeContentSize = [nativeContent.text sizeWithFont:nativeContent.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    
    sexContent.frame = CGRectMake((320-sexContentSize.width-nativeContentSize.width-10)/2 , 160, sexContentSize.width, 12);
    nativeContent.frame = CGRectMake(sexContent.frame.origin.x+sexContent.frame.size.width+10, 160, nativeContentSize.width, 12);
    
    //callbtn
    UIImage *greenbtnImg = [[UIImage imageNamed:@"greenbtn.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 5, 2, 5)];
    UIImage *phoneImg = [UIImage imageNamed:@"phoneicon.png"];
    UIButton *callbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    callbtn.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    callbtn.frame = CGRectMake(4, 240-47, 312, 33.5);
    callbtn.titleLabel.font = BigBigFont;
    [callbtn setBackgroundImage:greenbtnImg forState:UIControlStateNormal];
    [callbtn setImage:phoneImg forState:UIControlStateNormal];
    NSString *tel = [NSString stringWithFormat:@"%@",self.driverBasicInfo.driverPhoneNum];
    [callbtn setTitle:tel forState:UIControlStateNormal];
    [callbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [callbtn addTarget:self action:@selector(callDriverBtn:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:callbtn];
    
    UIImage *separatorImg = [UIImage imageNamed:@"separator@2x.png"];
    
    
    //otherField
    UIView *otherField = [[UIView alloc] initWithFrame:CGRectMake(5, 240+33.5+10-47, 310, 33.5*3+2)];
    otherField.backgroundColor = [UIColor whiteColor];
    [self setLayerCornerRadiusAndshadowInView:otherField];
    [scrollView addSubview:otherField];
    
    UILabel *driveTimesTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 9.75, 30, 14)];
    driveTimesTitle.textColor = BlackFontColor;
    [self setLabelCommonProperty:driveTimesTitle];
    driveTimesTitle.text = @"代驾";
    [otherField addSubview:driveTimesTitle];
    
    UILabel *driveTimesContent = [[UILabel alloc] initWithFrame:CGRectMake(65, 9.75, 60, 14)];
    driveTimesContent.textColor = GrayFontColor;
    [self setLabelCommonProperty:driveTimesContent];
    driveTimesContent.text = [NSString stringWithFormat:@"%@次",self.driverBasicInfo.driverCount];
    [otherField addSubview:driveTimesContent];
    

    UIImageView *separatorLine_ = [[UIImageView alloc] initWithFrame:CGRectMake(0, 33.5, 310, 1)];
    separatorLine_.image = separatorImg;
    [otherField addSubview:separatorLine_];
    
    UILabel *driveAgeTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 9.75+34.5, 30, 14)];
    driveAgeTitle.textColor = BlackFontColor;
    [self setLabelCommonProperty:driveAgeTitle];
    driveAgeTitle.text = @"驾龄";
    [otherField addSubview:driveAgeTitle];
    
    UILabel *driveAgeContent = [[UILabel alloc] initWithFrame:CGRectMake(65, 9.75+34.5, 60, 14)];
    driveAgeContent.textColor = GrayFontColor;
    [self setLabelCommonProperty:driveAgeContent];
    driveAgeContent.text = [NSString stringWithFormat:@"%@年",self.driverBasicInfo.driverAge];
    [otherField addSubview:driveAgeContent];
    
    UIImageView *_separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 33.5*2+1, 310, 1)];
    _separatorLine.image = separatorImg;
    [otherField addSubview:_separatorLine];
    
    UILabel *distanceTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 9.75+33.5*2+2, 30, 14)];
    distanceTitle.textColor = BlackFontColor;
    [self setLabelCommonProperty:distanceTitle];
    distanceTitle.text = @"距离";
    [otherField addSubview:distanceTitle];
    
    UILabel *distanceContent = [[UILabel alloc] initWithFrame:CGRectMake(65, 9.75+33.5*2+2, 120, 14)];
    distanceContent.textColor = GrayFontColor;
    [self setLabelCommonProperty:distanceContent];
    
    if (self.driverBasicInfo.distance >= 1000) {
        NSString *distanceStr = [[NSString alloc] initWithFormat:@"%f",self.driverBasicInfo.distance/1000.0];
        NSRange dotLocationRange = [distanceStr rangeOfString:@"."];
        NSRange range = {0,dotLocationRange.location+2};
        distanceStr = [distanceStr substringWithRange:range];
        distanceContent.text = [NSString stringWithFormat:@"%@千米",distanceStr];
    }
    else
    {
        NSString *distanceStr = [[NSString alloc] initWithFormat:@"%f",self.driverBasicInfo.distance];
        NSRange dotLocationRange = [distanceStr rangeOfString:@"."];
        NSRange range = {0,dotLocationRange.location+2};
        distanceStr = [distanceStr substringWithRange:range];
        distanceContent.text = [NSString stringWithFormat:@"%@米",distanceStr];
    }
    
    
    [otherField addSubview:distanceContent];
  
}

- (void)loadCustomerComment
{
    UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:999];
    
    //461.5
    _customerCommentTable = [[UITableView alloc] initWithFrame:CGRectMake(5, 349
                                                                          , 310, 80*[self.commentArr count]+60) style:UITableViewStylePlain];
    _customerCommentTable.tag = 998;
    _customerCommentTable.dataSource = self;
    _customerCommentTable.delegate = self;
    _customerCommentTable.scrollEnabled = NO;
    _customerCommentTable.showsVerticalScrollIndicator = NO;
    _customerCommentTable.layer.cornerRadius = 3.0f; 
    _customerCommentTable.layer.borderWidth = 0.4f;
    _customerCommentTable.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    if (_refreshHeaderView == nil) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0, -_customerCommentTable.frame.size.height, _customerCommentTable.frame.size.width, _customerCommentTable.frame.size.height)];
        _refreshHeaderView.backgroundColor = [UIColor whiteColor];
        _refreshHeaderView.delegate = self;
        [_customerCommentTable addSubview:_refreshHeaderView];
        [_refreshHeaderView refreshLastUpdatedDate];
    }
    
    //tableHeaderView
    
    UIView *tableHeaderview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 310, 30)];
    tableHeaderview.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.1];
    _customerCommentTable.tableHeaderView = tableHeaderview;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 9, 200, 12)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"该司机评价";
    titleLabel.textColor = BlackFontColor;
    titleLabel.font = MediumFont;
    [tableHeaderview addSubview:titleLabel];
    
    
    //tableFooterView
    
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 310, 30)];
    tableFooterView.backgroundColor = [UIColor whiteColor];
    _customerCommentTable.tableFooterView = tableFooterView;

    
    UIImage *morearrow =[UIImage imageNamed:@"morearrow.png"];
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.tag = 9201;
    _moreBtn.frame = CGRectMake(60, 9, 200, 12);
    _moreBtn.titleLabel.font = MediumFont;
    [_moreBtn setTitleColor:GrayFontColor forState:UIControlStateNormal];
    [_moreBtn setTitleColor:BlackFontColor forState:UIControlStateHighlighted];
    [_moreBtn setImage:morearrow forState:UIControlStateNormal];
    [_moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [tableFooterView addSubview:_moreBtn];
    
    [scrollView addSubview:_customerCommentTable];
    
}

#pragma mark - tableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.commentArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIndentifier = @"Cell";
    CustomerCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if (cell == nil) {
        cell = [[CustomerCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
    }
    
    UIImage *separatorImg = [UIImage imageNamed:@"separator@2x.png"];
    
    cell.phoneNumLabel.text = @"122****2222";
    cell.commentDateLabel.text = @"2013-1-1";
    
    cell.commentDetailLabel.text = [self.commentArr objectAtIndex:indexPath.row];
    CGSize size = CGSizeMake(280, 1000);
    CGSize textSize = [cell.commentDetailLabel.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    cell.commentDetailLabel.frame = CGRectMake(10, 24, textSize.width, textSize.height);
    
    cell.separatorLine.image = separatorImg;
    
    return cell;
  
}

#pragma mark - EGORefreshHeaderView
- (void)reloadTableViewDataSource
{
    _reloading = YES;
}

- (void)doneLoadingTableViewData
{
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:(UITableView*)[self.view viewWithTag:999]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return _reloading;
}

- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}

#pragma mark - reload Method

- (void)resizeCustomerTableAndScrollView
{
    _customerCommentTable.frame = CGRectMake(5, 349, 310, 80*[self.commentArr count]+60);
    [self reloadMoreBtn];
    UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:999];
    [scrollView setContentSize:CGSizeMake(320, 349+_customerCommentTable.frame.size.height+70)];
}

- (void)reloadMoreBtn
{
    if ([self.commentArr count] == 0) {
        [_moreBtn setTitle:@"该司机暂无评价" forState:UIControlStateNormal];
    }
    else
    {
        [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    }
}

#pragma mark - labelproperty
- (void)setLabelCommonProperty:(UILabel *)label
{
    label.font = [UIFont systemFontOfSize:14.0f];
    label.backgroundColor = [UIColor clearColor];
}


#pragma mark - btnClick

- (void)moreBtnClick
{
    NSArray *arr = [[NSArray alloc] initWithObjects:@"这家伙服务态度真是好，驾驶技术也很稳定，最重要的是送到目的地不收钱走人，深藏功与名！",@"这家伙服务心态不错，塞了2个小时车只骂了100句***",@"凡是不能太认真，认真你就熟了！",@"这家伙服务态度真是好，驾驶技术也很稳定，最重要的是送到目的地不收钱走人，深藏功与名！",nil];
    [self.commentArr addObjectsFromArray:arr];
    [_customerCommentTable reloadData];
    [self resizeCustomerTableAndScrollView];
    
}

- (void)callDriverBtn:(id)sender
{
    switch (self.driverBasicInfo.driverState) {
        case 1:
        {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"拨打该电话？"];
            alertView.messageColor = [UIColor grayColor];
            alertView.messageFont = [UIFont systemFontOfSize:14.0f];
            alertView.buttonFont = [UIFont systemFontOfSize:12.0f];
            [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
                
                NSString *tel = [[NSString alloc] initWithFormat:@"tel://%@",self.driverBasicInfo.driverPhoneNum];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
            }];
            [alertView addButtonWithTitle:@"取消" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
                [alertView dismissAnimated:YES];
            }];
            [alertView show];
            break;
        }
        case 2:
        {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"该司机正在服务中..."];
            [self customAlertViewProperty:alertView andBlock:^{
                [alertView dismissAnimated:YES];
            }];
            [alertView show];
            break;
        }
    }
    
}


@end
