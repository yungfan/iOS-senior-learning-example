//
//  SecondViewController.m
//  JSON解析
//
//  Created by teacher on 17/2/28.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    [self.webView loadRequest:request];

}

@end
