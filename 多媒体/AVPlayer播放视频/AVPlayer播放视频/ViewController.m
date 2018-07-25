//
//  ViewController.m
//  AVPlayer播放视频
//
//  Created by student on 2018/6/1.
//  Copyright © 2018年 student. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) AVPlayerItem *playItem;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    //通过AVPlayer构造一个层
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    //设置层的位置与大小
    layer.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height *9 / 16);
    
    //添加到当前的View的Layer中去
    [self.view.layer addSublayer:layer];
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{


    [self.player play];
    
}


-(AVPlayerItem *)playItem{
    
    //视频的网址
    NSURL *url = [NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/gear1/prog_index.m3u8"];

    
    if (!_playItem) {
        
        _playItem = [[AVPlayerItem alloc]initWithURL:url];
        
    }

    return _playItem;

}

-(AVPlayer *)player{

    if (!_player) {
        
        _player = [[AVPlayer alloc]initWithPlayerItem:self.playItem];
        
    }
    
    return _player;

}



@end
