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
#import "AFNetworking/AFNetworking.h"
#import "MJRefresh/MJRefresh.h"

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
    
    /**系统自带的下拉刷新
     UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
     
     [refresh addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
     
     refresh.attributedTitle =  [[NSAttributedString alloc]initWithString:@"正在加载"];
     
     self.weatherTableView.refreshControl = refresh;*/
    
    
    //MJRefresh
    //    self.weatherTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //
    //
    //
    //    }];
    
    
    MJRefreshNormalHeader *header =  [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    // Set title
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"可以松手" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    
    // Set font
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // Set textColor
    header.stateLabel.textColor = [UIColor redColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    
    self.weatherTableView.mj_header = header;
    
    
    
    [self weather];
}

-(void)refreshData{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self weather];
        
        [self.weatherTableView.mj_header endRefreshing];
        
    });
    
    
    //系统自带的下拉刷新结束
    //    if (self.weatherTableView.refreshControl.isRefreshing) {
    //
    //        [self.weatherTableView.refreshControl endRefreshing];
    //
    //    }
    
}


-(void)weather{
    
    
    //创建管理者
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //创建网络请求
    NSString *net = @"http://v.juhe.cn/weather/index?format=2&cityname=芜湖&key=2d2e6e836dbdffac56814bc4d449d507";
    
    net = [net stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *URL = [NSURL URLWithString:net];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    //创建任务
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            
            NSLog(@"Error: %@", error);
            
        } else {
            
            //需要转换成NSHTTPURLResponse
            NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
            
            NSLog(@"%ld", (long)res.statusCode);
            
            NSLog(@"%@ %@", response, responseObject);
            
            
            //取未来7天天气
            NSArray *future = responseObject[@"result"][@"future"];
            
            for(int i = 0; i < future.count; i++){
                
                NSDictionary *wd = future[i];
                
                Weather *w = [[Weather alloc]initWithDictionary:wd];
                
                [self.weathers addObject:w];
                
            }
            
            //刷新界面
            [self.weatherTableView reloadData];
            
            [self.indicator stopAnimating];
        }
        
    }];
    
    //启动任务
    [dataTask resume];
    
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
