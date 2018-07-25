//
//  ViewController.m
//  JSON解析
//
//  Created by teacher on 17/2/28.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data.txt" ofType:nil]];

    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    NSString *jttq = dic[@"result"][@"data"][@"url"];
    

    [self.btn setTitle:jttq forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
