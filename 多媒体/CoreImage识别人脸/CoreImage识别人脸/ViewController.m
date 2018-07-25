//
//  ViewController.m
//  CoreImage识别人脸
//
//  Created by student on 2018/6/8.
//  Copyright © 2018年 student. All rights reserved.
//

#import "ViewController.h"
#import <CoreImage/CoreImage.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage *img = [UIImage imageNamed:@"byz.jpg"];
    
    NSArray *faces = [self detectFaceWithImage:img];
    
    if (faces) {
        
        for (CIFaceFeature * face in faces) {
            
            
            if (face.hasSmile) {
                NSLog(@"有微笑");
            }
            
            if (face.leftEyeClosed) {
                NSLog(@"左眼闭着");
            }
            
            if (face.rightEyeClosed) {
                NSLog(@"右眼闭着");
            }
            
            if (face.hasLeftEyePosition) {
                NSLog(@"左眼位置：%@",NSStringFromCGPoint(face.leftEyePosition));
                
            }
            
            if (face.hasRightEyePosition) {
                NSLog(@"右眼位置: %@",NSStringFromCGPoint(face.rightEyePosition));
                
            }
            if (face.hasMouthPosition) {
                NSLog(@"嘴巴位置: %@",NSStringFromCGPoint
                      (face.mouthPosition));
                
            }
            
            NSLog(@"脸部区域：%@ ----------------------",NSStringFromCGRect(face.bounds));
            
        }
        
    }
    
}



/*
 * 脸部识别
 */
-(NSArray *)detectFaceWithImage:(UIImage *)faceImage{
    
    //设置识别的精度
    NSDictionary *opts = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
    
    //识别人脸的类  CIDetecror是 coreImage框架中提供的一个识别类，包括人脸【CIDetectorTypeFace】，形状【CIDetectorTypeRectangle】，条码【CIDetectorTypeQRCode】，文本【CIDetectorTypeText】的识别
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:opts];
    
    
    //UIImage -> CGImage -> CIImage
    CIImage *ciimage = [CIImage imageWithCGImage:faceImage.CGImage];
    
    
    //特征
    NSArray *featrues = [detector featuresInImage:ciimage];
    
    if (featrues.count > 0)
        
        return featrues;
    
    return nil;
}

@end
