//
//  AppDelegate.m
//  iOS 10 本地通知
//
//  Created by student on 2018/6/13.
//  Copyright © 2018年 student. All rights reserved.
//  iOS 10以后 Apple将本地与远程通知合二为一了 推出一个新的通知框架 头文件为 <UserNotifications/UserNotifications.h>

#import "AppDelegate.h"

#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    application.applicationIconBadgeNumber = 0;
    
    
    //第一步：AppDelegate注册通知
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    //请求获取通知权限（角标，声音，弹框）
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
        //如果用户点击允许通知，那么granted就为YES
        if (granted) {
            //获取用户是否同意开启通知
            NSLog(@"用户允许发送通知");
        }
        
    }];
   
    
    
    
    center.delegate = self;
    //如果程序被杀死了 会调用该方法
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) { // 如果这个key有值,代表是杀死的程序接收到本地通知跳转
        
        // 根据这种方式查看launchOptions的内容
        UILabel *infoLabel = [[UILabel alloc] init];
        infoLabel.frame = CGRectMake(0, 0, 300, 200);
        infoLabel.backgroundColor = [UIColor yellowColor];
        infoLabel.text = [NSString stringWithFormat:@"%@",launchOptions];
        [self.window.rootViewController.view addSubview:infoLabel];
        
        
        NSLog(@"跳转到指定页面");
    }


    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    application.applicationIconBadgeNumber = 0;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//接收到通知，如果处于后台，该方法不会调用
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    
    NSLog(@"%s 收到通知",__func__);

    UNNotificationContent *content = notification.request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    NSLog(@"iOS10 收到本地通知:{%s,\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@\\\\n}",__func__,body,title,subtitle,badge,sound);
    
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    
}


//通知的点击事件，前后台都会调用该方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    
    
    NSLog(@"%s 点击通知",__func__);
    
    UNNotificationContent *content = response.notification.request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    NSLog(@"iOS10 收到本地通知:{%s,\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@\\\\n}",__func__,body,title,subtitle,badge,sound);

    

    //处理交互
    NSString *categoryIdentifier = response.notification.request.content.categoryIdentifier;
    
    if ([categoryIdentifier isEqualToString:@"Categroy"]) {
        if ([response.actionIdentifier isEqualToString:@"replyAction"]) {
            UNTextInputNotificationResponse *textResponse = (UNTextInputNotificationResponse*)response;
            
            NSString *userText = textResponse.userText;
            
            NSLog(@"您输入的内容：%@", userText);
            
        } else if ([response.actionIdentifier isEqualToString:@"enterAction"]) {
            NSLog(@"点击进入了应用");
        } else {
            NSLog(@"点击了取消");
        }
    }
    
    
    // Warning: UNUserNotificationCenter delegate received call to -userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler: but the completion handler was never called.
    completionHandler();  // 系统要求执行这个方法
    
    
}


@end
