//
//  LightGreenView.m
//  UITouch讲解
//
//  Created by teacher on 17/2/15.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "LightGreenView.h"

@implementation LightGreenView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch =  [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    NSLog(@"%f, %f", point.x, point.y);
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"%s", __func__);
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"%s", __func__);
}
@end
