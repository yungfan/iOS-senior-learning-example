//
//  ViewController.m
//  多线程更新界面问题
//
//  Created by student on 2019/3/15.
//  Copyright © 2019 abc. All rights reserved.
//  不能在子线程中更新主界面 －－－> 子线程进行耗时操作，回到主线程进行界面更新的 模式 －－－> 线程之间通信问题


#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *username;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
   
    [self operationMode];
    
}

//NSOperation
-(void)operationMode{
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    [queue addOperationWithBlock:^{
        
        [NSThread sleepForTimeInterval:2.0];
        
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            
            self.username.text = @"欢迎你，张三";
        }];
        
    }];
    
}


//GCD模式
-(void)gcdMode{
    
    dispatch_queue_t queue =  dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        
        [NSThread sleepForTimeInterval:2.0];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.username.text = @"欢迎你，张三";
        });

    });
    
}


//NSThread模式
-(void)threadMode{
    
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(updateUI) object:nil];
    
    [thread start];
    
}


-(void)updateUI{
    
    [NSThread sleepForTimeInterval:2.0];
    
    [self performSelectorOnMainThread:@selector(updateOnMain) withObject:nil waitUntilDone:NO];
    
}

-(void)updateOnMain{
    
    self.username.text = @"欢迎你，张三";
}

@end
