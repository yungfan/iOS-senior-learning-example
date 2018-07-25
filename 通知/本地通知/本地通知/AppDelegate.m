//
//  AppDelegate.m
//  本地通知
//
//  Created by student on 2018/6/13.
//  Copyright © 2018年 student. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        // iOS8以后 本地通知必须注册(获取权限)
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        
        [application registerUserNotificationSettings:settings];
    }
    
    
    //3.如果程序被杀死了，如何唤醒并跳转
    
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) { // 如果这个key有值,代表是杀死的程序接收到本地通知跳转
        
        // 根据这种方式查看launchOptions的内容
        UILabel *infoLabel = [[UILabel alloc] init];
        infoLabel.frame = CGRectMake(0, 0, 300, 200);
        infoLabel.backgroundColor = [UIColor yellowColor];
        infoLabel.numberOfLines = 0;
        infoLabel.font = [UIFont systemFontOfSize:10];
        infoLabel.text = [NSString stringWithFormat:@"%@",launchOptions];
        [self.window.rootViewController.view addSubview:infoLabel];
        
        
        NSLog(@"跳转到指定页面");
    }

    
    
    return YES;
}

//1.如果当前程序正在前台运行，直接回调该方法，不会有通知悬浮窗产生
//2.如果程序在后台，会有通知悬浮窗，当点击通知起泡的时候会调用该方法
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{


    NSLog(@"%@", notification.alertTitle);
    
    
    if (application.applicationState == UIApplicationStateInactive) {
        
        UILabel *infoLabel = [[UILabel alloc] init];
        infoLabel.frame = CGRectMake(0, 300, 200, 30);
        infoLabel.backgroundColor = [UIColor yellowColor];
        infoLabel.text = [NSString stringWithFormat:@"%@",notification.alertBody];
        
        [self.window.rootViewController.view addSubview:infoLabel];
        
    }
    
    else{
    
        UILabel *infoLabel = [[UILabel alloc] init];
        infoLabel.frame = CGRectMake(0, 200, 100, 30);
        infoLabel.backgroundColor = [UIColor yellowColor];
        infoLabel.text = [NSString stringWithFormat:@"%@",notification.alertTitle];
        
        [self.window.rootViewController.view addSubview:infoLabel];
    
    }
    
    



}

@end
