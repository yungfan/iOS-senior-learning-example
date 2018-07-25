//
//  ViewController.m
//  NSThread使用
//
//  Created by teacher on 17/3/20.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    //当iOS程序运行以后，有一个线程随之启动，主线程（main），这个线程很重要，可以接收用户的交互，更新程序的界面等等，因此它的流畅性必须要保证 －－－> 言外之意，耗时的操作不能放在主线程中来执行，否则会造成界面的卡顿甚至崩溃  －－－> 耗时的操作放在子线程中执行 －－－> 比如线程去服务器加载一段新闻数据，拿到新闻数据以后，我要更新界面（Apple直接规定不能在子线程更新主界面，必须回到主线程才行）？－－－> 子线程执行耗时任务，主线程来刷新界面，他们之间需要进行数据的交互和通信
    
    //1、类方法，自动启动
    //[NSThread detachNewThreadSelector:@selector(count) toTarget:self withObject:nil];
    
    //2、对象方法，需手动启动
    NSThread *newThread =  [[NSThread alloc]initWithTarget:self selector:@selector(count) object:nil];
    
    newThread.name = @"子线程";
    
    [newThread start];
    
    [self initData];
}

-(void)count{
   
    NSLog(@"子线程执行开始");
    
    NSLog(@"%@", [NSThread currentThread].name);
    
    for (int i = 1; i<10; i++) {
        
        [NSThread sleepForTimeInterval:1.0];
        
        NSLog(@"%d", i);
        
        
    }
    
    
    //子线程中调用的方法仍然处于子线程
    [self initData];
    

    //回到主线程执行
    //waitUntilDone 如果值为YES：当前方法调用完毕以后才会继续往下执行 NO：直接往后执行
    //[self performSelectorOnMainThread:@selector(initData) withObject:nil waitUntilDone:NO];
    
    [self performSelector:@selector(initData) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
    
    NSLog(@"子线程执行结束");
}


-(void)initData{
    
    
    NSLog(@"%@", [NSThread currentThread]);

    
}


@end
