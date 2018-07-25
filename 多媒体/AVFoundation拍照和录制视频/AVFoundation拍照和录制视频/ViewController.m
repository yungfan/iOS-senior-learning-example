//
//  ViewController.m
//  AVFoundation拍照和录制视频
//
//  Created by student on 2018/6/4.
//  Copyright © 2018年 student. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (strong,nonatomic) AVCaptureSession *captureSession;//负责输入和输出设备之间的数据传递
@property (strong,nonatomic) AVCaptureDeviceInput *input;//负责从AVCaptureDevice获得输入数据
@property (strong,nonatomic) AVCaptureStillImageOutput *output;//照片输出流
@property (strong,nonatomic) AVCaptureDevice *device;//输入设备
@property (strong,nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;//相机拍摄预览图层


@end

@implementation ViewController


#pragma mark - 懒加载

//创建绘画
-(AVCaptureSession *)captureSession{
    
    if (_captureSession == nil) {
        
        _captureSession = [[AVCaptureSession alloc]init];
        
        //将数据输入对象AVCaptureDeviceInput、数据输出对象AVCaptureOutput添加到媒体会话管理对象AVCaptureSession中。
        
        if ([_captureSession canAddInput:self.input]) {
            
              [_captureSession addInput:self.input];
            
        }
        
        if ([_captureSession canAddOutput:self.output]) {
            
            [_captureSession addOutput:self.output];
            
        }
    }
    
    
    return _captureSession;
    
}


//输入输出设备
-(AVCaptureDevice *)device{
    
    if (_device == nil) {
        
        //使用AVCaptureDevice的静态方法获得需要使用的设备，例如拍照和录像就需要获得摄像头设备，录音就要获得麦克风设备。
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
    }
    return _device;
    
}


//输入设备
-(AVCaptureDeviceInput *)input{
    
    if (_input == nil) {
        
         NSError *error=nil;
        //利用输入设备AVCaptureDevice初始化AVCaptureDeviceInput对象。
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
        
        if (error) {
            
            NSLog(@"取得设备输入对象时出错，错误原因：%@",error.localizedDescription);
            
            return nil;
        }
        
    }
    
    return  _input;
    
}


//输出设备
-(AVCaptureStillImageOutput *)output{
    
    if (_output == nil) {
        
        //初始化输出数据管理对象，如果要拍照就初始化AVCaptureStillImageOutput对象；如果拍摄视频就初始化AVCaptureMovieFileOutput对象。
        _output = [[AVCaptureStillImageOutput alloc]init];
        
    }
    
    return  _output;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //创建视频预览图层AVCaptureVideoPreviewLayer并指定媒体会话，添加图层到显示容器中，调用AVCaptureSession的startRuning方法开始捕获。
    
    self.captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    
    self.captureVideoPreviewLayer.frame = self.view.frame;
    
     [self.view.layer insertSublayer:self.captureVideoPreviewLayer atIndex:0];

    
}


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self.captureSession startRunning];
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    [self.captureSession stopRunning];
}

@end
