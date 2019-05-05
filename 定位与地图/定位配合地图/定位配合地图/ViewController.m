//
//  ViewController.m
//  定位配合地图
//
//  Created by student on 2019/4/23.
//  Copyright © 2019 student. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "WGS84ConvertToGCJ02ForAMapView.h"


@interface ViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>

@property(nonatomic, strong) CLLocationManager *manager;

@property (weak, nonatomic) IBOutlet MKMapView *map;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
   
    _manager = [[CLLocationManager alloc]init];
    
    //_manager.delegate = self;
    
    [_manager requestAlwaysAuthorization];
    
    _map.showsUserLocation = YES;
    
    [_manager startUpdatingLocation];
    
    _map.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//如何通过定位到的位置 设置地图的“缩放级别”?
//通过设置地图的MKCoordinateRegion达到，这里有两种方案

//方案一
//如果是通过CLLocationManagerDelegate必须进行坐标的转换
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{

    CLLocation *location = [locations lastObject];
    
    //判断是不是属于国内范围
    if (![WGS84ConvertToGCJ02ForAMapView isLocationOutOfChina:[location coordinate]]) {
        //转换后的coord
        CLLocationCoordinate2D coord = [WGS84ConvertToGCJ02ForAMapView transformFromWGSToGCJ:[location coordinate]];
        
        location = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
    }
   
    //设置地图显示的“区域”
    
    //跨度
    MKCoordinateSpan span = MKCoordinateSpanMake(0.013, 0.013);
    
    //区域
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, span);
    
    //让地图显示设置的区域
    [_map setRegion:region];
    
    //停止定位
    [self.manager stopUpdatingLocation];
    
}

//方案二 推荐使用
//如果是通过MKMapViewDelegate不需要进行坐标的转换
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    CLLocation *location = userLocation.location;
    
    //设置地图显示的“区域”
    
    //跨度
    MKCoordinateSpan span = MKCoordinateSpanMake(0.013, 0.013);
    
    //区域
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, span);
    
    //让地图显示设置的区域
    [_map setRegion:region];
    
}

@end
