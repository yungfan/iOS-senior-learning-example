//
//  DetailsNewsViewController.m
//  新闻
//
//  Created by teacher on 17/3/2.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "DetailsNewsViewController.h"

@interface DetailsNewsViewController()

@property (weak, nonatomic) IBOutlet UIWebView *detailsNews;

@end

@implementation DetailsNewsViewController

-(void)viewDidLoad{

    [super viewDidLoad];
    
    self.title = @"详情";
    
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    
    [self.detailsNews loadRequest:req];

}

-(void)dealloc{
    
    NSLog(@"%s", __func__);
    
}


@end
