//
//  ViewController.m
//  网络案例1-天气预报
//
//  Created by student on 2019/3/21.
//  Copyright © 2019 abc. All rights reserved.
//  http://v.juhe.cn/weather/index?format=2&cityname=芜湖&key=2d2e6e836dbdffac56814bc4d449d507

#import "ViewController.h"
#import "Weather.h"
#import "WeatherCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray<Weather *> * weathers;
@property (weak, nonatomic) IBOutlet UITableView *weatherTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.weatherTableView.rowHeight = 100.0;
    
    self.weatherTableView.tableFooterView = [[UIView alloc]init];
    
    Weather *weather = [[Weather alloc]init];
    
    [weather getWeather:^(NSArray * data) {
        
        self.weathers = data;
        
        //默认网络请求在自线程 更新界面要回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [NSThread  sleepForTimeInterval:1.0];
            
            //刷新界面
            [self.weatherTableView reloadData];
            
            [self.indicator stopAnimating];
            
            
        });
    }];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    WeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weather"];
    
    cell.w = self.weathers[indexPath.row];
    
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return  self.weathers.count;
    
}

@end
