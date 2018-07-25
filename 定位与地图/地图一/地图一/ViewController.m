//
//  ViewController.m
//  地图一
//
//  Created by teacher on 17/4/10.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

//地图想显示用户的位置，必须要与定位结合起来，只靠self.map.userTrackingMode = MKUserTrackingModeFollowWithHeading;是不行的


@interface ViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *map;

@property(nonatomic, strong) CLLocationManager *manager;

@end

@implementation ViewController

- (CLLocationManager *)manager{
    
    if (_manager == nil) {
        
        _manager = [[CLLocationManager alloc]init];
        
        _manager.delegate = self;
        
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        
        [_manager requestWhenInUseAuthorization];
        
    }
    
    return _manager;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self manager];
    
   // self.map.mapType = MKMapTypeSatellite;
    
    self.map.delegate = self;
    
    self.map.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    
//    self.map.showsUserLocation = YES;
}


//定位是很准的  这个代理方法必须要求 showsUserLocation = YES; || userTrackingMode = MKUserTrackingModeFollowWithHeading | MKUserTrackingModeFollow
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{

    
    userLocation.title = @"商贸学院";
    userLocation.subtitle = @"励能楼1";
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        
        CLPlacemark *mark = [placemarks lastObject];
        
         NSLog(@"%@", mark.addressDictionary);
        
    }];
    
  


}


@end
