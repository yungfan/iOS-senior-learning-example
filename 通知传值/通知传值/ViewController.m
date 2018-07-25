//
//  ViewController.m
//  通知传值
//
//  Created by teacher on 17/5/27.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *result;
- (IBAction)push:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"首页";
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getText:) name:@"POPValue" object:nil];
    

}

-(void)getText:(NSNotification *)noti{


    self.result.text = [noti valueForKey:@"userInfo"][@"uname"];

}

- (IBAction)push:(id)sender {
    
    SecondViewController *secVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"second"];
    
    
    [self.navigationController pushViewController:secVC animated:YES];
    
}

//移除监听
-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
@end
