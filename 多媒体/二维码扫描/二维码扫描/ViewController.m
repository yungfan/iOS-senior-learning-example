//
//  ViewController.m
//  二维码扫描
//
//  Created by teacher on 17/5/19.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController () <AVCaptureMetadataOutputObjectsDelegate>

/**
 *  UI
 */
@property (weak, nonatomic) IBOutlet UIImageView *scanline;
@property (weak, nonatomic) IBOutlet UILabel *result;


/**
 *  五个类
 */
@property(nonatomic, strong) AVCaptureDevice *device;

@property(nonatomic, strong)  AVCaptureDeviceInput *input;

@property(nonatomic, strong)  AVCaptureMetadataOutput *output;

@property(nonatomic, strong) AVCaptureSession *session;

@property(nonatomic, strong) AVCaptureVideoPreviewLayer *layer;

@end

@implementation ViewController

/**
 *  懒加载数据
 */
-(AVCaptureDevice *)device{
    if (_device == nil) {
        
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
    }
    return _device;

}

-(AVCaptureDeviceInput *)input{

    if (_input == nil) {
        
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
        
    }
    
    return  _input;

}

-(AVCaptureMetadataOutput *)output{
    
    if (_output == nil) {
        
        _output = [[AVCaptureMetadataOutput alloc]init];
        
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
    }
    
    return  _output;
}


/**
 *  扫描的那条线动起来
 */
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    CGFloat x = self.scanline.frame.origin.x;
    
    CGFloat y = self.scanline.frame.origin.y;
    
    CGFloat w = 240;
    
    CGFloat h = 7;

    [UIView animateWithDuration:3.0 delay:0 options:UIViewAnimationOptionRepeat animations:^{
        self.scanline.frame = CGRectMake(x,y+236,w,h);
    } completion:nil];


}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //创建会话
    AVCaptureSession *session = [[AVCaptureSession alloc]init];
    
    //添加输入和输出设备
    [session addInput:self.input];
    [session addOutput:self.output];
    
    
    //设置这次扫描的数据类型
    self.output.metadataObjectTypes = self.output.availableMetadataObjectTypes;
    
    
    //关键设置扫描的区域
    CGFloat x = (self.view.bounds.size.width - 240) * 0.5;
    
    CGFloat y = (self.view.bounds.size.height- 240) * 0.5;
    
    CGFloat w = 240;
    
    CGFloat h = w;
    
    
    self.output.rectOfInterest = CGRectMake(y/self.view.bounds.size.height, x/self.view.bounds.size.width,  h/self.view.bounds.size.height, w/self.view.bounds.size.width);
    
    //创建预览层
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    
    layer.frame = self.view.bounds;
    
    [self.view.layer insertSublayer:layer atIndex:0];
    
    
    
    //周围的遮罩层
    CALayer *maskLayer = [[CALayer alloc]init];
    
    maskLayer.frame = self.view.bounds;
    
    maskLayer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.8].CGColor;
    
    [self.view.layer insertSublayer:maskLayer above:layer];
    
    //开始扫描
    [session startRunning];
    
    
    self.session = session;
    self.layer = layer;
}


/**
 *  如果扫描到了二维码 回调该代理方法
 */
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{

    if(metadataObjects.count > 0 && metadataObjects != nil){
    
    
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects lastObject];
        
        NSString *result = metadataObject.stringValue;
        
        self.result.text = result;
        
        NSLog(@"%@", result);
        
    
        [self.session stopRunning];
    
    }


}


@end
