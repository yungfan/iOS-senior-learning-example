//
//  ViewController.m
//  GCD队列与任务
//
//  Created by student on 2019/3/7.
//  Copyright © 2019 abc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self gcd01];
}


-(void)gcd01{
    
    //获取主队列 串行执行
    dispatch_queue_t main = dispatch_get_main_queue();
    
    //获取全局队列 并发执行
    dispatch_queue_t queue  = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    //自己创建
    dispatch_queue_t selfConcurrent = dispatch_queue_create("并发队列", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_queue_t selfSerial = dispatch_queue_create("串行队列", DISPATCH_QUEUE_SERIAL);
    
    
    //OC方法调用: [类、对象  方法];   GCD:方法名(队列，任务)
    
    //同步方法(队列，任务)
    dispatch_sync(selfConcurrent, ^{
        
        for (int i = 0; i < 10; i++) {
            
            NSLog(@"%d -- %@", i, [NSThread currentThread]);
            
        }
    });
    
    //异步方法(队列，任务)
    dispatch_async(selfSerial, ^{
        
        for (int i = 11; i < 1000; i++) {
            
            NSLog(@"%d -- %@", i, [NSThread currentThread]);
            
        }
        
    });
    
    
    //同步方法 必须等执行完 才会执行下面的代码
    //异步方法 立马会执行下面的代码
    NSLog(@"任务完成");
    
    
}




@end
