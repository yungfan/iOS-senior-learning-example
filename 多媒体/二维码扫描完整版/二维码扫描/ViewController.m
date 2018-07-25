//
//  ViewController.m
//  二维码扫描
//
//  Created by teacher on 17/5/19.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController () <AVCaptureMetadataOutputObjectsDelegate, CALayerDelegate>

/**
 *  UI
 */
@property (weak, nonatomic) IBOutlet UIView *scanView;
@property (weak, nonatomic) IBOutlet UIImageView *scanline;
@property (weak, nonatomic) IBOutlet UILabel *result;

/**
 *  扫描区域的高度约束值（宽度一致）
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanViewH;
/**
 *  扫描线的顶部约束值
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanlineTop;

@property(nonatomic, strong) CALayer *maskLayer;

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

#pragma mark - 懒加载

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

#pragma mark - ViewController生命周期
/**
 *  扫描的那条线动起来
 */
//-(void)viewDidAppear:(BOOL)animated{
//    
//    [super viewDidAppear:animated];
//    
//    [UIView animateWithDuration:3.0 delay:0 options:UIViewAnimationOptionRepeat animations:^{
//        
//        self.scanlineTop.constant = self.scanViewH.constant - 4;
//        
//        [self.scanline layoutIfNeeded];
//        
//    } completion:nil];
//    
//}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:3.0 delay:0 options:UIViewAnimationOptionRepeat animations:^{
        
        self.scanlineTop.constant = self.scanViewH.constant - 4;
        
        [self.scanline layoutIfNeeded];
        
    } completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //1、创建会话
    AVCaptureSession *session = [[AVCaptureSession alloc]init];
    
    if ([session canSetSessionPreset:AVCaptureSessionPresetHigh]) {
        
        [session setSessionPreset:AVCaptureSessionPresetHigh];
        
    }
    
    //2、添加输入和输出设备
    if([session canAddInput:self.input]){
        
        [session addInput:self.input];
        
    }
    if([session canAddOutput:self.output]){
        
        [session addOutput:self.output];
    }
    
    
    //3、设置这次扫描的数据类型
    self.output.metadataObjectTypes = self.output.availableMetadataObjectTypes;
    
    //4、创建预览层
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    
    layer.frame = self.view.bounds;
    
    [self.view.layer insertSublayer:layer atIndex:0];
    
    
    //5、创建周围的遮罩层
    CALayer *maskLayer = [[CALayer alloc]init];
    
    maskLayer.frame = self.view.bounds;
    
    //此时设置的颜色就是中间扫描区域最终的颜色
    maskLayer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2].CGColor;
    
    maskLayer.delegate = self;
    
    [self.view.layer insertSublayer:maskLayer above:layer];
    
    //让代理方法调用 将周围的蒙版颜色加深
    [maskLayer setNeedsDisplay];
    
    
    //6、关键设置扫描的区域 方法一：自己计算
    //    CGFloat x = (self.view.bounds.size.width - self.scanViewH.constant) * 0.5;
    //
    //    CGFloat y = (self.view.bounds.size.height- self.scanViewH.constant) * 0.5;
    //
    //    CGFloat w = self.scanViewH.constant;
    //
    //    CGFloat h = w;
    //
    //
    //    self.output.rectOfInterest = CGRectMake(y/self.view.bounds.size.height, x/self.view.bounds.size.width,  h/self.view.bounds.size.height, w/self.view.bounds.size.width);
    
    //6、关键设置扫描的区域，方法二：直接转换,但是要在 AVCaptureInputPortFormatDescriptionDidChangeNotification 通知里设置，否则 metadataOutputRectOfInterestForRect: 转换方法会返回 (0, 0, 0, 0)。
    
    __weak __typeof(&*self)weakSelf = self;
    
    [[NSNotificationCenter defaultCenter] addObserverForName:AVCaptureInputPortFormatDescriptionDidChangeNotification object:nil queue:[NSOperationQueue currentQueue] usingBlock: ^(NSNotification *_Nonnull note) {
        
        weakSelf.output.rectOfInterest = [weakSelf.layer metadataOutputRectOfInterestForRect:self.scanView.frame];
        
    }];
    
    
    //7、开始扫描
    [session startRunning];

    
    self.session = session;
    self.layer = layer;
    self.maskLayer = maskLayer;
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


#pragma mark - 代理方法
/**
 *  如果扫描到了二维码 回调该代理方法
 */
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if(metadataObjects.count > 0 && metadataObjects != nil){
        
        
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects lastObject];
        
        NSString *result = metadataObject.stringValue;
        
        self.result.text = result;
        
        [self.session stopRunning];
        
        [self.scanline removeFromSuperview];
        
    }
    
    
}

/**
 *   蒙版中间一块要空出来
 */

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    
    if (layer == self.maskLayer) {
        
        UIGraphicsBeginImageContextWithOptions(self.maskLayer.frame.size, NO, 1.0);
        
        //蒙版新颜色
        CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0].CGColor);
        
        CGContextFillRect(ctx, self.maskLayer.frame);
        
        //转换坐标
        CGRect scanFrame = [self.view convertRect:self.scanView.frame fromView:self.scanView.superview];
        
        //空出中间一块
        CGContextClearRect(ctx, scanFrame);
    }
}

@end
