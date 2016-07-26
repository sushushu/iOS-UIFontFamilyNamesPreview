//
//  ViewController.m
//  iOS-UIFontFamilyNamesPreview
//
//  Created by softlipa软嘴唇 on 16/7/26.
//  Copyright © 2016年 softlipa. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *data;

@end

@implementation ViewController

#pragma mark - 💤 懒加载

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.rowHeight  = 80.0f;
        _tableView.backgroundColor = [UIColor colorWithRed:1.00 green:0.99 blue:0.92 alpha:1.00];
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}


- (NSArray *)data {
    
    if (!_data) {
        
        _data = [[NSMutableArray alloc]init];
        
        NSMutableArray *temp = [[NSMutableArray alloc]init];
        
        NSArray *familyNames =[UIFont familyNames];
        
        for(NSString *familyName in familyNames ) {
            NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
            for( NSString *fontName in fontNames ) {
                [temp addObject:fontName];
            }
        }
        _data = [temp sortedArrayUsingSelector:@selector(compare:)]; // 排序
    }
    
    return _data;
}


#pragma mark - ♻️ 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger randomNum = (arc4random() % 247) + 0; // 0-247
    
    [self setNavigationTitleWithIndexInData:randomNum];
    self.navigationController.navigationBar.translucent = NO;
    
    [self tableView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil]; // 返回按钮
    self.navigationItem.backBarButtonItem = item;
    
}

// 设置导航栏字体方法
-(void)setNavigationTitleWithIndexInData:(NSInteger)index {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width*2/3, 44)];
    [label setText:@"iOS系统字体大全By_SL"];
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    label.font = [UIFont fontWithName:self.data[index] size:18.0f];
    self.navigationItem.titleView = label;
}



#pragma mark - 创建tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static  NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:ID];
    }
    
    cell.textLabel.text  = self.data[indexPath.row];
    cell.textLabel.font  = [UIFont fontWithName:_data[indexPath.row] size:18.0f];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"当前点击的字体是:   %@",self.data[indexPath.row]);
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    
    detailVC.font = self.data[indexPath.row];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}


//允许 Menu菜单
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

//每次长按cell都会点击出现Menu菜单
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    
    if (action == @selector(copy:)) {
        
        [UIPasteboard generalPasteboard].string = [self.data objectAtIndex:indexPath.row];
        NSLog(@"已复制字体:   %@",self.data[indexPath.row]);
    }
}

// tableView分割线左边界空格
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat {
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
@end
