//
//  ViewController.m
//  NSURLSession案例
//
//  Created by 杨帆 on 17/2/19.
//  Copyright © 2017年 yangfan. All rights reserved.
//

#import "ViewController.h"

#define YFBoundary @"AnHuiWuHuYungFan"
#define YFEnter [@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]
#define YFEncode(string) [string dataUsingEncoding:NSUTF8StringEncoding]

@interface ViewController ()<NSURLSessionTaskDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *uploadProgress;

@property (weak, nonatomic) IBOutlet UILabel *uploadInfo;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    //1、确定URL
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.5/AppTestAPI/UploadServlet"];
    
    //2、确定请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //3、设置请求头
//    NSString *head = [NSString stringWithFormat:@"multipart/form-data;boundary=%--@", YFBoundary];
    NSString *head = [NSString stringWithFormat:@"multipart/form-data;boundary=%@", YFBoundary];
    [request setValue:head forHTTPHeaderField:@"Content-Type"];
    
 

    //4、设置请求方式
    request.HTTPMethod = @"POST";
   
    //5、创建NSURLSession
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
   
    //6、获取上传的数据
    NSData *uploadData = [self getData];
    
    //7、创建上传任务 上传的数据来自getData方法
    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request fromData:uploadData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
       self.uploadInfo.text =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    }];
    //8、执行上传任务
    [task resume];
    
}


/**
 *  设置请求体
 *
 *  @return 请求体内容
 */
-(NSData *)getData
{

    NSMutableData *data = [NSMutableData data];
    
    //1、开始标记
    //--
    [data appendData:YFEncode(@"--")];
    //boundary
    [data appendData:YFEncode(YFBoundary)];
    //换行符
    [data appendData:YFEnter];
    //文件参数名 Content-Disposition: form-data; name="myfile"; filename="wall.jpg"
    [data appendData:YFEncode(@"Content-Disposition:form-data; name=\"myfile\"; filename=\"wall.jpg\"")];
    //换行符
    [data appendData:YFEnter];
    //Content-Type 上传文件的类型 MIME
    [data appendData:YFEncode(@"Content-Type:image/jpeg")];
    //换行符
    [data appendData:YFEnter];
	//换行符
    [data appendData:YFEnter];
    //2、上传的文件数据
    
    //图片数据  并且转换为Data
    UIImage *image = [UIImage imageNamed:@"wall.jpg"];
    NSData *imagedata = UIImageJPEGRepresentation(image, 1.0);
    [data appendData:imagedata];
    //换行符
    [data appendData:YFEnter];
 
    //3、结束标记
    //--
    [data appendData:YFEncode(@"--")];
    //boundary
    [data appendData:YFEncode(YFBoundary)];
    //--
    [data appendData:YFEncode(@"--")];
    //换行符
    [data appendData:YFEnter];
	
    return data;
    
}


#pragma mark - 代理方法 只要给服务器上传数据就会调用 可以计算出上传进度
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    self.uploadProgress.progress = 1.0 * totalBytesSent / totalBytesExpectedToSend;
}




@end
