//
//  ViewController.m
//  SystemSoundID播放音效
//
//  Created by student on 2018/5/21.
//  Copyright © 2018年 student. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

-(SystemSoundID)getSystemSoundID{
    
    // 加载音效
    SystemSoundID soundID;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"wangzha.mp3" ofType:nil];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
    
    return soundID;


}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
    
    // 播放音效
    AudioServicesPlaySystemSound([self getSystemSoundID]);



}


@end
