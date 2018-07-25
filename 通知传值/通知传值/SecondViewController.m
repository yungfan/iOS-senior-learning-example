//
//  SecondViewController.m
//  通知传值
//
//  Created by teacher on 17/5/27.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property(assign, nonatomic) CGRect oldFrame;

- (IBAction)pop:(id)sender;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardAppear:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
}


- (IBAction)pop:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"POPValue" object:nil userInfo:@{@"uname":self.username.text, @"pwd":self.password.text}];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
   
}

-(void)keyBoardAppear:(NSNotification *)noti{
    
    NSValue *aValue = [[noti valueForKey:@"userInfo"] objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    CGFloat height = keyboardRect.size.height;

    self.oldFrame = self.username.frame;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.username.frame = CGRectMake(self.oldFrame.origin.x, self.view.frame.size.height - height - self.oldFrame.size.height - 2, self.oldFrame.size.width, self.oldFrame.size.height);
    }];
        
  
    
  

}

-(void)keyBoardDisappear:(NSNotification *)noti{
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.username.frame = self.oldFrame;
    }];

    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];

}

-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
@end
