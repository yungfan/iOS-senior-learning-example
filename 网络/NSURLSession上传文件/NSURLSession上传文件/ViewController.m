//
//  ViewController.m
//  NSURLSession上传文件
//
//  Created by teacher on 17/3/10.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<NSURLSessionTaskDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
  
    NSURL *url = [NSURL URLWithString:@"http://172.20.53.250:8080/AppTestAPI/UploadServlet"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    NSString *httpHead = [NSString stringWithFormat:@"multipart/form-data;boundary=----WebKitFormBoundaryUFNaH6losNxu4xDq"];
    
    //设置请求的头 告诉服务器我要上传数据
    [request setValue:httpHead forHTTPHeaderField:@"Content-Type"];
    
    request.HTTPMethod = @"POST";
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    

    //fromData：就是要上传的数据
    NSURLSessionUploadTask *task =  [session uploadTaskWithRequest:request fromData:[self getData] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"%@", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        
    }];
    
    
    [task resume];
    
}

-(NSData *)getData
{
    /******************************************************************/
    //                          设置请求体
    // 设置请求体
    // 给请求体加入固定格式数据  这里也是使用的也是可变的，因为多嘛
    NSMutableData *data = [NSMutableData data];

    //                       开始标记
    // boundary
    [data appendData:[@"------WebKitFormBoundaryUFNaH6losNxu4xDq" dataUsingEncoding:NSUTF8StringEncoding]];
    // \r\n换行符
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    // Content-Disposition: form-data; name="myfile"; filename="wall.jpg"
    [data appendData:[@"Content-Disposition: form-data; name=\"myfile\"; filename=\"123.jpg\"" dataUsingEncoding:NSUTF8StringEncoding]];
    // \r\n换行符
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    // Content-Type 上传文件的MIME
    [data appendData:[@"Content-Type: image/jpeg" dataUsingEncoding:NSUTF8StringEncoding]];
    // 两个换行符
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    
    
    //                      上传文件参数
    //图片数据  并且转换为Data
    UIImage *image = [UIImage imageNamed:@"wall.jpg"];
    NSData *imagedata = UIImageJPEGRepresentation(image, 1.0);
    [data appendData:imagedata];
    
    //如果是PNG图片需要修改上面几个地方 数据格式如下
//    UIImage *image2 = [UIImage imageNamed:@"wall2"];
//    NSData *imagedata2 = UIImagePNGRepresentation(image2);
//    [data appendData:imagedata2];
//    
    
    //如果上传的是zip压缩包
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"wall.zip" ofType:nil];
    //[data appendData:[NSData dataWithContentsOfFile:path]];
    
    
    // 两个换行符
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
   
    
    
    //                      添加结束标记
    
    // \r\n换行符
    [data appendData:[@"------WebKitFormBoundaryUFNaH6losNxu4xDq--" dataUsingEncoding:NSUTF8StringEncoding]];
    // boundary
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
   
    
    return data;
    
}

/*
 只要给服务器上传数据就会调用 (一次或多次)
 bytesSent: 当前这一次发送的数据长度
 totalBytesSent: 总共已经发送的数据长度
 totalBytesExpectedToSend: 需要上传的文件的总大小
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    NSLog(@"%lld", 100 * totalBytesSent / totalBytesExpectedToSend);
}

/*
 判断是否上传成功，如果失败error是具有值
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    NSLog(@"%s, %@", __func__, error);
}


@end
