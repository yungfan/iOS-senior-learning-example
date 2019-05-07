//
//  ViewController.m
//  音效案例-五线谱
//
//  Created by student on 2019/5/7.
//  Copyright © 2019 student. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

- (IBAction)tapClick:(UITapGestureRecognizer *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)play:(NSString *)name{
    
    // 加载音效
    SystemSoundID soundID;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"wav"];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
    
    // 播放音效
    AudioServicesPlaySystemSound(soundID);
    
}

- (IBAction)tapClick:(UITapGestureRecognizer *)sender {
    
    UIView *view = sender.view;
    
    switch (view.tag) {
        case 1:
            
            [self play:@"do1"];
            
            break;
            
        case 2:
            
            [self play:@"re2"];
            
            break;
            
        case 3:
            
            [self play:@"mi3"];
            
            break;
            
        case 4:
            
             [self play:@"fa4"];
            break;
            
        case 5:
            
             [self play:@"sol5"];
            break;
            
        case 6:
            
             [self play:@"la6"];
            break;
            
        case 7:
            
             [self play:@"si7"];
            break;
            
        default:
            break;
    }
}
@end
