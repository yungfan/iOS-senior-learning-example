//
//  ViewController.m
//  NThread多线程
//
//  Created by student on 2018/4/8.
//  Copyright © 2018年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    __block int count = 20;
    
    NSLog(@"方法执行开始");


    
    NSThread *thread = [[NSThread alloc]initWithBlock:^{
        
        NSLog(@"线程1方法执行开始");
        
        for (int i = 0; i < 10; i++) {
            
            [NSThread sleepForTimeInterval:1.0];
            
            NSLog(@"11报数：%d", i);
            
            count--;
        }
        
        
        
        NSLog(@"线程1 count = %d", count);
        
        NSLog(@"线程1方法执行完毕");
        
    }];
    
    
    NSThread *thread2 = [[NSThread alloc]initWithBlock:^{
        
        NSLog(@"线程2方法执行开始");
        
        for (int i = 0; i < 10; i++) {
            
            [NSThread sleepForTimeInterval:1.5];
            
            NSLog(@"22报数：%d", i);
            
            count--;
        }
        
        
        
        NSLog(@"线程2 count = %d", count);
        
        NSLog(@"线程2方法执行完毕");
        
    }];
    
    
    [thread start];
    
    [thread2 start];
    
    NSLog(@"方法执行完毕");
}


@end
