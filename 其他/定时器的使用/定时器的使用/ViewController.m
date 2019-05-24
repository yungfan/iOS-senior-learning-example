//
//  ViewController.m
//  定时器的使用
//
//  Created by student on 2019/5/24.
//  Copyright © 2019 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIButton *btnTime;
@property (nonatomic, assign) NSInteger count;

- (IBAction)btnTimeClick:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
  
    self.count = 3;
    
    
   
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self intervalTimer];
}

-(void)intervalTimer{
    
    self.timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        self.count = self.count - 1;
        
        
        [self.btnTime setTitle:[NSString stringWithFormat:@"%ld", (long)self.count] forState:UIControlStateNormal];
        
        if (self.count == 0) {
            
            [self.timer invalidate];
            
            self.timer = nil;
            
            [self performSegueWithIdentifier:@"abc" sender:nil];
            
        }

    }];
    
    
    //添加到RunLoop中执行
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

-(void)scheduledTimer{
    
    
    //如果使用的是这种方式，会自动添加到模式为NSDefaultRunLoopMode的RunLoop中
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        NSLog(@"Hello Timer");
        
    }];
}


- (IBAction)btnTimeClick:(id)sender {
    
    [self.timer invalidate];
    
    self.timer = nil;
    
    [self performSegueWithIdentifier:@"abc" sender:nil];
}
@end
