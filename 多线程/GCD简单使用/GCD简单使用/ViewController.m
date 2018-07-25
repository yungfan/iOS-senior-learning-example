//
//  ViewController.m
//  GCD简单使用
//
//  Created by teacher on 17/3/24.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//  子线程下载 主线程更新

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //异步执行我们的任务
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
        //block中写具体的线程执行的耗时任务
        
        
        //获取一个主队列
        dispatch_async(dispatch_get_main_queue(), ^{
            //block中的执行的任务就是在主线程中,更新UI
            
            
        });
        
    });
    
    
    
}

-(void)gcd{


    //创建一个并发队列
    dispatch_queue_t t =  dispatch_get_global_queue(0,0);
    
    //异步执行我们的任务
    dispatch_async(t, ^{
        
        //block中写具体的任务
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL *url = [NSURL URLWithString:@"http://b.hiphotos.baidu.com/zhidao/pic/item/aa64034f78f0f73626d315d90855b319ebc4133c.jpg"];
        NSURLSessionDownloadTask *downloadTask =  [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            // 1.拼接文件全路径
            NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"img.jpg"];
            // 2.剪切文件
            [[NSFileManager defaultManager]moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
            
            
            //获取一个主队列
            dispatch_queue_t mainT = dispatch_get_main_queue();
            dispatch_async(mainT, ^{
                //block中的执行的任务就是在主线程中
                
                self.imgView.image = [UIImage imageWithContentsOfFile:fullPath];
                
            });
            
        }];
        
        [downloadTask resume];
        
        
    });
    



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
