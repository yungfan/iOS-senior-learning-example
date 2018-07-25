//
//  ViewController.m
//  子线程更新UI
//
//  Created by student on 2018/4/13.
//  Copyright © 2018年 student. All rights reserved.
//  不能在子线程中更新主界面 －－－> 子线程进行耗时操作 主线程进行界面更新的 模式 －－－> 线程之间通信问题

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *img;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{


    NSThread *imgThread = [[NSThread alloc]initWithBlock:^{
        
        
        [NSThread sleepForTimeInterval:2.0];
        
        
        [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:NO];
        
    
    }];

    
    [imgThread start];


}


-(void)updateUI{


    self.img.image = [UIImage imageNamed:@"img.png"];

}


@end
