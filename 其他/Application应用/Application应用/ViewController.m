//
//  ViewController.m
//  Application应用
//
//  Created by student on 2018/6/15.
//  Copyright © 2018年 student. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>
#import <WebKit/WebKit.h>

@interface ViewController () <MFMessageComposeViewControllerDelegate>
- (IBAction)phone:(id)sender;
- (IBAction)message:(id)sender;
- (IBAction)email:(id)sender;
- (IBAction)pdf:(id)sender;

@property (nonatomic,strong) WKWebView *webview;

@property (nonatomic,strong) MFMessageComposeViewController *vc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

//打电话
- (IBAction)phone:(id)sender {
    
    
    //方式1 最简单最直接的方式：直接跳到拨号界面 电话打完后，不会自动回到原应用，直接停留在通话记录界面
    //tel://
    NSURL *url = [NSURL URLWithString:@"tel://10000"];
    
    [[UIApplication sharedApplication] openURL:url];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://111111"] options:@{} completionHandler:nil];
    });
    
    
    //方式2 WebView方式 创建一个UIWebView来加载URL，拨完后能自动回到原应用 这个webView千万不要添加到界面上来，不然会挡住其他界面
    
   self.webview = [[WKWebView alloc] initWithFrame:CGRectZero];

   [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://10000"]]];
}

- (IBAction)message:(id)sender {
    
    //方式1 直接跳到发短信界面，但是不能指定短信内容，而且不能自动回到原应用
    //sms://
//    NSURL *url = [NSURL URLWithString:@"sms://10000"];
//    
//    [[UIApplication sharedApplication] openURL:url];
    
    
    //方式2 如果想指定短信内容，那就得使用MessageUI框架
    
    if([MFMessageComposeViewController canSendText]) {
        
        self.vc = [[MFMessageComposeViewController alloc] init];
        // 设置短信内容
        self.vc.body = @"吃饭了没？";
        // 设置收件人列表
        self.vc.recipients = @[@"10010", @"02010010"];
        // 设置代理
        self.vc.messageComposeDelegate = self;
        
        // 显示控制器
        [self presentViewController:self.vc animated:YES completion:nil];
    }
    
    else{
    
        NSLog(@"不支持");
    
    }

    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
    // 关闭短信界面
    
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MessageComposeResultCancelled) {
        
        NSLog(@"取消发送");
        
    } else if (result == MessageComposeResultSent) {
        
        NSLog(@"已经发出");
        
    } else {
        
        NSLog(@"发送失败");
        
    }
    
}

- (IBAction)email:(id)sender {
    
    
    //mailto://
    NSURL *url = [NSURL URLWithString:@"mailto://yangfanvw@qq.com"];
    
    [[UIApplication sharedApplication] openURL:url];
    
}

- (IBAction)pdf:(id)sender {
    
    self.webview = [[WKWebView alloc]initWithFrame:self.view.frame];
    
    [self.view addSubview:self.webview];
    
    //[self loadDocument:@"aa.pdf" inView:self.webview];
    
    //[self loadDocument:@"bb.docx" inView:self.webview];
    
    [self loadDocument:@"cc.pptx" inView:self.webview];
}


-(void)loadDocument:(NSString *)documentName inView:(WKWebView *)webView{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:nil];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    
}


@end
