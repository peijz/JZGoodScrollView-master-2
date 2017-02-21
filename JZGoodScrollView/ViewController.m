//
//  ViewController.m
//  JZGoodScrollView
//
//  Created by wanhongios on 17/1/9.
//  Copyright © 2017年 wanhongios. All rights reserved.
//

#import "ViewController.h"
#import "JZGoodScrollView.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController{
    NSArray <NSURL *> *_urls;
    UITableView * _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载数据
    [self loadData];
    
    
    [self setupTableView];
    
    [self setupScrollView];
    
   
}

// 设置tableview
-(void)setupTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

// 设置scrollView
-(void)setupScrollView{
    if (_urls.count>0)
    {
        UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
        JZGoodScrollView * scrollView = [[JZGoodScrollView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 300) urls:_urls placeHolderImage:[UIImage imageNamed:@"seefarmseatpic.png"]];
        scrollView.autoScroll = YES;
        [scrollView goodScrollViewDidSelectedBlock:^(NSInteger index) {
            
            NSLog(@"点击了第%ld张",index);
        }];
        
        [scrollView goodScrollViewStopBlock:^(NSInteger index) {
            //            NSLog(@"停留在第%ld张图片",index);
        }];
        [headerView addSubview:scrollView];
        _tableView.tableHeaderView = headerView;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"myCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%ld个cell",indexPath.row+1];
    return cell;
}



// 加载数据
-(void)loadData
{
    NSMutableArray * urlArr = [NSMutableArray array];
    
    for (int i = 0; i < 4; i++)
    {
        NSString * fileName = [NSString stringWithFormat:@"%02djz.jpg",i+1];
        NSURL * url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        [urlArr addObject:url];
    }
    
    _urls = urlArr.copy;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
