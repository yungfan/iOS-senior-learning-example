//
//  ViewController.m
//  父子控制器
//
//  Created by student on 2018/6/6.
//  Copyright © 2018年 student. All rights reserved.
//

#import "ViewController.h"
#import "SonViewController.h"

@interface ViewController ()

@property(strong, nonatomic) SonViewController *svc;

@property(strong, nonatomic) UIViewController  *cvc;

- (IBAction)change:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    
    //添加两个子控制器
    [self addAnotherChild];
    
    [self addOneChild];
    
    
}

-(void)addAnotherChild{
    
    
    self.svc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"abc"];
    
    //添加某个控制器为当前控制器的子控制器
    [self addChildViewController:self.svc];
    
    self.svc.view.frame = CGRectMake(10, 100, self.view.frame.size.width - 20, 200);
    
    //一般情况下，只要控制器成为了子控制器，那么view也应该成为子view
    [self.view addSubview:self.svc.view];
    
    
    
}


-(void)addOneChild{
    
    
    UIViewController *vc = [[UIViewController alloc]init];
    
    vc.view.backgroundColor = [UIColor greenColor];
    
    vc.view.frame = CGRectMake(10, 100, self.view.frame.size.width - 20, 200);
    
    
    [self addChildViewController:vc];
    
    [self.view addSubview:vc.view];
    
    self.cvc = vc;
    
    
    
}


- (IBAction)change:(id)sender {
    
    UISwitch *switc = (UISwitch *)sender;
    
    if ([switc isOn]) {
        
        //同一个控制器的子控制器之间可以用如下的方式添加切换动画 前提是它们两个必须先添加到同一个父控制器
        [self transitionFromViewController:self.cvc toViewController:self.svc duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            
            [self.cvc.view removeFromSuperview];
            
        } completion:^(BOOL finished) {
            
            NSLog(@"%@", self.childViewControllers);
            
        }];
        
        
        
    }
    
    else{
        
        
        [self transitionFromViewController:self.svc toViewController:self.cvc duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            
            [self.svc.view removeFromSuperview];
            
        } completion:^(BOOL finished) {
            
            NSLog(@"%@", self.childViewControllers);
            
        }];
        
        
        
    }
    
}

//移除控制器与视图
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//
//    [self.cvc removeFromParentViewController];
//
//    NSLog(@"%@", self.cvc.view);
//    
//    [self.cvc.view removeFromSuperview];
//    
//}
//


@end
