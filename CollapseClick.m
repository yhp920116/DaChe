//
//  CollapseClick.m
//  ZuoxinApp
//
//  Created by 新工厂 on 13-8-26.
//  Copyright (c) 2013年 Zuoxin.com. All rights reserved.
//

#import "CollapseClick.h"
#import "CollapseClickCell.h"
#import <QuartzCore/QuartzCore.h>
#define HeaderHeight 56


@implementation CollapseClick
@synthesize CollapseClickDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.isClickedArray = [[NSMutableArray alloc] initWithCapacity:[CollapseClickDelegate numberOfCellsForCollapseClick]];
        self.dataArray = [[NSMutableArray alloc] initWithCapacity:[CollapseClickDelegate numberOfCellsForCollapseClick]];
        [self reloadCollapseClick];
    }
    return self;
}

#pragma mark - reload data
-(void)reloadCollapseClick {
    // Set Up: Height
    float totalHeight = 0;
    
    // If Arrays aren't Init'd, Init them
    if (!(self.isClickedArray)) {
        self.isClickedArray = [[NSMutableArray alloc] initWithCapacity:[CollapseClickDelegate numberOfCellsForCollapseClick]];
    }
    
    if (!(self.dataArray)) {
        self.dataArray = [[NSMutableArray alloc] initWithCapacity:[CollapseClickDelegate numberOfCellsForCollapseClick]];
    }
    
    // Make sure they are clear
    [self.isClickedArray removeAllObjects];
    [self.dataArray removeAllObjects];
    
    // Remove all subviews
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    
    // Add cells
    for (int xx = 0; xx < [CollapseClickDelegate numberOfCellsForCollapseClick]; xx++) {
        // Create Cell
        CollapseClickCell *cell = [CollapseClickCell newCollapseClickCellWithTitle:[CollapseClickDelegate titleForCollapseClickAtIndex:xx] Index:xx content:[CollapseClickDelegate viewForCollapseClickContentViewAtIndex:xx]];
        
        
        // Set cell.TitleView's backgroundColor
        if ([(id)CollapseClickDelegate respondsToSelector:@selector(colorForCollapseClickTitleViewAtIndex:)]) {
            cell.headerView.backgroundColor = [CollapseClickDelegate colorForCollapseClickTitleViewAtIndex:xx];
        }
        else {
            cell.headerView.backgroundColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        }
        
        
        // Set cell.TitleLabel's Color
        if ([(id)CollapseClickDelegate respondsToSelector:@selector(colorForTitleLabelAtIndex:)]) {
            cell.titleLabel.textColor = [CollapseClickDelegate colorForTitleLabelAtIndex:xx];
        }
        else {
            cell.titleLabel.textColor = [UIColor whiteColor];
        }
        
        
        // Set cell.ContentView's size
        cell.contentView.frame = CGRectMake(0, HeaderHeight + 10, self.frame.size.width, cell.contentView.frame.size.height);
        
        // Set cell's size
        cell.frame = CGRectMake(0, totalHeight, self.frame.size.width, HeaderHeight);
        
        
        // Add target to Button
        [cell.headerBtn addTarget:self action:@selector(didSelectCollapseClickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        // Add cell
        [self addSubview:cell];
        
        // Add to DataArray & isClickedArray
        [self.isClickedArray addObject:[NSNumber numberWithBool:NO]];
        [self.dataArray addObject:cell];
        
        // Calculate totalHeight
        totalHeight += HeaderHeight+ 4;
    }
    
    // Set self's ContentSize and ContentOffset
    [self setContentSize:CGSizeMake(self.frame.size.width, totalHeight)];
    [self setContentOffset:CGPointZero];
    
}

#pragma mark - Reposition Cells
-(void)repositionCollapseClickCellsBelowIndex:(int)index withOffset:(float)offset {
    for (int yy = index+1; yy < self.dataArray.count; yy++) {
        CollapseClickCell *cell = [self.dataArray objectAtIndex:yy];
        cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y + offset, cell.frame.size.width, cell.frame.size.height);
    }
    
    // Resize self.ContentSize
    CollapseClickCell *lastCell = [self.dataArray objectAtIndex:self.dataArray.count - 1];
    [self setContentSize:CGSizeMake(self.frame.size.width, lastCell.frame.origin.y + lastCell.frame.size.height + 10)];
}

#pragma mark - Did Click HeaderBtn

- (void)didSelectCollapseClickButton:(UIButton *)btn
{
    BOOL isOpen = NO;
    
    // Cell is OPEN -> CLOSED
    if ([[self.isClickedArray objectAtIndex:btn.tag] boolValue] == YES) {
        [self closeCollapseClickCellAtIndex:btn.tag animated:YES];
    }
    // Cell is CLOSED -> OPEN
    else {
        [self openCollapseClickCellAtIndex:btn.tag animated:YES];
        isOpen = YES;
    }
    
    // Call delegate method
    if ([(id)CollapseClickDelegate respondsToSelector:@selector(didClickCollapseClickCellAtIndex:isNowOpen:)]) {
        [CollapseClickDelegate didClickCollapseClickCellAtIndex:btn.tag isNowOpen:isOpen];
    }
}

#pragma mark - Open CollapseClickCell
- (void)openCollapseClickCellAtIndex:(int)index animated:(BOOL)animated
{
    if ([[self.isClickedArray objectAtIndex:index] boolValue] != YES) {
        float duration = 0;
        if (animated) {
            duration = 0.25;
        }
        CollapseClickCell *cell = [self.dataArray objectAtIndex:index];
        [UIView animateWithDuration:duration animations:^{
            //Resize cell
//            cell.contentView.hidden = NO;
            cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.contentView.frame.origin.y + cell.contentView.frame.size.height + 10 );
            
            
            //reset self.isClickedArray
            [self.isClickedArray replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:YES]];
            
            //reposition all collapseClickcell bellow index
            [self repositionCollapseClickCellsBelowIndex:index withOffset:cell.contentView.frame.size.height + 10];
            
        }];
        
        CABasicAnimation *scale=[CABasicAnimation animationWithKeyPath:@"transform"];
        [scale setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 0.2, 1.0)]];
        [scale setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        [scale setDuration:duration];
        [cell.contentView.layer addAnimation:scale forKey:nil];
        
        
        
    }
}

- (void)openCollapseClickCellsWithIndexes:(NSArray *)indexArray animated:(BOOL)animated
{
    // This works off of NSNumbers for each Index
    for (int ii = 0; ii < indexArray.count; ii++) {
        id indexID = indexArray[ii];
        if ([indexID isKindOfClass:[NSNumber class]]) {
            [self openCollapseClickCellAtIndex:[indexID intValue] animated:animated];
        }
    }
}

#pragma mark - closeCollapseClickCell

- (void)closeCollapseClickCellAtIndex:(int)index animated:(BOOL)animated
{
    if ([[self.isClickedArray objectAtIndex:index] boolValue] == YES) {
        float duration = 0;
        if (animated) {
            duration = 0.25;
        }
        CollapseClickCell *cell = [self.dataArray objectAtIndex:index];
        [UIView animateWithDuration:duration animations:^{
            // Resize Cell
//            cell.contentView.hidden = YES;
            cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, HeaderHeight);
            
                        
            // Change isClickedArray
            [self.isClickedArray replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:NO]];
            
            // Reposition all CollapseClickCells below Cell
            [self repositionCollapseClickCellsBelowIndex:index withOffset:-1*(cell.contentView.frame.size.height + 10)];
        }];
        CABasicAnimation *scale=[CABasicAnimation animationWithKeyPath:@"transform"];
        [scale setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        [scale setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 0.2, 1.0)]];
        [scale setDuration:duration];
        [cell.contentView.layer addAnimation:scale forKey:@"scale"];
    }
}

- (void)closeCollapseClickCellsWithIndexes:(NSArray *)indexArray animated:(BOOL)animated
{
    // This works off of NSNumbers for each Index
    for (int ii = 0; ii < indexArray.count; ii++) {
        id indexID = indexArray[ii];
        if ([indexID isKindOfClass:[NSNumber class]]) {
            [self closeCollapseClickCellAtIndex:[indexID intValue] animated:animated];
        }
    }
}

#pragma mark - CollapseClickCell for Index
-(CollapseClickCell *)collapseClickCellForIndex:(int)index {
    if ([[self.dataArray objectAtIndex:index] isKindOfClass:[CollapseClickCell class]]) {
        return [self.dataArray objectAtIndex:index];
    }
    
    return nil;
}


#pragma mark - Scroll To Cell
-(void)scrollToCollapseClickCellAtIndex:(int)index animated:(BOOL)animated {
    CollapseClickCell *cell = [self.dataArray objectAtIndex:index];
    [self setContentOffset:CGPointMake(cell.frame.origin.x, cell.frame.origin.y) animated:animated];
}


#pragma mark - Content View for Cell
-(UIView *)contentViewForCellAtIndex:(int)index {
    CollapseClickCell *cell = [self.subviews objectAtIndex:index];
    return cell.contentView;
}















@end
