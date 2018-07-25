//
//  ViewController.m
//  NSOperation依赖
//
//  Created by teacher on 17/3/31.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
     
        NSLog(@"小🐔快跑 －－ 下载图片1");
        [NSThread sleepForTimeInterval:2.0];
         NSLog(@"op1%@", [NSThread currentThread]);
        
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"小🐢快跑 －－ 下载图片2");
        
        [NSThread sleepForTimeInterval:2.0];
         NSLog(@"op2%@", [NSThread currentThread]);
        
        
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"小🐰快跑 －－ 下载图片3");
        [NSThread sleepForTimeInterval:2.0];
         NSLog(@"op3%@", [NSThread currentThread]);
    }];
    
    //任务之间的依赖关系
    [op2 addDependency:op1];
    [op3 addDependency:op2];
    
    //完成监听
    [op1 setCompletionBlock:^{
        NSLog(@"op1 完成 %@", [NSThread currentThread]);
        
        //如何在子线程中执行完任务后回到主线程？
        //1、如果是子线程要执行的任务，那么将该任务放到自己定义的NSOperationQueue中
        //2、如果是主线程要执行的任务，那么将该任务放到[NSOperationQueue mainQueue]去执行就可以了
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            NSLog(@"回到主线程－－ 显示图片1");
            
            NSLog(@"%@", [NSThread currentThread]);
            
        }];
        
        
    }];
    
    [op2 setCompletionBlock:^{
        NSLog(@"op2 完成 %@", [NSThread currentThread]);

        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            NSLog(@"回到主线程－－ 显示图片2");
            
            NSLog(@"%@", [NSThread currentThread]);
            
        }];
        
    }];
    
    [op3 setCompletionBlock:^{
        NSLog(@"op3 完成 %@", [NSThread currentThread]);
        

        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            NSLog(@"回到主线程－－ 显示图片3");
            
            NSLog(@"%@", [NSThread currentThread]);
            
        }];
    }];
    
    
    //串行队列与依赖之间的区别？
    //1、队列依旧是并发的，并不是串行的
    //2、执行结果看似一样其实不一样，串行队列是将任务添加到队列以后串行执行，而依赖关系是并行执行的
    
    NSOperationQueue *nq = [[NSOperationQueue alloc]init];
    
    [nq addOperations:@[op1, op2, op3] waitUntilFinished:NO];
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
