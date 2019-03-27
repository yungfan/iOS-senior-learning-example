//
//  Weather.m
//  网络案例1-天气预报
//
//  Created by student on 2019/3/22.
//  Copyright © 2019 abc. All rights reserved.
//

#import "Weather.h"

@implementation Weather

-(instancetype)initWithDictionary:(NSDictionary *)dic {
    
    if (self = [super init]) {
    
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}


//属性与字典不匹配时进行改正，不改的话不会崩溃但拿不到值
- (void)setValue:(id)value forKey:(NSString *)key{
    //在这里更改key
    if([key isEqualToString:@"date"]){
        
        key = @"date_y";
    }
    
    [super setValue:value forKey:key];
}


//冗错处理，如果有未定义的字段的话就会走到这里，不重写的话会引起崩溃
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    NSLog(@"value:%@,undefineKey:%@",value,key);
}


//网络部分从C移动到M
-(void)getWeather:(void (^)(NSArray *))callback{
   
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
            
            NSMutableArray<Weather *> * weathers = [NSMutableArray arrayWithCapacity:7];
            
            for(int i = 0; i < future.count; i++){
                
                NSDictionary *wd = future[i];
                
                Weather *w = [self initWithDictionary:wd];
                
                [weathers addObject: w];
                
            }
            
            //网络放到Model以后，必须能和Controller通信，可以用代理、Block和通知，这里用Block
            callback(weathers);
    
        }

    }];
    
    //5.开启任务
    [task resume];
}

@end
