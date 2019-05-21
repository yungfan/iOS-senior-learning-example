//
//  ViewController.m
//  CoreImage滤镜
//
//  Created by student on 2018/6/6.
//  Copyright © 2018年 student. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *qrcodeImg;

@property (weak, nonatomic) IBOutlet UITextField *inputPwd;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 1. 实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2. 恢复滤镜的默认属性
    [filter setDefaults];
    
    // 3. 将字符串转换成NSData
    NSData *data = [@"www.abc.edu.cn" dataUsingEncoding:NSUTF8StringEncoding];
    
    // 4. 通过KVC设置滤镜inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    
    // 5. 获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    // 5.1 对CIImage进行转换 使得二维码变清晰
    outputImage = [outputImage imageByApplyingTransform:CGAffineTransformMakeScale(5, 5)];
    
    // 6. 将CIImage转换成UIImage
    UIImage *image =  [UIImage imageWithCIImage:outputImage scale:20.0 orientation:UIImageOrientationUp];
    
    self.qrcodeImg.image = image;
    
}


//滤镜（CIFliter）：CIFilter 产生一个CIImage。典型的，接受一到多的图片作为输入，经过一些过滤操作，产生指定输出的图片。
//查看所有的滤镜
-(void)showAllFilters{
    
    NSArray *filterNames=[CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    
    for (NSString *filterName in filterNames) {
        
        CIFilter *filter=[CIFilter filterWithName:filterName];
        
        NSLog(@"\rfilter:%@\rattributes:%@",filterName,[filter attributes]);
        
    }}

@end
