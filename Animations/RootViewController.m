//
//  RootViewController.m
//  Animations
//
//  Created by zhangbinbin on 2017/3/17.
//  Copyright © 2017年 zhangbinbin. All rights reserved.
//

#import "RootViewController.h"

#import "ViewAnimationsVC.h"

typedef NSString* kDataSourceInfoKey;

//数据源中值对应的key
kDataSourceInfoKey kDataSourceInfoKeyTitle = @"kDataSourceInfoKeyTitle";
kDataSourceInfoKey kDataSourceInfoKeyDetail = @"kDataSourceInfoKeyDetail";
kDataSourceInfoKey kDataSourceInfoKeyXibName = @"kDataSourceInfoKeyXibName";
kDataSourceInfoKey kDataSourceInfoKeyClassName = @"kDataSourceInfoKeyClassName";

@interface RootViewController ()

@property (nonatomic, strong) NSArray<NSDictionary*>* dataArry;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"动画";
    
    _dataArry = @[@{kDataSourceInfoKeyTitle:@"1.View Animations",
                    kDataSourceInfoKeyDetail:@"通过修改对应视图(UIView)的属性,可以实现一些最基础的动画效果.",
                    kDataSourceInfoKeyXibName:@"ViewAnimationsVC",
                    kDataSourceInfoKeyClassName:@"ViewAnimationsVC"}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rootCell"
                                                            forIndexPath:indexPath];
    
    NSDictionary* info = _dataArry[indexPath.row];
    NSString* title = info[kDataSourceInfoKeyTitle];
    NSString* detail = info[kDataSourceInfoKeyDetail];
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = detail;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* info = _dataArry[indexPath.row];
    NSString* xibName = info[kDataSourceInfoKeyXibName];
    NSString* title = info[kDataSourceInfoKeyTitle];
    NSString* className = info[kDataSourceInfoKeyClassName];
    
    Class classVC = NSClassFromString(className);
    
    UIViewController* vc = [[classVC alloc]initWithNibName:xibName
                                                             bundle:nil];
    vc.title = title;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
