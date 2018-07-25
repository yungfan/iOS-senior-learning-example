//
//  ViewController.m
//  通知
//
//  Created by student on 2018/6/11.
//  Copyright © 2018年 student. All rights reserved.
//

#import "ViewController.h"
#import "SecViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *value;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    
    //selector模式监听通知
    [center addObserver:self selector:@selector(getValueForNotification:) name:@"passValue" object:nil];
    
    //block形式监听通知
    [center addObserverForName:@"passValue2" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        NSLog(@"%@", note.object);
    }];
    
    
    [center addObserverForName:@"passValue3" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        
        NSString *uid = note.userInfo[@"id"];
        
        NSString *msg = note.userInfo[@"message"];
       
        if (![uid isEqualToString:@""]) {
            
            NSLog(@"发送网络请求");
            
        }
        
    }];
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    SecViewController *svc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"abc"];

    [self presentViewController:svc animated:YES completion:nil];

}

-(void)getValueForNotification:(NSNotification *)sender{

    NSLog(@"%@", sender);

}

//移除监听
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
