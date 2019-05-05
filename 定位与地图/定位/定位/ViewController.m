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
        
        _manager.desiredAccuracy = 1000.0;
        
        _manager.delegate = self;
        
        //后台定位
        
        //第一种方法：调用requestWhenInUseAuthorization &&  _manager.allowsBackgroundLocationUpdates = YES; && 打开后胎定位的开关  ==> 结果是 能后台定位但是会有个大蓝条
        _manager.allowsBackgroundLocationUpdates = YES;
        //
        [_manager requestWhenInUseAuthorization];
        
        
        
        //第二种方法：调用requestAlwaysAuthorization即可 ==> 结果是 能后台定位 并且不会出现大蓝条
        //[_manager requestAlwaysAuthorization];


        
        //注意： https://developer.apple.com/search/?q=NSLocationUsageDescription
        //一、iOS 8之前只需要配置
            //Privacy - Location Usage Description
        
        //二、iOS8 - iOS 10 只有两个配置
            //Privacy - Location Always Usage Description 申请Always权限，以便应用在前台和后台都可以获取到更新的位置数据。
            //Privacy - Location When In Use Usage Description 表示应用在前台的时候可以搜到更新的位置信息。
        
        //三、iOS11之后多了
            //Privacy - Location Always and When In Use Usage Description 申请Always权限，以便应用在前台和后台都可以获取到更新的位置数据。
        
        //所以iOS11之后必须配置的是
            //Privacy - Location When In Use Usage Description
            //Privacy - Location Always and When In Use Usage Description
        
        
        //如果需要同时支持在iOS8之后的系统上后台定位，在plist文件中同时添加
            //Privacy - Location Always Usage Description
            //Privacy - Location Always and When In Use Usage Description
            //Privacy - Location When In Use Usage Description
        
    
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

    //定位之前调用如下判断一下定位是否可用
    //if (CLLocationManager.locationServicesEnabled) {
        
    //}
    
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
        
        NSLog(@"%@ --- %@ --- %@ --- %@", mark.country, mark.locality, mark.subLocality, mark.name);
        
    }];
    
    //停止定位
    //[self.manager stopUpdatingLocation];

}

@end
