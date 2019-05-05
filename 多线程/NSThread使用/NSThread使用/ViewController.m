//
//  ViewController.m
//  NSThread使用
//
//  Created by student on 2019/3/5.
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

 //当iOS程序运行以后，有一个线程随之启动，主线程（main），这个线程很重要，可以接收用户的交互，更新程序的界面等等，因此它的流畅性必须要保证 －－－> 言外之意，耗时的操作不能放在主线程中来执行，否则会造成界面的卡顿甚至崩溃  －－－> 耗时的操作放在子线程中执行 －－－> 比如线程去服务器加载一段新闻数据，拿到新闻数据以后，我要更新界面（Apple直接规定不能在子线程更新主界面，必须回到主线程才行）？－－－> 子线程执行耗时任务，主线程来刷新界面，他们之间需要进行数据的交互和通信
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (NSThread.isMainThread) {
        
        NSLog(@"%s 主线程", __func__);
    }
    
    [self targetActionMethod];
    
    //[self blockMethod];
    
    
    //主线程中调用whereAmI
    [self whereAmI];
}


-(void)targetActionMethod{
    
    //对象方法，需手动启动
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(runThread) object:nil];

    thread.name = @"长江八号";
    
    thread.threadPriority = 0.3;
    
    
    //注意：子线程执行完操作之后就会立即释放，即使我们使用强引用引用子线程使子线程不被释放，也不能给子线程再次添加操作，或者再次开启。
    [thread start];
    
}

-(void)runThread{
    
    for (int i = 10; i < 20; i++) {
        
        //休眠
        //[NSThread sleepForTimeInterval:1.0];
        
        NSLog(@"%d -- %@", i, [NSThread currentThread]);
        
        [self whereAmI];
        
    }
    
}

-(void)blockMethod{
    
    //对象方法，需手动启动
    NSThread *thread = [[NSThread alloc]initWithBlock:^{
        
        for (int i = 0; i < 10; i++) {
            
            
            //[NSThread sleepForTimeInterval:1.0];
            
            NSLog(@"%d -- %@", i, [NSThread currentThread]);
            
            if (NSThread.isMainThread) {
                
                NSLog(@"主线程");
            }
            
        }
        
    }];
    
    thread.threadPriority = 0.8;
    
    thread.name = @"长江七号";
    
    [thread start];
    
}


//同一个方法，在主线程中调用则该方法处于主线程，在子线程中调用则处于子线程，不能仅仅看方法的声明和所处的位置
-(void)whereAmI{
    
    NSLog(@"%s -- %@", __func__, [NSThread currentThread]);
    
}

@end
