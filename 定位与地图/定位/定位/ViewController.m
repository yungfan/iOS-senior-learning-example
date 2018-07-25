//
//  ViewController.m
//  定位
//
//  Created by teacher on 17/4/7.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface ViewController ()<CLLocationManagerDelegate>

@property(nonatomic, strong) CLLocationManager *manager;

@end

@implementation ViewController

- (CLLocationManager *)manager{

    if (_manager == nil) {
        
        _manager = [[CLLocationManager alloc]init];
        
        _manager.delegate = self;
    
        
        //后台定位
        
        //第一种方法：调用requestWhenInUseAuthorization &&  _manager.allowsBackgroundLocationUpdates = YES; && 打开后胎定位的开关  ==> 结果是 能后台定位但是会有个大蓝条
//        _manager.allowsBackgroundLocationUpdates = YES;
//        
//        [_manager requestWhenInUseAuthorization];
        
        
        
        //第二种方法：调用requestAlwaysAuthorization即可 ==> 结果是 能后台定位 并且不会出现大蓝条
        [_manager requestAlwaysAuthorization];

    }

    return _manager;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
    [self.manager startUpdatingLocation];

}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{

    NSLog(@"定位到了");
    
    
    CLLocation *location = [locations lastObject];
    
    NSLog(@"%f--%f", location.coordinate.longitude, location.coordinate.latitude);
    
    
    //反地理编码 转换成 具体的地址
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        //CLPlacemark －－ 国家 城市 街道
        
        CLPlacemark *mark = [placemarks lastObject];
        
        NSLog(@"%@ --- %@ --- %@", mark.region, mark.name, mark.locality);
        
    }];
    
    
    [self.manager stopUpdatingLocation];

}

@end
