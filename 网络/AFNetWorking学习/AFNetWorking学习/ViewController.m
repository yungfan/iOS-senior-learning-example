//
//  ViewController.m
//  AFNetWorking学习
//
//  Created by teacher on 17/3/15.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //[self doGetRequest];
    
    //[self downloadRequest];
    
    //[self uploadRequest];
    
    [self checkNetwork];
}


#pragma mark - get post请求
-(void)doGetRequest{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager GET:@"http://120.25.226.186:32812/login?username=520it&pwd=520it&type=JSON" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];


}


#pragma mark - 下载数据
-(void)downloadRequest{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"%f", 1.0 *  downloadProgress.completedUnitCount/ downloadProgress.totalUnitCount);
        
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        // targetPath临时路径,fullPath存储路径
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        
        NSURL *fileURL = [NSURL fileURLWithPath:fullPath];
        
        return fileURL;
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        NSLog(@"下载成功");
        
    }];

    
    [task resume];


}


#pragma mark - 上传数据
-(void)uploadRequest{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:@"http://120.25.226.186:32812/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        UIImage *img = [UIImage imageNamed:@"img"];
        
        NSData *data =  UIImagePNGRepresentation(img);
        
        [formData appendPartWithFileData:data name:@"file"
                                fileName:@"借用服务器一用.png" mimeType:@"application/octet-stream"];
        
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"%f", 1.0 *  uploadProgress.completedUnitCount/ uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSLog(@"成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"失败");
    }];




}

#pragma mark - 检测网络的状态
-(void)checkNetwork{
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];


    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
              
            case AFNetworkReachabilityStatusUnknown:
                
                NSLog(@"不明网络");
                
                break;
            case AFNetworkReachabilityStatusNotReachable:
                
                NSLog(@"无网络");
                
                break;

            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                NSLog(@"蜂窝数据");
                
                break;

            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                NSLog(@"WiFi");
                
                break;

                
            default:
                
                NSLog(@"default");
                break;
        }
        
        
        
    }];
    
    [manager startMonitoring];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
