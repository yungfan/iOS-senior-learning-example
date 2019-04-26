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
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self locate];
    
}

-(void)locate{
    
    //初始化AMapLocationManager对象，设置代理。
    self.locationManager = [[AMapLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    
    //设置定位最小更新距离方法如下，单位米
    self.locationManager.distanceFilter = 200;
    
    //设置反地理编码
    [self.locationManager setLocatingWithReGeocode:YES];
    
    //后台定位
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
        self.locationManager.allowsBackgroundLocationUpdates = YES;
    }
    //开始持续定位
    [self.locationManager startUpdatingLocation];
}

//接收定位结果
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode {
    
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    
    if (manager.locatingWithReGeocode) {
        
        NSLog(@"reGeocode:%@", reGeocode);
    }
}


//iOS 11以后必须实现该方法 并且在该方法里发起授权 否则无法定位
-(void)amapLocationManager:(AMapLocationManager *)manager doRequireLocationAuth:(CLLocationManager *)locationManager{
        
    [locationManager requestAlwaysAuthorization];
}

@end
