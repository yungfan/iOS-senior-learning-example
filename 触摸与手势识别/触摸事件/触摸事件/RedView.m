//
//  RedView.m
//  触摸事件
//
//  Created by student on 2019/2/21.
//  Copyright © 2019 abc. All rights reserved.
//

#import "RedView.h"

@interface RedView()

@property (nonatomic, assign) CGPoint beginPoint;

@property (nonatomic, assign) CGPoint endPoint;

@end

@implementation RedView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"%s", __func__);
    
    self.beginPoint = [touches.anyObject locationInView:self];
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
     NSLog(@"%s", __func__);
    
    self.endPoint = [touches.anyObject locationInView:self];
    
    
    //判断滑动的方向
    if (self.beginPoint.x < self.endPoint.x) {
        
        self.backgroundColor = UIColor.blackColor;
    }
    
    else if (self.beginPoint.x > self.endPoint.x) {
        
        self.backgroundColor = UIColor.cyanColor;
        
    }
    
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"%s", __func__);
    
}

//来电话时
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
     NSLog(@"%s", __func__);
    
}

@end
