//
//  ViewController.m
//  二维码
//
//  Created by student on 2019/5/29.
//  Copyright © 2019 abc. All rights reserved.
//

#import "ViewController.h"
#import <CoreImage/CoreImage.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *content;
- (IBAction)createQR:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *qrImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(UIImage *)generateQR:(NSString *)str{
    
    // 1. 实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2. 恢复滤镜的默认属性
    [filter setDefaults];
    
    // 3. 将字符串转换成NSData
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    // 4. 通过KVC设置滤镜inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    
    // 5. 获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    // 5.1 对CIImage进行转换 使得二维码变清晰
    outputImage = [outputImage imageByApplyingTransform:CGAffineTransformMakeScale(5, 5)];
    
    // 6. 将CIImage转换成UIImage
    return [[UIImage alloc]initWithCIImage:outputImage];

    
}


- (IBAction)createQR:(id)sender {
    
    
    NSString *str = self.content.text;
    
    self.qrImage.image = [self generateQR:str];
    
}

//滤镜（CIFliter）：CIFilter 产生一个CIImage。典型的，接受一到多的图片作为输入，经过一些过滤操作，产生指定输出的图片。
//查看所有的滤镜
-(void)showAllFilters{
    
    NSArray *filterNames=[CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    
    for (NSString *filterName in filterNames) {
        
        CIFilter *filter=[CIFilter filterWithName:filterName];
        
        NSLog(@"\rfilter:%@\rattributes:%@",filterName,[filter attributes]);
        
    }
    
}

@end
