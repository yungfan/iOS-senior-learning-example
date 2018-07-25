//
//  ViewController.m
//  Objective-C 与 JavaScript 交互
//
//  Created by student on 2018/4/4.
//  Copyright © 2018年 student. All rights reserved.
//

//1.加载JS代码
//
//- (JSValue *)evaluateScript:(NSString *)script;

//2.调用JS方法
//
//JSValue *callBack = self.context[@"callback"];
//[callBack callWithArguments:@[@"大家好！"]];

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()

@property(nonatomic, strong)JSContext *context;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. OC调JS
    
    //JS代码
    NSString *str = @"var factorial = function (n){if (n < 0) {return;}if (n == 0) {return 1;}return n * factorial(n - 1)}";
  
    //JSContext 是JS代码的执行环境
    JSContext *context = [[JSContext alloc]init];
    self.context = context;
    
    //执行JS代码
    [self.context evaluateScript:str];
    
    //JSValue 是对 JS 值的包装
    JSValue *function = self.context[@"factorial"];
    
    JSValue *result = [function callWithArguments:@[@5]];
    
    NSLog(@"%d", [result toInt32]);
    

    //2. JS调OC
    //= 左边设置JS的函数，右边是一个Block
    __weak typeof(self) weakSelf = self;
    
    self.context[@"showMessage"] = ^(NSString *message){
        
        UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        
        [alertCtr addAction:cancel];
        
        //注意：方法是在子线程中执行的，需要跟新UI的话，需要切入主线程。
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf presentViewController:alertCtr animated:YES completion:nil];
            
        });
    };
    
    [self.context evaluateScript:@"showMessage('HelloWorld')"];
}




@end
