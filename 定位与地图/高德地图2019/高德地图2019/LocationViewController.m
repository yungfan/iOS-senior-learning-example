//
//  ViewController.m
//  高德地图2019
//
//  Created by student on 2019/4/26.
//  Copyright © 2019 student. All rights reserved.
//

#import "LocationViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>

@interface LocationViewController () <AMapLocationManagerDelegate>

@property (nonatomic, strong) AMapLocationManager *locationManager;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.redColor;
    
    
    //初始化AMapLocationManager对象，设置代理。
    self.locationManager = [[AMapLocationManager alloc] init];
    
    //设置代理
    self.locationManager.delegate = self;
    
    //设置定位最小更新距离方法如下，单位米
    self.locationManager.distanceFilter = 200;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self continueLocate];
    
}

//持续定位
-(void)continueLocate{
    
    [self.locationManager setLocatingWithReGeocode:YES];
    
    [self.locationManager startUpdatingLocation];
}

//单次定位
-(void)onceLocate{
    
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error) {
            
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed) {
                return;
            }
        }
        
         NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
        
        if (regeocode) {
            NSLog(@"reGeocode:%@", regeocode);
        }
    }];
    
}


//后台定位
-(void)backLocate{
    
    //设置反地理编码
    [self.locationManager setLocatingWithReGeocode:YES];
    
    //后台定位
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
        self.locationManager.allowsBackgroundLocationUpdates = YES;
    }
    //开始持续定位
    [self.locationManager startUpdatingLocation];
}

#pragma mark - 2个代理方法 接收定位结果
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    
}

//若实现了下面的回调，将不会再回调上面的 amapLocationManager:didUpdateLocation:方法。
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode {
    
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    
    if (manager.locatingWithReGeocode) {
        
        NSLog(@"reGeocode:%@", reGeocode);
    }
}


//千万注意：iOS 11以后必须实现该方法 并且在该方法里发起授权 否则无法定位
-(void)amapLocationManager:(AMapLocationManager *)manager doRequireLocationAuth:(CLLocationManager *)locationManager{
    
    [locationManager requestAlwaysAuthorization];
}

@end
