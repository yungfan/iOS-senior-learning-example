//
//  ViewController.m
//  网络与多线程
//
//  Created by student on 2018/4/13.
//  Copyright © 2018年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *downloadImg;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //开启一个子线程去下载一张图片
    NSThread *download = [[NSThread alloc]initWithTarget:self selector:@selector(download) object:nil];
    
    [download start];
    
    //调用指定线程中的某个方法。
    [self performSelector:@selector(test) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];
    
}

-(void)download{
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1523589911677&di=42fbadd444e8c653926100352ad94081&imgtype=0&src=http%3A%2F%2Fwww.soomal.com%2Fimages%2Fdoc%2F20141105%2F00047194_01.jpg"];
    
    NSURLSessionDownloadTask *downloadTask =  [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        // 1.拼接文件全路径
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"img.jpg"];
        
        // 2.剪切文件
        [[NSFileManager defaultManager]moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
        
        
        // 3.在主线程中更新UI
        [self performSelectorOnMainThread:@selector(updateUI:) withObject:fullPath waitUntilDone:YES];
        
    }];
    
    
    [downloadTask resume];
}

-(void)test{
    
    
    NSLog(@"%s", __func__);
}


-(void)updateUI:(NSString*)fullPath{
    
    //下载完成以后 将该图片显示到界面的UIImageView中去
    self.downloadImg.image = [UIImage imageWithContentsOfFile:fullPath];
    
    
}

@end
