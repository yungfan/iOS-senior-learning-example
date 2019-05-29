//
//  DisplayLinkViewController.m
//  定时器的使用
//
//  Created by student on 2019/5/28.
//  Copyright © 2019 student. All rights reserved.
//

#import "DisplayLinkViewController.h"

@interface DisplayLinkViewController ()

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation DisplayLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
   
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(display)];
    
    //默认1秒执行60帧 改成1秒执行1帧
    self.displayLink.preferredFramesPerSecond = 3;
    
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}


-(void)display{
    
    self.count++;
    
    NSLog(@"CADisplayLink");
    
    if (self.count == 10) {
        
        [self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
    }
    
    
    
}

@end
