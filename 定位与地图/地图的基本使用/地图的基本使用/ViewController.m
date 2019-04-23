//
//  ViewController.m
//  地图的基本使用
//
//  Created by student on 2019/4/23.
//  Copyright © 2019 student. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()<MKMapViewDelegate>

//地图 很多属性都在SB中配置了
@property (weak, nonatomic) IBOutlet MKMapView *map;

@property (strong, nonatomic) CLLocationManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self showUserInfo];
    
}


// 如果想显示用户的位置 只需要下面三行代码
-(void)showUser{
    
    _manager = [[CLLocationManager alloc]init];
    
    [_manager requestAlwaysAuthorization];
    
    _map.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    
}


// 改变用户蓝点点击后的气泡信息
-(void)showUserInfo{
    
    _map.delegate = self;
    
    [self showUser];
    
}


//通过代理改变userLocation的标题实现更改信息
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
   
    CLLocation *location =  userLocation.location;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *mark = placemarks.firstObject;
        
        userLocation.title = mark.locality;
        
        userLocation.subtitle = mark.thoroughfare;
  
    }];
    
    //NSLog(@"%s", __func__);
    
}
@end
