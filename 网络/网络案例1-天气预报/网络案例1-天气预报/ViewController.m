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

@property (nonatomic, strong) NSMutableArray<Weather *> * weathers;
@property (weak, nonatomic) IBOutlet UITableView *weatherTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation ViewController

-(NSMutableArray<Weather *> *)weathers{
    
    if (_weathers == nil) {
        
        _weathers = [NSMutableArray arrayWithCapacity:7];
    }
    
    return _weathers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.weatherTableView.rowHeight = 100.0;
    
    self.weatherTableView.tableFooterView = [[UIView alloc]init];
    
    [self weather];
}


-(void)weather{
    
    //1.创建一个url
    NSString *net = @"http://v.juhe.cn/weather/index?format=2&cityname=芜湖&key=2d2e6e836dbdffac56814bc4d449d507";

    //带中文的url进行转换
    net = [net stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:net];
    
    //2.创建一个网络请求（url）
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    //request.HTTPMethod = @"POST";
    
    //3.创建网络管理
    NSURLSession *session = [NSURLSession sharedSession];
    
    //4.创建一个网络任务
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            
            NSLog(@"有错误");
            
        }
        
        else {
            
            //需要转换成NSHTTPURLResponse
            NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
            
            NSLog(@"%ld", (long)res.statusCode);
            
            //JSON（字典）转模型
            NSDictionary *dic =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //取未来7天天气
            NSArray *future = dic[@"result"][@"future"];
            
            
            for(int i = 0; i < future.count; i++){
                
                NSDictionary *wd = future[i];
                
                Weather *w = [[Weather alloc]init];
                
                w.temperature = wd[@"temperature"];
                w.weather = wd[@"weather"];
                w.wind = wd[@"wind"];
                w.week = wd[@"week"];
                w.date_y = wd[@"date"];
                
                [self.weathers addObject:w];
                
            }
            
            NSLog(@"%ld", self.weathers.count);

            //默认网络请求在自线程 更新界面要回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [NSThread  sleepForTimeInterval:2.0];
                
                //刷新界面
                [self.weatherTableView reloadData];
                
                [self.indicator stopAnimating];
                
            });
    
        }
        
    }];
    
    //5.开启任务
    [task resume];
    
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
