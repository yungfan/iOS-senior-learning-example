//
//  ViewController.m
//  AVAudioPlayer播放本地音乐
//
//  Created by student on 2019/5/9.
//  Copyright © 2019 student. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController () <AVAudioPlayerDelegate>

//定时器
@property (nonatomic, strong) NSTimer *timer;

//播放器
@property (nonatomic, strong) AVAudioPlayer *player;

- (IBAction)play:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)stop:(id)sender;
//拖动
- (IBAction)seek:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lbDuration;

@property (weak, nonatomic) IBOutlet UILabel *lbCurrrent;

@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //注意：AVAudioPlayer支持播放网络音乐 但是不能一边缓冲一边播放 需要缓冲好（下载到本地）才能播放
    
    //[self backgroundMode];
    
}

-(void)backgroundMode{
    
    //音乐后台播放 1、打开后台  2、加入以下代码
    //在iOS中每个应用都有一个音频会话，这个会话就通过AVAudioSession来表示。
    //AVAudioSession同样存在于AVFoundation框架中，它是单例模式设计，通过sharedInstance进行访问。
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    //设置后台播放模式
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    //设置完音频会话类型之后需要调用setActive::方法将会话激活才能起作用
    [audioSession setActive:YES error:nil];
    
}

-(AVAudioPlayer *)createAVAudioPlayer{
    
    //初始化AVAudioPlayer对象，此时通常指定本地文件路径
    NSError *error;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ddz.mp3" ofType:nil];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    
    //设置播放器属性，例如代理，重复次数、音量大小等
    player.delegate = self;
    
    //必须强引用
    self.player = player;
    
    //获取总时长
    int duration  = (int)player.duration;
    
    self.progressSlider.maximumValue = player.duration;
    
    //分钟
    NSLog(@"%d", duration / 60);
    
    //秒数
    NSLog(@"%d", duration % 60);
    
    self.lbDuration.text = [NSString stringWithFormat:@"%02d:%02d",duration / 60, duration % 60];
    
    if (error) {
        
        return nil;
        
    }
    
    else {
        
        return player;
        
    }
}

//代理
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    NSLog(@"音乐播放完毕");
    
    //取消定时器
    [self.timer invalidate];
    
    self.timer = nil;
    
}

//播放
- (IBAction)play:(id)sender {
    
    NSLog(@"%f", self.player.duration);
    
    if (self.player == nil) {
        
        self.player = [self createAVAudioPlayer];
        
    }
    
    //定时器 获取当前播放时长
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        int duration  = (int)self.player.currentTime;
        
        self.lbCurrrent.text = [NSString stringWithFormat:@"%02d:%02d",duration / 60, duration % 60];
        
        self.progressSlider.value = self.player.currentTime;
    }];
    
    
    [self.player prepareToPlay];
    
    [self.player play];
    
}


//暂停
- (IBAction)pause:(id)sender {
    
    if (self.player.playing) {
        
        [self.player pause];
        
    }
    
}


//停止-经测试再次播放不会从头开始 所以重置播放器
- (IBAction)stop:(id)sender {
    
    if (self.player.playing) {
        
        [self.player stop];
        
        self.player = nil;
        
    }
    
    
}


//快进快退
- (IBAction)seek:(id)sender {
    
    UISlider *slider = (UISlider *)sender;
    
    CGFloat currentValue = slider.value;
    
    self.player.currentTime = currentValue;
    
    [self.player play];
    
}
@end
