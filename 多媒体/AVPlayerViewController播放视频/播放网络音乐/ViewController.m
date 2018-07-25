//
//  ViewController.m
//  播放网络音乐
//
//  Created by teacher on 17/5/10.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//  总结：AVPlayer +  AVPlayerViewController

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>


@interface ViewController ()

//位于<AVKit/AVKit.h>
@property(nonatomic, strong) AVPlayerViewController *playerVC;
//位于<AVFoundation/AVFoundation.h>
@property(nonatomic, strong) AVPlayer *player;

@property(nonatomic, strong) AVPlayerItem *item;


- (IBAction)play:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
}


- (IBAction)play:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/gear1/prog_index.m3u8"];
    
    self.item = [AVPlayerItem playerItemWithURL:url];
    
    //通过KVO来观察status属性的变化，来获得播放之前的错误信息
    [self.item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
    [self.item addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
    
    self.player =  [AVPlayer playerWithPlayerItem:self.item];
    
    // 仅仅需要做的是将创建好的AVPlayer赋值给AVPlayerViewController的player属性即可
    self.playerVC = [[AVPlayerViewController alloc]init];
    
    self.playerVC.player = self.player;
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.item];
    
    //控制器显示出来
    [self presentViewController:self.playerVC animated:YES completion:nil];
    
    [self.player play];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"status"]) {
        //取出status的新值
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey]intValue];
        switch (status) {
            case AVPlayerItemStatusFailed:
                NSLog(@"item 有误");
                break;
            case AVPlayerItemStatusReadyToPlay:
                NSLog(@"准好播放了");
                break;
            case AVPlayerItemStatusUnknown:
                NSLog(@"视频资源出现未知错误");
                break;
            default:
                break;
        }
    }
    
    else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
        CMTime duration = self.item.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        
        NSLog(@"当前缓冲了%.2f%%", timeInterval *100 / totalDuration);
    }
    
    
}

- (NSTimeInterval)availableDuration {
    
    NSArray *loadedTimeRanges = [[self.playerVC.player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}


/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
-(void)moviePlayDidEnd:(NSNotification *)notification{
    
    NSLog(@"播放完成");
}



-(void)dealloc{
    //移除所有通知监控
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //移除监听（观察者）
    [self.item removeObserver:self forKeyPath:@"status"];
    [self.item removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

@end
