//
//  ViewController.m
//  App跳转系统设置页面
//
//  Created by student on 2018/6/22.
//  Copyright © 2018年 student. All rights reserved.

// iOS10支持的所有跳转如下
//无线局域网 App-Prefs:root=WIFI
//蓝牙 App-Prefs:root=Bluetooth
//蜂窝移动网络 App-Prefs:root=MOBILE_DATA_SETTINGS_ID
//个人热点 App-Prefs:root=INTERNET_TETHERING
//运营商 App-Prefs:root=Carrier
//通知 App-Prefs:root=NOTIFICATIONS_ID
//通用 App-Prefs:root=General
//通用-关于本机 App-Prefs:root=General&path=About
//通用-键盘 App-Prefs:root=General&path=Keyboard
//通用-辅助功能 App-Prefs:root=General&path=ACCESSIBILITY
//通用-语言与地区 App-Prefs:root=General&path=INTERNATIONAL
//通用-还原 App-Prefs:root=Reset
//墙纸 App-Prefs:root=Wallpaper
//Siri App-Prefs:root=SIRI
//隐私 App-Prefs:root=Privacy
//Safari App-Prefs:root=SAFARI
//音乐 App-Prefs:root=MUSIC
//音乐-均衡器 App-Prefs:root=MUSIC&path=com.apple.Music:EQ
//照片与相机 App-Prefs:root=Photos
//FaceTime App-Prefs:root=FACETIME

#import "ViewController.h"

#define iOS10 ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    //1. iOS 10之前可以直接跳转
//    NSURL *url = [NSURL URLWithString:@"prefs:root=Bluetooth"];
    
//    if ([[UIApplication sharedApplication]canOpenURL:url]) {
    
//        [[UIApplication sharedApplication]openURL:url];
    
//    }
    

    
    //2. iOS10只允许如下方式跳转到设置里自己app的界面，对跳转到其他界面做了限制：
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];

  
    


}

@end
