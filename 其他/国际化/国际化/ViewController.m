//
//  ViewController.m
//  国际化
//
//  Created by student on 2019/6/6.
//  Copyright © 2019 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:NSLocalizedString(@"loginBtnTitle", nil) forState:UIControlStateNormal];
    
    btn.frame = CGRectMake(0, 0, 100, 30);
    
    btn.center = self.view.center;
    
    [self.view addSubview:btn];
}


@end
