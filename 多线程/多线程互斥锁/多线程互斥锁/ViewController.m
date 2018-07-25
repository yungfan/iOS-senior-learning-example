//
//  ViewController.m
//  多线程互斥锁
//
//  Created by student on 2018/4/11.
//  Copyright © 2018年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, assign) int count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    _count = 20;
    
    
    NSThread *thread1 = [[NSThread alloc]initWithTarget:self selector:@selector(buyTicket) object:nil];
    thread1.name = @"窗口1";
    NSThread *thread2 = [[NSThread alloc]initWithTarget:self selector:@selector(buyTicket) object:nil];
    thread2.name = @"窗口2";
    NSThread *thread3 = [[NSThread alloc]initWithTarget:self selector:@selector(buyTicket) object:nil];
    thread3.threadPriority = 50.0;
    thread3.name = @"窗口3";
    
    
    [thread1 start];
    [thread2 start];
    [thread3 start];
    
    
    
    
}

-(void)buyTicket{
    
    while (true) {
        
        
        [NSThread sleepForTimeInterval:1];
        
        //对于临界资源 多线程访问往往会出现问题 加锁可以解决
        
        //加锁的结果：每次只有一个线程可以访问临界资源
        //加锁是一个标志，当该资源没有线程访问的时候，🔒标志为0，当第一个线程来的时候，🔒的标志为1，第一个线程开始访问临界资源
        //如果此时有其他线程来访问该临界资源，先要看看🔒是不是为0，如果是1，则阻塞自己，等待上一个线程访问结束。
        //第一个线程访问结束以后，🔒的标志为0，这时候通知那些准备访问该资源的线程可以来访问了，这时候按照顺序（CPU调度）来继续访问
        
        @synchronized (self) {
            
            if (_count > 0) {
                
                _count--;
                
                NSLog(@"%@----%d", [NSThread currentThread],_count);
                
            }
            
            else{
                
                break;
            }
            
        }
        

    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
