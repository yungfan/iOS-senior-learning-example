//
//  ViewController.m
//  新闻
//
//  Created by teacher on 17/3/2.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//  网络＋多线程 案例

#import "ViewController.h"
#import "NewsCell.h"
#import "News.h"
#import "DetailsNewsViewController.h"


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

/**
 *  数据源
 */
@property(nonatomic, strong) NSMutableArray *dataSource;
/**
 *  表格
 */
@property (weak, nonatomic) IBOutlet UITableView *newsTableView;
/**
 *  指示器
 */
@property (weak, nonatomic) UIActivityIndicatorView *indicatorView;

@end

@implementation ViewController

/**
 *  懒加载数据
 *
 *  @return 新闻数据源
 */
-(NSMutableArray *)dataSource{
    
    if (_dataSource == nil) {
        
        _dataSource = [NSMutableArray array];
        
        [self getData];
        
    }
    
    return _dataSource;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    self.navigationItem.titleView = indicator;
    
    [indicator startAnimating];
    
    self.indicatorView = indicator;
    
    
}


-(void)getData{
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *reqUrl = [NSURL URLWithString:@"https://testjrwh.wuhunews.cn/server/e/news/newslist?type=1&category=0"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:reqUrl];

    
    NSURLSessionDataTask *dataTask =  [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //获取新闻列表
        NSArray *array = dic[@"list"];
        
        //数组转模型
        for (int i = 0; i < array.count; i++) {
            
            
            //Mantle MJExtension YYModel
            NSDictionary *dic = array[i];
            News *news = [[News alloc]init];
            news.title = dic[@"title"];
            news.cover = dic[@"cover"];
            news.url = dic[@"url"];
            
            [_dataSource addObject:news];
            
            
        }
        
        //获取一个主队列
        dispatch_async(dispatch_get_main_queue(), ^{
            //block中的执行的任务就是在主线程中,更新UI
            
            [NSThread sleepForTimeInterval:2.0];
            //刷新表格
            [self.newsTableView reloadData];
            
            [self.indicatorView stopAnimating];
            
            self.navigationItem.titleView = nil;
            
            self.navigationItem.title = @"新闻列表";
        });
        
    }];
    
    [dataTask resume];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newCell"];
    
    return cell;
    
}

//为了提高效率cellForRowAtIndexPath 只创建cell并返回 模型在下面的方法中赋值
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{



    News *news = [self.dataSource objectAtIndex:indexPath.row];
    
    NewsCell *newsCell = (NewsCell *)cell;
    
    //根据服务器返回的数据填充cell，标题、摘要、图片
    newsCell.news = news;


}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    News *news = [self.dataSource objectAtIndex:indexPath.row];
    
    DetailsNewsViewController *dnc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"details"];;
    
    //跳转时赋值url
    dnc.url = news.url;
    
    [self.navigationController pushViewController:dnc animated:YES];
    
}

-(void)dealloc{
    
    NSLog(@"%s", __func__);
    
}

@end
