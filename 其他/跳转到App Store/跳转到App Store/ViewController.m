//
//  ViewController.m
//  跳转到App Store
//
//  Created by student on 2019/6/4.
//  Copyright © 2019 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"对App进行评分" message:@"请给予一个好评" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //URL Scheme 必须正确
        NSURL *url = [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/iqiyi"];
        
        if([UIApplication.sharedApplication canOpenURL:url]){
            
            [UIApplication.sharedApplication openURL:url options:@{} completionHandler:nil];
        }
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    
    [alert addAction:ok];
    
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
