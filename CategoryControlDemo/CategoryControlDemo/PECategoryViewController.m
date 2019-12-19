//
//  PECategoryViewController.m
//  CategoryControlDemo
//
//  Created by petry on 2019/12/19.
//  Copyright © 2019 petry. All rights reserved.
//

#import "PECategoryViewController.h"
#import "PECategoryTabCell.h"
#import "CategoryModel.h"
#import "CategoryItem.h"

@interface PECategoryViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *areasArray;
@property (nonatomic, strong) NSMutableArray *contentsArray;
@property (nonatomic, strong) NSMutableArray *yearArray;
@property (nonatomic, strong) NSMutableArray *otherArray;
@end

@implementation PECategoryViewController
- (NSMutableArray *)areasArray {
    if (!_areasArray) {
        _areasArray = [NSMutableArray array];
        NSArray *temp = @[@"地区",@"中国大陆",@"中国香港",@"中国台湾",@"美国",@"泰国",@"印度",@"日本",@"俄罗斯"];
        for (NSInteger i=0; i<temp.count; i++) {
            CategoryItem *model = [CategoryItem new];model.name = temp[i];
            model.infoID = [NSString stringWithFormat:@"areaID%zd",i];
            [_areasArray addObject:model];
        }
    }
    return _areasArray;
}
- (NSMutableArray *)contentsArray {
    if (!_contentsArray) {
        _contentsArray = [NSMutableArray array];
        NSArray *temp = @[@"全部",@"动作",@"喜剧",@"剧情",@"爱情",@"武侠",@"悬疑",@"冒险",@"科幻",@"战争",@"犯罪",@"古装",@"恐怖",@"惊悚",@"历史",@"动画",@"家庭",@"传记",@"音乐"];
        for (NSInteger i=0; i<temp.count; i++) {
            CategoryItem *model = [CategoryItem new];model.name = temp[i];
            model.infoID = [NSString stringWithFormat:@"categoryID%zd",i];
            [_contentsArray addObject:model];
        }
    }
    return _contentsArray;
}
- (NSMutableArray *)yearArray {
    if (!_yearArray) {
        _yearArray = [NSMutableArray array];
        NSArray *temp = [self getYearArray];
        for (NSInteger i=0; i<temp.count; i++) {
            CategoryItem *model = [CategoryItem new];model.name = temp[i];
            model.infoID = [NSString stringWithFormat:@"yearID%zd",i];
            [_yearArray addObject:model];
        }
    }
    return _yearArray;
}
- (NSMutableArray *)otherArray {
    if (!_otherArray) {
        _otherArray = [NSMutableArray array];
        NSArray *temp = @[@"最新热映", @"最多喜欢", @"最高评分", @"最近更新"];
        for (NSInteger i=0; i<temp.count; i++) {
            CategoryItem *model = [CategoryItem new];model.name = temp[i];
            model.infoID = [NSString stringWithFormat:@"mostID%zd",i];
            [_otherArray addObject:model];
        }
    }
    return _otherArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.edgesForExtendedLayout=UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor = UIColor.whiteColor;
    [self myTableView];
    
    UIView *bottomV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.myTableView.frame)+10, self.view.bounds.size.width, 1)];
    [self.view addSubview:bottomV];
    bottomV.backgroundColor = UIColor.grayColor;
}
- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 178) style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor whiteColor];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [self.view addSubview:_myTableView];
        _myTableView.estimatedSectionHeaderHeight = 0;
        _myTableView.estimatedSectionFooterHeight = 0;
        _myTableView.estimatedRowHeight = 42; 
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_myTableView registerClass:[PECategoryTabCell class] forCellReuseIdentifier:@"PECategoryTabCell"];
    }
    return _myTableView;
}
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return 4;
 }
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     return 42.0;
 }
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PECategoryTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PECategoryTabCell" forIndexPath:indexPath]; 
     switch (indexPath.row) {
         case 0:
         {
             NSInteger index = [self getIndexFrom:@"area"];
             [cell setData:self.areasArray atIndex:index];
         }
             
             break;
         case 1:
         {
             NSInteger index = [self getIndexFrom:@"category"];
             [cell setData:self.contentsArray atIndex:index];
         }
             break;
         case 2:
         {
             NSInteger index = [self getIndexFrom:@"year"];
             [cell setData:self.yearArray atIndex:index];
         }
             break;
         case 3:
         {
             cell.refresh = YES;
             NSInteger index = [self getIndexFrom:@"most"];
             [cell setData:self.otherArray atIndex:index];
              
         }
             break;
         default: break;
     }
     __weak typeof(self) weakSelf = self;
     cell.didBlock = ^{
         [weakSelf setShowTitle];
     };
     return cell;
 }
- (NSArray *)getYearArray
{
    NSDate *senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy"];
    NSString *currentYear = [dateformatter stringFromDate:senddate];
    NSMutableArray *tempArray = [NSMutableArray array];
    [tempArray addObject:@"全部"];
    NSInteger yearEnd = [currentYear integerValue];
    NSInteger count = 10;
    for (NSInteger i = 0; i<count; i++) {
        NSString *yearStr = [NSString stringWithFormat:@"%zd",yearEnd-i];
        if (i == count-1) {
            yearStr = [NSString stringWithFormat:@"%zd之前",yearEnd-i+1];
        }
        [tempArray addObject:yearStr];
    }
    return tempArray;
}
- (NSInteger)getIndexFrom:(NSString *)typeStr
{
    __block NSInteger index = 0;
    __block NSString *resultStr = @"";
    [self.chooseArray enumerateObjectsUsingBlock:^(CategoryModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
       if ([obj.type isEqualToString:typeStr]) {
           resultStr = obj.categoryName;
           *stop = YES;
       }
    }];
    if ([typeStr isEqualToString:@"area"]) {
        [self.areasArray enumerateObjectsUsingBlock:^(CategoryItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.name isEqualToString:resultStr]) {
                index = idx;
            }
        }];
    }else if ([typeStr isEqualToString:@"category"]) {
        [self.contentsArray enumerateObjectsUsingBlock:^(CategoryItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.name isEqualToString:resultStr]) {
                index = idx;
            }
        }];
    }else if ([typeStr isEqualToString:@"year"]) {
        [self.yearArray enumerateObjectsUsingBlock:^(CategoryItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.name isEqualToString:resultStr]) {
                index = idx;
            }
        }];
    }else if ([typeStr isEqualToString:@"most"]) {
        [self.otherArray enumerateObjectsUsingBlock:^(CategoryItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.name isEqualToString:resultStr]) {
                index = idx;
            }
        }];
    }
    return index;
}
- (void)setShowTitle {
    NSString *otherStr = @"";
    NSMutableString *strID = [NSMutableString string];
    for (CategoryItem *model in self.otherArray) {
        if (model.selected) {
            otherStr = model.name;
            [strID appendString:model.infoID];
            break;
        }
    }
     
    NSString *yearStr = @"";
    for (CategoryItem *model in self.yearArray) {
        if (model.selected) {
            yearStr = model.name;
            [strID appendString:@"|"];
            [strID appendString:model.infoID];
            break;
        }
    }
     
    NSString *contentsStr = @"";
    for (CategoryItem *model in self.contentsArray) {
        if (model.selected) {
            contentsStr = model.name;
            [strID appendString:@"|"];
            [strID appendString:model.infoID];
            break;
        }
    }
    
    NSString *areasStr = @"";
    for (CategoryItem *model in self.areasArray) {
        if (model.selected) {
            areasStr = model.name;
            [strID appendString:@"|"];
            [strID appendString:model.infoID];
            break;
        }
    }
    NSString *str = [NSString stringWithFormat:@"%@•%@•%@•%@", areasStr, contentsStr, yearStr, otherStr];
    str = [str stringByReplacingOccurrencesOfString:@"地区•" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"全部•" withString:@""];
    NSLog(@"选择的结果：%@",str);
    NSLog(@"选择的结果ID：%@",strID);
}
@end
