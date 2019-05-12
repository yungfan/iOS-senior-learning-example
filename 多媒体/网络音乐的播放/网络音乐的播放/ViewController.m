//
//  ViewController.m
//  网络音乐的播放
//
//  Created by student on 2018/5/23.
//  Copyright © 2018年 student. All rights reserved.
//  http://up.mcyt.net/?down/46973.mp3

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

- (IBAction)play:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)switchs:(id)sender;


- (IBAction)privious:(id)sender;
- (IBAction)next:(id)sender;

@property(nonatomic, strong) AVPlayer *player;
@property(nonatomic, assign) NSInteger index;
@property(nonatomic, strong) NSArray *music;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.music = @[
                   
                   @"http://www.ytmp3.cn/down/73111.mp3",
                   @"http://www.ytmp3.cn/down/73072.mp3",
                   @"http://win.web.nf01.sycdn.kuwo.cn/8f0f74aa723cd6788d53553cdd252c86/5cd2f0cd/resource/n1/49/87/2328810103.mp3",
                   @"http://www.ytmp3.cn/down/73053.mp3"
                   
                   ];
    
    self.index = 0;
    
}


- (IBAction)play:(id)sender {
    
    NSURL *url = [NSURL URLWithString:self.music[self.index]];
    //  这种方式能播放 但不适用于切歌
    //    AVPlayer *player = [[AVPlayer alloc]initWithURL:url];
    
    //  如果需要切歌 使用如下的方式播放
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:url];
    
    AVPlayer *player = [[AVPlayer alloc]initWithPlayerItem:item];

    self.player = player;
    
    [self.player play];
    
    //打印播放时长与总时长
    [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        //准备播放的时候开始打印
        if (self.player.status == AVPlayerStatusReadyToPlay && self.player.currentItem.duration.timescale != 0) {
            
            
            //CMTime value/timescale 得到秒
            NSLog(@"%当前播放：lld -- 总时长：%lld", self.player.currentTime.value/self.player.currentTime.timescale, self.player.currentItem.duration.value/self.player.currentItem.duration.timescale) ;
        }
        
        
    }];
}

- (IBAction)pause:(id)sender {
    
    [self.player pause];
}

- (IBAction)switchs:(id)sender {
    
    NSURL *url = [NSURL URLWithString: self.music[1]];
    //  如果需要切歌 使用如下的方式播放
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:url];
    
    [self.player replaceCurrentItemWithPlayerItem:item];

}

//上一首 注意数组边界问题
- (IBAction)privious:(id)sender {
    
    self.index -= 1;
    
    if (self.index  == -1) {
        
        self.index = self.music.count - 1;
    }
    
    NSURL *url = [NSURL URLWithString: self.music[self.index]];
    //  如果需要切歌 使用如下的方式播放
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:url];
    
    [self.player replaceCurrentItemWithPlayerItem:item];
}



//下一首 注意数组边界问题
- (IBAction)next:(id)sender {
    
    self.index += 1;
    
    if (self.index  == self.music.count) {
        
        self.index = 0;
    }
    
    NSURL *url = [NSURL URLWithString: self.music[self.index]];
    //  如果需要切歌 使用如下的方式播放
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:url];
    
    [self.player replaceCurrentItemWithPlayerItem:item];
    
}
@end
