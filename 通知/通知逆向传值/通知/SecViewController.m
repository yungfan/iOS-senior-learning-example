//
//  SecViewController.m
//  通知
//
//  Created by student on 2018/6/11.
//  Copyright © 2018年 student. All rights reserved.
//

#import "SecViewController.h"

@interface SecViewController ()

@property (weak, nonatomic) IBOutlet UITextField *username;

@property (weak, nonatomic) IBOutlet UITextField *pssword;


- (IBAction)passValue:(id)sender;

@end

@implementation SecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}


- (IBAction)passValue:(id)sender {
    
    NSString *username = self.username.text;
    
    NSString *password = self.pssword.text;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    
    //1.隐形地发送一个通知
    [center postNotificationName:@"passValue" object:username];
    
    
    //2.显形地发送一个通知
    NSNotification *one = [NSNotification notificationWithName:@"passValue2" object:password];
    
    [center postNotification:one];
    
    
    NSNotification *two = nil;
    
    if ([username isEqualToString:@"z"] && [password isEqualToString:@"1"]) {
        
        //3.显形地发送一个通知，传多个值
        two = [NSNotification notificationWithName:@"passValue3" object:nil userInfo:@{@"id":@"1", @"message":@"登录成功"}];
       
        
    } else{
    
        
        //3.显形地发送一个通知，传多个值
        two = [NSNotification notificationWithName:@"passValue3" object:nil userInfo:@{@"id":@"", @"message":@"登录失败"}];
        
        
    }
    
     [center postNotification:two];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
