//
//  CollapseClick.h
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-26.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CollapseClickCell;

@protocol CollapseClickDelegate <NSObject>

@required
- (NSInteger)numberOfCellsForCollapseClick;
- (NSString *)titleForCollapseClickAtIndex:(NSInteger)index;
- (UIView *)viewForCollapseClickContentViewAtIndex:(int)index;

@optional
-(UIColor *)colorForCollapseClickTitleViewAtIndex:(int)index;
-(UIColor *)colorForTitleLabelAtIndex:(int)index;
-(void)didClickCollapseClickCellAtIndex:(int)index isNowOpen:(BOOL)open;

@end

@interface CollapseClick : UIScrollView<UIScrollViewDelegate>{
    __weak id <CollapseClickDelegate> CollapseClickDelegate;
}

// Delegate
@property (weak) id <CollapseClickDelegate> CollapseClickDelegate;

// Properties
@property (nonatomic, strong) NSMutableArray *isClickedArray;
@property (nonatomic, strong) NSMutableArray *dataArray;

// Methods
-(void)reloadCollapseClick;
-(CollapseClickCell *)collapseClickCellForIndex:(int)index;
-(void)scrollToCollapseClickCellAtIndex:(int)index animated:(BOOL)animated;
-(UIView *)contentViewForCellAtIndex:(int)index;
-(void)openCollapseClickCellAtIndex:(int)index animated:(BOOL)animated;
-(void)closeCollapseClickCellAtIndex:(int)index animated:(BOOL)animated;
-(void)openCollapseClickCellsWithIndexes:(NSArray *)indexArray animated:(BOOL)animated;
-(void)closeCollapseClickCellsWithIndexes:(NSArray *)indexArray animated:(BOOL)animated;

@end
