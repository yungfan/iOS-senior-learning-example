//
//  ViewController.m
//  网络的基本使用
//
//  Created by student on 2019/3/19.
//  Copyright © 2019 abc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bdImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = UIColor.redColor;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self network];
}

-(void)network{
    
    //1.创建一个url
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/img/bd_logo1.png"];
    
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
            
            //默认网络请求在自线程 更新界面要回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.bdImage.image = [UIImage imageWithData:data];
                
                
            });
            
            
        }
        
    }];
    
    //5.开启任务
    [task resume];
    
}


@end
