//
//  GCDTimerViewController.m
//  定时器的使用
//
//  Created by student on 2019/5/28.
//  Copyright © 2019 student. All rights reserved.
//

#import "GCDTimerViewController.h"

@interface GCDTimerViewController ()

@property (nonatomic, strong) dispatch_source_t tTimer;
@property (nonatomic, assign) NSInteger count;
@property (weak, nonatomic) IBOutlet UIButton *btnTime;

- (IBAction)btnTimeClick:(id)sender;

@end

@implementation GCDTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.count = 3;
  
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    //创建GCD timer资源，第一个参数为源类型， 第四个参数是资源要加入的队列
    self.tTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    
    
    //设置timer信息， 第一个参数是我们的timer对象， 第二个是timer首次触发延迟时间， 第三个参数是触发时间间隔， 最后一个是是timer触发允许的延迟值， 建议值是十分之一（时间）
    dispatch_source_set_timer(self.tTimer,
                              dispatch_walltime(NULL, 0 * NSEC_PER_SEC),
                              1 * NSEC_PER_SEC,
                              0);
    
    //设置timer的触发事件（任务）
    dispatch_source_set_event_handler(self.tTimer, ^{
        
        [self.btnTime setTitle:[NSString stringWithFormat:@"%ld", (long)self.count] forState:UIControlStateNormal];
        
        self.count = self.count - 1;
        
        if (self.count == 0) {
            
            dispatch_cancel(self.tTimer);
            
            [self performSegueWithIdentifier:@"cba" sender:nil];
            
        }
        
    });
    
    
    dispatch_resume(self.tTimer);
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    //暂停
    //dispatch_suspend(self.tTimer);
    
    //销毁timer, 注意暂停的timer资源不能直接销毁， 需要先resume再cancel， 否则会造成内存泄漏
    //取消
    //dispatch_cancel(self.tTimer);
    
}

- (IBAction)btnTimeClick:(id)sender {
    
    dispatch_cancel(self.tTimer);
    
    [self performSegueWithIdentifier:@"cba" sender:nil];
    
}
@end
