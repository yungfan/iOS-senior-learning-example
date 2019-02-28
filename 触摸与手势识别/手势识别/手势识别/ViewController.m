//
//  ViewController.m
//  手势识别
//
//  Created by student on 2019/2/26.
//  Copyright © 2019 abc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

//SB中使用手势
- (IBAction)gestureRecognizer:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    
    tap.numberOfTapsRequired = 2;
    
    [self.view addGestureRecognizer:tap];
    
    
    
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotation:)];
    
    [self.view addGestureRecognizer:rotation];
    
    
    UIScreenEdgePanGestureRecognizer *screenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(screenEdgePan:)];
    
    tap.delegate = self;
    
    //屏幕边缘的位置
    screenEdgePan.edges = UIRectEdgeLeft;
    
    [self.view addGestureRecognizer:tap];
    
    
}

-(void)screenEdgePan:(UIScreenEdgePanGestureRecognizer *)screenEdgePan{
    
    
    NSLog(@"%s", __func__);

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"屏幕边缘滑动手势" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil] ;

    [alert addAction:cancel];


    [self presentViewController:alert animated:YES completion:nil];
}


-(void)rotation:(UIRotationGestureRecognizer *)rotation{
    
    
    NSLog(@"%s", __func__);
    
}

-(void)tap:(UITapGestureRecognizer *)tap{
    
    
    NSLog(@"%s", __func__);
    
}


- (IBAction)gestureRecognizer:(id)sender {
    
    //NSLog(@"%s", __func__);
    
    CGFloat red = arc4random_uniform(255) / 255.0;
    
    CGFloat green = arc4random_uniform(255) / 255.0;
    
    CGFloat blue = arc4random_uniform(255) / 255.0;
    
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if (gestureRecognizer.state == UIGestureRecognizerStatePossible) {
        
        NSLog(@"手势可用");
        
    }

    return YES;
}

@end
