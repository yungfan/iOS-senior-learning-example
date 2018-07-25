//
//  ViewController.m
//  iOS 10 本地通知
//
//  Created by student on 2018/6/13.
//  Copyright © 2018年 student. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    //第一步：AppDelegate注册通知
    
    //第二步：新建通知内容对象
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"iOS10 通知";
    content.subtitle = @"学习iOS 10 通知笔记";
    content.body = @"这是一条测试通知";
    content.badge = @99;
    UNNotificationSound *sound = [UNNotificationSound soundNamed:@"feiji.wav"];
    content.sound = sound;
    
    //第三步：通知触发机制。（重复提醒，时间间隔要大于60s） 本地通知与远程通知的触发器不一样    
    UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    
    

    //添加交互
    // 文字action
    UNTextInputNotificationAction *action1 = [UNTextInputNotificationAction actionWithIdentifier:@"replyAction" title:@"文字回复" options:UNNotificationActionOptionNone];
    // 进入应用action
    UNNotificationAction *action2 = [UNNotificationAction actionWithIdentifier:@"enterAction" title:@"进入应用" options:UNNotificationActionOptionForeground];
    // 取消action
    UNNotificationAction *action3 = [UNNotificationAction actionWithIdentifier:@"cancelAction" title:@"取消" options:UNNotificationActionOptionDestructive];
    
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"Categroy" actions:@[action1, action2, action3] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObject:category]];
    
    content.categoryIdentifier = @"Categroy";
    
    
    
    //第四步：创建UNNotificationRequest通知请求对象
    NSString *requertIdentifier = @"RequestIdentifier";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requertIdentifier content:content trigger:trigger1];
    
    //第五步：将通知加到通知中心
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
        if (!error) {
            
            NSLog(@"发送成功");
        }
        
        
    }];
    
  
    
}


@end
