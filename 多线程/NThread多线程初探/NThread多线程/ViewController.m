//
//  ViewController.m
//  NSThread的使用
//
//  Created by student on 2019/3/1.
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
    
    //打印主线程
    NSLog(@"%@", [NSThread currentThread]);
    
    
    //放在主线程中执行 完成触摸 会很久才打印 界面会卡死
    for (NSInteger i =1 ; i<=5; i++) {
        NSLog(@"%li-%@",(long)i, [NSThread currentThread]);
    }
    
    
    //类方法，线程会自动启动
    //第一种使用方式
    [NSThread detachNewThreadWithBlock:^{
        
        //放在子线程中执行 完成触摸 会瞬间打印
        for (NSInteger i =1 ; i<=5; i++) {
            NSLog(@"%li-%@",(long)i, [NSThread currentThread]);
        }
        
        
    }];
    
    //第二种使用方式
    [NSThread detachNewThreadSelector:@selector(runThread) toTarget:self withObject:nil];
    
    
    NSLog(@"完成触摸");
    
}


-(void)runThread{
    
    for (NSInteger i =6 ; i<=10; i++) {
        NSLog(@"%li-%@",(long)i, [NSThread currentThread]);
    }
    
}

@end
