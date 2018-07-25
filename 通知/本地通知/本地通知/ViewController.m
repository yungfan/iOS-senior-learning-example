//
//  ViewController.m
//  本地通知
//
//  Created by student on 2018/6/13.
//  Copyright © 2018年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    //创建本地通知
    UILocalNotification *localNotification = [[UILocalNotification alloc]init];
    
    //触发事件
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:3.0];
    
    //通知的内容
    localNotification.alertBody = @"这是一个本地通知";
    
    //通知的标题
    localNotification.alertTitle = @"温馨提示";
    
    //通知的锁屏内容
    localNotification.alertAction = @"你有一个新通知";

    //通知的声音
    localNotification.soundName = @"feiji.wav";
    
    //角标
    localNotification.applicationIconBadgeNumber = 1;

    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

}

@end
