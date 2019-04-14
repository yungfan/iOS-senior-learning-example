//
//  ViewController.m
//  NSURLSession文件下载
//
//  Created by teacher on 19/3/28.
//  Copyright © 2018年 安徽商贸职业技术学院. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLSessionDownloadDelegate>

@property (weak, nonatomic) IBOutlet UIProgressView *downloadProgress;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 1.确定URL
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/AppTestAPI/wall.png"];
    
    // 2.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 3.创建会话对象
    //NSURLSession *session = [NSURLSession sharedSession];
    
    // Configuration:配置信息,用默认的即可
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request];
    
    [downloadTask resume];// 执行Task
}


/**
 1.写数据(监听下载进度)
 session 会话对象
 downloadTask 下载任务
 bytesWritten 本次写入的数据大小
 totalBytesWritten 下载的数据总大小
 totalBytesExpectedToWrite 文件的总大小
 */
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{


    
    self.downloadProgress.progress = 1.0 * totalBytesWritten / totalBytesExpectedToWrite;
   

}


/**
 3.当下载完成的时候调用
 location 文件的临时存储路径
 */
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{

    // 1.拼接文件全路径
    // downloadTask.response.suggestedFilename 文件名称
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    // 2.剪切文件
    [[NSFileManager defaultManager]moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
   
    
    NSLog(@"%@",fullPath);
}

@end
