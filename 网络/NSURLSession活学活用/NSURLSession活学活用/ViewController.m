//
//  ViewController.m
//  NSURLSession活学活用
//
//  Created by teacher on 17/3/1.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1、创建一个请求  63.223.108.42
    // http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=json&ip=218.4.255.255
    
    
    //处理中文
    NSString *str = @"http://gc.ditu.aliyun.com/geocoding?a=芜湖";
    
    str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:str];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    
    //2、发送一个请求
       //（1）创建一个NSURLSession
    
    NSURLSession *session = [NSURLSession sharedSession];
       //（2）创建一个NSURLSessionDataTask
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
//        
//      NSDictionary *dic =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        
//        NSLog(@"%@", dic[@"data"][@"country"]);
        
    }];
    
      // (3)执行task
    [dataTask resume];
    
    //3、获取服务器返回的数据
    
    
    //4、处理服务器返回的数据
    
    
    //5、将处理好的数据填充到UI
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
