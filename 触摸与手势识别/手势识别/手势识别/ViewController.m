//
//  ViewController.m
//  手势识别
//
//  Created by teacher on 17/2/17.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)btnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *tuijian;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelClick)];
    
    
   // self.label.userInteractionEnabled = YES;
    
    [self.label addGestureRecognizer:tap];
        
    UITapGestureRecognizer *imgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgClick)];
    
    [self.imgView addGestureRecognizer:imgTap];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick:(id)sender {
    
    NSLog(@"%s", __func__);
    
}

-(void)labelClick{
    
    NSLog(@"%s", __func__);
    
    
    [UIView animateWithDuration:5 animations:^{
        
    
        self.label.textColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        
        self.label.transform = CGAffineTransformScale(self.label.transform, 0.8, 0.8);
        
        self.tuijian.transform = CGAffineTransformScale(self.tuijian.transform, 1.2, 1.2);
        
    }];
    
    
}


-(void)imgClick{
    
    NSLog(@"%s", __func__);

}


@end
