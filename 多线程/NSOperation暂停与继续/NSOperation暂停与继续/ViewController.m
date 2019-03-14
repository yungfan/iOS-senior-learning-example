//
//  ViewController.m
//  NSOperation暂停与继续
//
//  Created by teacher on 17/4/1.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//   1、暂停的是什么东西 2、有什么用处？（配合UITableView的优化问题）

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) NSOperationQueue *operationQueue;

- (IBAction)start:(id)sender;

- (IBAction)suspend:(id)sender;

- (IBAction)resume:(id)sender;

- (IBAction)cancel:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)start:(id)sender {
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        
        
        
        NSLog(@"下载电影1");
        
        [NSThread sleepForTimeInterval:3.0];
        
        
        NSLog(@"下载电影1结束");
        
        
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        
        
        NSLog(@"下载电影2");
        
        [NSThread sleepForTimeInterval:3.0];
        
        NSLog(@"下载电影2结束");
        
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        
        
        NSLog(@"下载电影3");
        
        [NSThread sleepForTimeInterval:3.0];
        
        NSLog(@"下载电影3结束");
        
        
    }];
    
    
    NSOperationQueue *opq = [[NSOperationQueue alloc]init];
    
    opq.maxConcurrentOperationCount = 2;
    
    self.operationQueue = opq;
    
    [opq addOperations:@[op1, op2, op3] waitUntilFinished:NO];
    
}


//NSOperationQueue中的那些还没有被CPU调度的线程才会暂停执行，那些已经被CPU调度的程序不会暂停
- (IBAction)suspend:(id)sender {
    
    if (self.operationQueue.operationCount != 0 && self.operationQueue.suspended == NO) {
        self.operationQueue.suspended = YES;
    }
    
}


//NSOperationQueue中的那些还没有被CPU调度的线程可以继续执行
- (IBAction)resume:(id)sender {
    
    if (self.operationQueue.operationCount != 0 && self.operationQueue.suspended == YES) {
        self.operationQueue.suspended = NO;
    }
    
}

//NSOperationQueue中的那些还没有被CPU调度的线程才会取消执行，无法再次让它们运行
- (IBAction)cancel:(id)sender {
    
    if (self.operationQueue.operationCount != 0){
        
        [self.operationQueue cancelAllOperations];
        
    }
}

@end
