//
//  ViewController.m
//  MPMoviePlayerController播放视频
//
//  Created by teacher on 17/5/15.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;

@property(nonatomic, strong) MPMoviePlayerController *player;
@property(nonatomic, assign) UIDeviceOrientation orientation;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //横竖屏
    self.orientation = [UIDevice currentDevice].orientation;
    
    [self setUpPlayer];
   
}

-(void)setUpPlayer{

    NSURL *url = [NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/gear1/prog_index.m3u8"];
    
    self.player = [[MPMoviePlayerController alloc]initWithContentURL:url];
    
    //使用MPMoviePlayerController的时候需要注意：本身它不是一个视图，它里面有一个视图是用于播放视频的，需要添加到当前控制器的视图上 才能显示出来
    
    self.player.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
    
    [self.view addSubview:self.player.view];
    
    //发送通知
    [self postNotification];
    
    //获取缩略图
    [self thumbnailImageRequest];


}

/**
 *  MPMoviePlayerController获取视频缩略图
 */
-(void)thumbnailImageRequest{
    //获取10s的缩略图  必须是.0f 否则无法获取
    [self.player requestThumbnailImagesAtTimes:@[@10.f] timeOption:MPMovieTimeOptionExact];
}

//使用AVFoundation生成缩略图
-(void)thumbnailImageRequest2{
    NSURL *url = [NSURL URLWithString:@"http://v1.mukewang.com/19954d8f-e2c2-4c0a-b8c1-a4c826b5ca8b/L.mp4"];
    //根据url创建AVURLAsset
    AVURLAsset *urlAsset=[AVURLAsset assetWithURL:url];
    //根据AVURLAsset创建AVAssetImageGenerator
    AVAssetImageGenerator *imageGenerator=[AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    /*截图
     * requestTime:缩略图创建时间
     * actualTime:缩略图实际生成的时间
     */
    NSError *error=nil;
    CMTime time=CMTimeMakeWithSeconds(10, 10);//CMTime是表示电影时间信息的结构体，第一个参数表示是视频第几秒，第二个参数表示每秒帧数.(如果要活的某一秒的第几帧可以使用CMTimeMake方法)
    CMTime actualTime;
    CGImageRef cgImage= [imageGenerator copyCGImageAtTime:time actualTime:&actualTime error:&error];
    if(error){
        NSLog(@"截取视频缩略图时发生错误，错误信息：%@",error.localizedDescription);
        return;
    }
    CMTimeShow(actualTime);
    UIImage *image=[UIImage imageWithCGImage:cgImage];//转化为UIImage
    self.thumbnail.image = image;
}


-(void)postNotification{
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self selector:@selector(fullScreen:) name:MPMoviePlayerWillEnterFullscreenNotification object:self.player];
    
    [notificationCenter addObserver:self selector:@selector(exitFullScreen:) name:MPMoviePlayerWillExitFullscreenNotification object:self.player];
    
     [notificationCenter addObserver:self selector:@selector(getThumbnail:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:nil];
    
}

-(void)fullScreen:(MPMoviePlayerController *)player{
    
    NSLog(@"%s", __func__);
    
}

-(void)exitFullScreen:(MPMoviePlayerController *)player{
    
    NSLog(@"%s", __func__);
    
    [self.player requestThumbnailImagesAtTimes:@[@10] timeOption:MPMovieTimeOptionExact];
}

-(void)getThumbnail:(NSNotification *)notification{

    //获取视频的缩略图(没有捕获到图片)
    UIImage *image = notification.userInfo[MPMoviePlayerThumbnailImageKey];
    self.thumbnail.image = image;
    //原因通过打印查看
    NSLog(@"%@", notification);
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.player play];
    
}

-(void)dealloc{
    //移除所有通知监控
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
