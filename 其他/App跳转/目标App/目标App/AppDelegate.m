//
//  AppDelegate.m
//  目标App
//
//  Created by student on 2018/6/22.
//  Copyright © 2018年 student. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {

    // 拿到当前App的第一个界面
    UIViewController *main = application.keyWindow.rootViewController;
    
    // 根据字符串关键字来跳转到不同页面
    if ([url.absoluteString containsString:@"VC1"]) { // 跳转到应用App-B的Page1页面
        // 根据segue标示进行跳转
        [main performSegueWithIdentifier:@"abc" sender:nil];
    }
    
    return YES;
}

@end
