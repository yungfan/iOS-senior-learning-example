//
//  ViewController.m
//  集成高德地图
//
//  Created by teacher on 17/4/26.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "ViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

#import <AMapLocationKit/AMapLocationKit.h>

@interface ViewController ()<AMapLocationManagerDelegate>

@property(nonatomic, strong) AMapLocationManager *locationManager;
@property(nonatomic, assign) NSInteger count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.count = 0;
    
    [self backgroundLoaction];
    
    
}

#pragma mark - 持续定位
-(void)backgroundLoaction{
    
    //初始化定位管理器
    self.locationManager = [[AMapLocationManager alloc]init];
    // 设置代理对象
    self.locationManager.delegate = self;
    // 设置反地理编码
    self.locationManager.locatingWithReGeocode = YES;
    //iOS9之前的定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    //iOS9设置后台定位
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
        self.locationManager.allowsBackgroundLocationUpdates = YES;
    }
    //开启持续定位
    [self.locationManager startUpdatingLocation];
    
}


#pragma mark - 持续定位
-(void)alwaysLoaction{
    
    //初始化定位管理器
    self.locationManager = [[AMapLocationManager alloc]init];
    // 设置代理对象
    self.locationManager.delegate = self;
    // 设置反地理编码
    self.locationManager.locatingWithReGeocode = YES;
    //开启持续定位
    [self.locationManager startUpdatingLocation];
    
}


#pragma mark - 单次定位
-(void)onceLoaction{
    
    //初始化定位管理器
    self.locationManager = [[AMapLocationManager alloc]init];
    //单次定位
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        NSLog(@"%@", regeocode);
        
    }];
}


#pragma mark - 2个代理方法
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    
    NSLog(@"我是个倒霉蛋，我不会被调用");
    
}

//若实现了下面的回调，将不会再回调amapLocationManager:didUpdateLocation:方法。
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
    
    if (reGeocode)
    {
        NSLog(@"reGeocode:%@", reGeocode);
    }
    
    self.count++;
    
    if (self.count == 10) {
        [self.locationManager stopUpdatingLocation];
    }
    
}


@end
