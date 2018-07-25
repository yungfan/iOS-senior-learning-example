//
//  ViewController.m
//  MPMoviePlayerViewController播放视频
//
//  Created by student on 2018/5/30.
//  Copyright © 2018年 student. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()

@property (nonatomic, strong) MPMoviePlayerViewController *moviePlayerVC;

- (IBAction)playVedio:(id)sender;

- (IBAction)restVedioPlayer:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

-(MPMoviePlayerViewController *)moviePlayerVC{

    if (!_moviePlayerVC) {
        
        //视频的网址
        NSURL *url = [NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/gear1/prog_index.m3u8"];
        
        _moviePlayerVC = [[MPMoviePlayerViewController alloc]initWithContentURL:url];
        
        //添加通知监听
        [self addNotification];
    }
    
    return _moviePlayerVC;

}

- (IBAction)playVedio:(id)sender {
    
    [self presentViewController:self.moviePlayerVC animated:YES completion:nil];
}

/**
 * 由于MPMoviePlayerViewController的初始化方法做了大量工作（例如设置URL、自动播放、添加点击Done完成的监控等）
 * 所以当再次点击播放弹出新的模态窗口的时如果不销毁之前的MPMoviePlayerViewController，那么新的对象就无法完成初始化，这样也就不能再次进行播放。
 */
- (IBAction)restVedioPlayer:(id)sender {
    
    self.moviePlayerVC = nil;
    
}


/**
 *  添加通知监控媒体播放控制器状态
 */
-(void)addNotification{
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayerVC.moviePlayer];
    
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayerVC.moviePlayer];
    
}


/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    
    switch (self.moviePlayerVC.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",self.moviePlayerVC.moviePlayer.playbackState);
            break;
    }
}

/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    
    NSLog(@"播放完成.%li",self.moviePlayerVC.moviePlayer.playbackState);
}


/**
 *
 * 一旦当前的VC有了通知的监听，一定要在delloc方法中 移除监听 否则会造成内存泄漏和崩溃
 *
 */
-(void)dealloc{

    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter removeObserver:self];

}

@end
