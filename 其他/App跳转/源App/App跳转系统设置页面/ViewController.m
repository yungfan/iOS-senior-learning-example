//
//  ViewController.m
//  App跳转系统设置页面
//
//  Created by student on 2018/6/22.
//  Copyright © 2018年 student. All rights reserved.

#import "ViewController.h"


@interface ViewController ()

- (IBAction)openApp:(id)sender;

- (IBAction)openSpecial:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}



//打开一个App
- (IBAction)openApp:(id)sender {
    
    // 1.获取应用程序App-B的URL Scheme
    NSURL *appUrl = [NSURL URLWithString:@"testApp://"];
    
    // 2.判断手机中是否安装了对应程序
    if ([[UIApplication sharedApplication] canOpenURL:appUrl]) {
        // 3. 打开应用程序App-B
        [[UIApplication sharedApplication] openURL:appUrl options:@{} completionHandler:nil];
        
    } else {
        
        NSLog(@"没有安装");
        
    }
    
    //3.iOS9以后需要设置白名单，如果使用 canOpenURL:方法，该方法所涉及到的 URL Schemes 必须在"Info.plist"中将它们列为白名单，否则不能使用。key叫做LSApplicationQueriesSchemes ，键值内容是对应应用程序的URL Schemes。不论跳转到App还是具体的界面（app://或者app://abc），只需要设置一次
    
    
}

- (IBAction)openSpecial:(id)sender {
    
    
    // 1.获取应用程序App-B的URL Scheme
    NSURL *appUrl = [NSURL URLWithString:@"testApp://VC1"];
    
    // 2.判断手机中是否安装了对应程序
    if ([[UIApplication sharedApplication] canOpenURL:appUrl]) {
        // 3. 打开应用程序App-B
        [[UIApplication sharedApplication] openURL:appUrl options:@{} completionHandler:nil];
        
    } else {
        
        NSLog(@"没有安装");
        
    }

    
}
@end
