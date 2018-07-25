//
//  GreenViewController.m
//  目标App
//
//  Created by student on 2018/6/22.
//  Copyright © 2018年 student. All rights reserved.
//

#import "GreenViewController.h"

@interface GreenViewController ()

@end

@implementation GreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.schemaA = @"AppA://";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    

    

    // 1.获取应用程序App-B的URL Scheme
    NSURL *appUrl = [NSURL URLWithString:self.schemaA];
    
    // 2.判断手机中是否安装了对应程序
    if ([[UIApplication sharedApplication] canOpenURL:appUrl]) {
        // 3. 打开应用程序App-B
        [[UIApplication sharedApplication] openURL:appUrl options:@{} completionHandler:nil];
        
    } else {
        
        NSLog(@"没有安装");
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];


}


@end
