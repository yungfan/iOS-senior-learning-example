//
//  ViewController.m
//  AVAudioPlayer播放本地音乐
//
//  Created by student on 2018/5/21.
//  Copyright © 2018年 student. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

- (IBAction)play:(id)sender;

- (IBAction)pause:(id)sender;

@property(nonatomic, strong) AVAudioPlayer *player;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //音乐后台播放 1、打开后台  2、加入以下代码
    
    //在iOS中每个应用都有一个音频会话，这个会话就通过AVAudioSession来表示。AVAudioSession同样存在于AVFoundation框架中，它是单例模式设计，通过sharedInstance进行访问。
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    
    //设置后台播放模式
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    //设置完音频会话类型之后需要调用setActive::方法将会话激活才能起作用
    [audioSession setActive:YES error:nil];
    
    
    self.player = [self getAudioPlayer];
    
    
    //注意：AVAudioPlayer支持播放网络音乐 但是不能一边缓冲一边播放 需要缓冲好（下载到本地）才能播放

}


-(AVAudioPlayer *) getAudioPlayer{
    
    
//    1.初始化AVAudioPlayer对象，此时通常指定本地文件路径。
//    2.设置播放器属性，例如重复次数、音量大小等。
//    3.调用play方法播放。
    

    NSError *error;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ddz.mp3" ofType:nil];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    
    player.numberOfLoops = 1;
    
    [player prepareToPlay];
    
    if (error) {
        
        NSLog(@"%@", error);
        
        NSLog(@"初始化失败");
        
        return nil;
    }
    
    
    return player;


}

- (IBAction)play:(id)sender {
    
    [self.player play];
    
}

- (IBAction)pause:(id)sender {
    
    [self.player pause];
}
@end
