//
//  ViewController.m
//  GCD常用方法
//
//  Created by teacher on 17/3/27.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self dispatchBarrier];
}


//死锁问题 两个案例  http://blog.csdn.net/u013375242/article/details/47947751
-(void)dispatchSync{
   
    // 假设这段代码执行于主队列
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    // 在主队列添加同步任务
    
    //解释 主线程其实就是在一个串行队列里的，这个同步线程就相当下面案例中第二个嵌套的同步线程（UI才是第一个主线程），因为这个同步线程是在主线程里写的，就相当于嵌套在主线程里的。
    dispatch_sync(mainQueue, ^{
        // 任务
        NSLog(@"main");
    });
    
    
    
    //解释：在串行队列中，第二个同步线程要执行，必须等待第一个同步线程执行完成后才可进行，但是第一个同步线程要执行完又得等待第二个同步线程执行完，因为第二个同步线程嵌套在第一个同步线程里，这就造成了两个同步线程互相等待，即死锁。
    
    // 在串行队列添加同步任务
    dispatch_sync(serialQueue, ^{
        // 任务
         NSLog(@"dispatch_sync 1");
        
        dispatch_sync(serialQueue, ^{
            // 任务
            NSLog(@"dispatch_sync 2");
        });
    });

}

-(void)dispatchApply{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
   
    
    //循环体执行的次数由第一个参数指定  但是循环体执行的顺序不受控制
    dispatch_apply(20, queue, ^(size_t index) {
        
        NSLog(@"我是%zu循环体", index);
        
    });


}


-(void)dispatchBarrier{
    
    dispatch_queue_t  queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        
        [NSThread sleepForTimeInterval:2.0];
        NSLog(@"执行任务1");
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2.0];
        NSLog(@"执行任务2");
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2.0];
        NSLog(@"执行任务3");
    });

    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2.0];
        NSLog(@"执行任务4");
    });
    
    //使用 dispatch_barrier_async ，该函数只能搭配自定义并行队列 dispatch_queue_t 使用。不能使用： dispatch_get_global_queue 
    dispatch_barrier_async(queue, ^{
        NSLog(@"我是分界线");
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"执行任务5");
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"执行任务6");
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"执行任务7");
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"执行任务8");
    });

    
}

-(void)dispatchOnce{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSLog(@"执行一次的任务");
        
    });

}

-(void)dispatchAfter{

    NSLog(@"延迟执行之前");
    
    
    // NSEC_PER_SEC，每秒。
    // USEC_PER_SEC，毫秒。
    // NSEC_PER_USEC，纳秒。
    // DISPATCH_TIME_NOW 从现在开始
    // DISPATCH_TIME_FOREVE 永久

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        NSLog(@"延迟3秒执行");
        
        
    });
    
    NSLog(@"延迟执行之后");

}


/**
 * GCD 队列组：dispatch_group
 * 队列组 dispatch_group_notify
 */
- (void)groupNotify {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"group---begin");
    
    dispatch_group_t group =  dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步任务1、任务2都执行完毕后，回到主线程执行下边任务
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
        NSLog(@"group---end");
    });
}


/**
 * 队列组 dispatch_group_wait
 */
- (void)groupWait {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"group---begin");
    
    dispatch_group_t group =  dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    // 等待上面的任务全部完成后，会往下继续执行（会阻塞当前线程）
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    NSLog(@"group---end");
}

@end
