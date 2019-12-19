//
//  ViewController.m
//  CategoryControlDemo
//
//  Created by petry on 2019/12/19.
//  Copyright © 2019 petry. All rights reserved.
//

#import "ViewController.h"
#import "CategoryModel.h"
#import "PECategoryViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"分类选择demo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *categoryView = [[UIView alloc] initWithFrame:CGRectMake((UIScreen.mainScreen.bounds.size.width-156)*0.5, 200, 156, 24)];
    [self.view addSubview:categoryView];
    categoryView.layer.cornerRadius = 12;
    categoryView.clipsToBounds = YES;
    categoryView.backgroundColor = [UIColor colorWithRed:246/255.0 green:247/255.0 blue:250/255.0 alpha:1];
            
    
    UIButton *category1Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [category1Btn setTitle:@"都市" forState:UIControlStateNormal];
    category1Btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [category1Btn setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forState:UIControlStateNormal];
    [categoryView addSubview:category1Btn];
    category1Btn.frame = CGRectMake(8, 0, 40, categoryView.bounds.size.height);
    [category1Btn addTarget:self action:@selector(categoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *category2Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [category2Btn setTitle:@"奇幻" forState:UIControlStateNormal];
    category2Btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [category2Btn setTitleColor:category1Btn.titleLabel.textColor forState:UIControlStateNormal];
    [categoryView addSubview:category2Btn];
    category2Btn.frame = CGRectMake(CGRectGetMaxX(category1Btn.frame), 0, 40, categoryView.bounds.size.height);
    [category2Btn addTarget:self action:@selector(categoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *categoryAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [categoryAllBtn setTitle:@"全部分类" forState:UIControlStateNormal];
    categoryAllBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [categoryAllBtn setTitleColor:category1Btn.titleLabel.textColor forState:UIControlStateNormal];
    [categoryView addSubview:categoryAllBtn];
    categoryAllBtn.frame = CGRectMake(CGRectGetMaxX(category2Btn.frame), 0, 60, categoryView.bounds.size.height);
    [categoryAllBtn addTarget:self action:@selector(categoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)categoryBtnClick:(UIButton *)sender
{
    NSString *categoryStr = sender.titleLabel.text;
    NSArray *params = [NSArray array];
    if ([categoryStr isEqualToString:@"都市"]) {
        CategoryModel *model1 = [CategoryModel new];
        model1.type = @"category";
        model1.categoryName = @"爱情";
        CategoryModel *model2 = [CategoryModel new];
        model2.type = @"area";
        model2.categoryName = @"中国大陆";
        params = @[model1,model2];
    }
    else if([categoryStr isEqualToString:@"奇幻"]) {
        CategoryModel *model1 = [CategoryModel new];
        model1.type = @"category";
        model1.categoryName = @"科幻";
        CategoryModel *model2 = [CategoryModel new];
        model2.type = @"year";
        model2.categoryName = @"2015";
        params = @[model1,model2];
    }
    PECategoryViewController *categoryVC = [PECategoryViewController new];
    categoryVC.chooseArray = params;
    [self.navigationController pushViewController:categoryVC animated:YES];
}

@end
