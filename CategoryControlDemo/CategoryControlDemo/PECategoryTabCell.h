//
//  PECategoryTabCell.h
//  CategoryControlDemo
//
//  Created by petry on 2019/12/19.
//  Copyright © 2019 petry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PECategoryTabCell : UITableViewCell

@property (nonatomic, copy) void(^didBlock)(void);
@property (nonatomic, assign) BOOL refresh;
 
- (void)setData:(NSArray *)array atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
