//
//  ViewController.m
//  UITouch讲解
//
//  Created by teacher on 17/2/15.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"%s", __func__);

}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s", __func__);

}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"%s", __func__);
}

@end
