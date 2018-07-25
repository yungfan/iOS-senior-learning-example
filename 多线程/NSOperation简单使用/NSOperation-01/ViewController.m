//
//  ViewController.m
//  NSOperation-01
//
//  Created by teacher on 17/3/29.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setInvocationOperation];

    
}


-(void)setBlockOperation{
    
    NSLog(@"Started --- %@", [NSThread currentThread]);
    
    
    //下载电影
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"🐑快跑");
        
        NSLog(@"%@", [NSThread currentThread]);
    }];
    
    //下载大图
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"🐲快跑");
        
        NSLog(@"%@", [NSThread currentThread]);
    }];
    
    
    //下载无损音乐
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"🐷快跑");
        
        NSLog(@"%@", [NSThread currentThread]);
    }];

    
    NSOperationQueue *opq = [[NSOperationQueue alloc]init];
    
    [opq addOperations:@[op1, op2, op3] waitUntilFinished:NO];
    
    NSLog(@"Finished --- %@", [NSThread currentThread]);
    
}

-(void)setInvocationOperation{

    //NSInvocationOperation
    
    NSInvocationOperation *operation1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(run:) object:@"🐤快跑"];
    
    NSInvocationOperation *operation2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(run:) object:@"🐍快跑"];
    
    operation2.queuePriority = NSOperationQueuePriorityVeryHigh;
    
    NSInvocationOperation *operation3 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(run:) object:@"🐎快跑"];
    
    
    NSOperationQueue *operationQ = [[NSOperationQueue alloc]init];
    operationQ.maxConcurrentOperationCount = 2;
    
    
    [operationQ addOperation:operation1];
    [operationQ addOperation:operation2];
    [operationQ addOperation:operation3];

}


-(void)run:(NSString *)info{

    NSLog(@"%@", [NSThread currentThread]);
    
    NSLog(@"%@", info);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
