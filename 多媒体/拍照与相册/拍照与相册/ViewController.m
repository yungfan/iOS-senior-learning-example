//
//  ViewController.m
//  拍照与相册
//
//  Created by teacher on 17/5/22.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

- (IBAction)takePhoto:(id)sender;

- (IBAction)pickerPhoto:(id)sender;

- (IBAction)takeVedio:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property(nonatomic, strong) UIImagePickerController *pickerController;

@end



@implementation ViewController


-(UIImagePickerController *)pickerController{
    if (_pickerController == nil) {
        
        _pickerController = [[UIImagePickerController alloc]init];
        _pickerController.delegate = self;
        
    }

    return _pickerController;

}


- (void)viewDidLoad {
    
    [super viewDidLoad];

}

/**
 *  拍照
 */
- (IBAction)takePhoto:(id)sender {
    
    
    //1、创建UIImagePickerController对象。
    //2、指定拾取源，平时选择照片时使用的拾取源是照片库或者相簿，此刻需要指定为摄像头类型。
    self.pickerController.sourceType  = UIImagePickerControllerSourceTypeCamera;
    //3、指定摄像头，前置摄像头或者后置摄像头。
    self.pickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    //4、设置媒体类型mediaType，注意如果是录像必须设置，如果是拍照此步骤可以省略，因为mediaType默认包含kUTTypeImage（注意媒体类型定义在MobileCoreServices.framework中）
    //5、指定捕获模式，拍照或者录制视频。（视频录制时必须先设置媒体类型再设置捕获模式）
    self.pickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    
    //允许编辑图片 那么代理方法里需要相应地获取编辑后的图片
    self.pickerController.allowsEditing = YES;
    
    //6、展示UIImagePickerController(通常以模态窗口形式打开）。
    [self presentViewController:self.pickerController animated:YES completion:nil];

}


/**
 *  拍视频
 */
- (IBAction)takeVedio:(id)sender {
    
    //1、创建UIImagePickerController对象。
    //2、指定拾取源，平时选择照片时使用的拾取源是照片库或者相簿，此刻需要指定为摄像头类型。
    self.pickerController.sourceType  = UIImagePickerControllerSourceTypeCamera;
    //3、指定摄像头，前置摄像头或者后置摄像头。
    self.pickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    //4、设置媒体类型mediaType，注意如果是录像必须设置，如果是拍照此步骤可以省略，因为mediaType默认包含kUTTypeImage（注意媒体类型定义在MobileCoreServices.framework中）
    self.pickerController.mediaTypes = @[(NSString *)kUTTypeMovie];
    //5、指定捕获模式，拍照或者录制视频。（视频录制时必须先设置媒体类型再设置捕获模式）
    self.pickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    //6、展示UIImagePickerController(通常以模态窗口形式打开）。
    [self presentViewController:self.pickerController animated:YES completion:nil];

    
}


/**
 *  从相册取照片
 */
- (IBAction)pickerPhoto:(id)sender {
    
    self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    self.pickerController.allowsEditing = YES;
    
    [self presentViewController:self.pickerController animated:YES completion:nil];
    
}


//拍照、选照片、拍视频成功
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {//如果是拍照
    
        [self.pickerController dismissViewControllerAnimated:YES completion:nil];
    
        //UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];//获取编辑后的照片
        
        UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];//获取原始照片
    
        self.image.image = image;
    
        
        if (picker.sourceType != UIImagePickerControllerSourceTypePhotoLibrary) {
            //拍照后需要保存到相册就加上这句话
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        }
        
        

    }
    
    else{
        
        [self.pickerController dismissViewControllerAnimated:YES completion:nil];
        
        NSURL *vedioPath = [info objectForKey:UIImagePickerControllerMediaURL];
        
        UISaveVideoAtPathToSavedPhotosAlbum([vedioPath path], nil, nil, nil);
    
    }
}

//取消操作
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    [self.pickerController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"取消");

}
@end
