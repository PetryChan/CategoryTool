//
//  PECategoryTabCell.m
//  CategoryControlDemo
//
//  Created by petry on 2019/12/19.
//  Copyright © 2019 petry. All rights reserved.
//

#import "PECategoryTabCell.h"
#import "CategoryItem.h"
#import "CQMenuTabView.h"

@interface PECategoryTabCell()
 
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) CQMenuTabView *menTable;

@end

@implementation PECategoryTabCell
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(NSArray *)array atIndex:(NSInteger)index
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:array];
    __block NSMutableArray *titleArray = [NSMutableArray array];
    [self.dataArray enumerateObjectsUsingBlock:^(CategoryItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [titleArray addObject:obj.name];
    }];
    
    [self createView:titleArray atIndex:index];
}
- (void)createView:(NSArray *)titleArray atIndex:(NSInteger)index{
    CQMenuTabView *menTable = [[CQMenuTabView alloc] initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 30.0)];
    menTable.titleFont = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    menTable.didSelectTitleFont = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    menTable.normaTitleColor = [UIColor blackColor];
    menTable.didSelctTitleColor = UIColor.orangeColor;
    menTable.showCursor = YES;
    menTable.cursorStyle = CQTabCursorWrap;
    menTable.layoutStyle = CQTabWrapContent;
    menTable.cursorHeight = menTable.bounds.size.height;
    menTable.cursorView.backgroundColor = [UIColor colorWithRed:245/255.0 green:246/255.0 blue:250/255.0 alpha:1];;
    menTable.backgroundColor = [UIColor whiteColor];
    menTable.didTapItemAtIndexBlock = ^(UIView *view, NSInteger index) {
        
        for (CategoryItem *m in self.dataArray) { m.selected = NO; }
        CategoryItem *model = self.dataArray[index];
        model.selected = YES;
        if (self.didBlock) {
            self.didBlock();
        }
    };
    menTable.didCanSelectIndex = ^BOOL(UIView *view, NSInteger index) {
        return true;
    };
    [self addSubview:menTable];
    self.menTable = menTable;
    menTable.titles = titleArray;
     
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [menTable selectIndex:index animation:YES];
        for (CategoryItem *m in self.dataArray) { m.selected = NO; }
        CategoryItem *model = self.dataArray[index];
        model.selected = YES;
        if (self.refresh && self.didBlock) {
            self.didBlock();
        }
    });
    
}
@end
