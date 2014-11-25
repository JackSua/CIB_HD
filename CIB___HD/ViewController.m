//
//  ViewController.m
//  CIB___HD
//
//  Created by iOS Dev on 14-11-25.
//  Copyright (c) 2014年 iOS Dev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // TODO:根据服务端返回
    if (tableView == self.firstMenuTableView) {
        return 4;
    }else if (tableView == self.secondMenuTableView){
        return 7;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =nil;
    if (tableView == self.firstMenuTableView) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"firstMenuCell"];
        UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
        backView.backgroundColor = [UIColor colorWithRed:233/255.0 green:254/255.0 blue:250/255.0 alpha:1.0];
        cell.selectedBackgroundView = backView;
        
    }else if (tableView == self.secondMenuTableView){
        cell = [tableView dequeueReusableCellWithIdentifier:@"secondMenuCell"];
    }
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (tableView == self.firstMenuTableView) {
        if (indexPath.row == 0) {
            [self shrinkFirstMenu];
        }
        
    }else if (tableView == self.secondMenuTableView){
        
    }
}

// 缩小第一级菜单
- (void)shrinkFirstMenu
{
    [UIView animateWithDuration:0.8 animations:^{
        [self.firstMenuTableView setFrame:CGRectMake(0, 69, 55, 654)];
        [self.firstMenuTableView setRowHeight:55];
    }];
}

// 放大第一级菜单
- (void)enlargeFirstMenu
{
    [UIView animateWithDuration:0.8 animations:^{
        [self.firstMenuTableView setFrame:CGRectMake(0, 69, 191, 654)];
        [self.firstMenuTableView setRowHeight:164];
    }];
}

@end
