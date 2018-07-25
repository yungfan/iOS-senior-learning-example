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

   
    
    //利用二维码滤镜来生成二维码
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [filter setDefaults];
    
    //二维码中存储的数据
    NSString *str = @"https://www.baidu.com";
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    //将数据经过滤镜处理，通过KVC设置滤镜inputMessage数:通过间接的方式给类的属性赋值
    [filter setValue:data forKey:@"inputMessage"];
    
    //KVC应用
    [self.inputPwd setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    //滤镜将输入数据转成一张二维码图片
    
    CIImage *outputImage = filter.outputImage;
    
    
    //通过位图创建高清图片
    UIImage *resizedImage = [self resizeImage:[UIImage imageWithCIImage:outputImage]
                             
                                  withQuality:kCGInterpolationNone
                             
                                         rate:10.0];
    
    self.qrcodeImg.image = resizedImage;
    
}



//iOS绘画
- (UIImage *)resizeImage:(UIImage *)image

             withQuality:(CGInterpolationQuality)quality

                    rate:(CGFloat)rate {
    
    UIImage *resizedImg = nil;
    
    CGFloat width = image.size.width * rate;
    
    CGFloat height = image.size.height * rate;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetInterpolationQuality(context, quality);
    
    [image drawInRect:CGRectMake(0, 0, width, height)];
    
    resizedImg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resizedImg;
    
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
