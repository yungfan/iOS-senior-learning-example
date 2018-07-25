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
#import "WGS84ConvertToGCJ02ForAMapView.h"


// http://blog.csdn.net/u010731949/article/details/53393708
//芜湖	118.38	减0小时6分29秒	31.33

@interface ViewController ()<CLLocationManagerDelegate>

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
    
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.manager startUpdatingLocation];
    
    //地图的类型
    self.map.mapType = MKMapTypeStandard;
    //显示用户的位置
    self.map.showsUserLocation = YES;
    
    
    
    // 设置中心点不设置“缩放级别” 默认还是显示中国板块，但确实设置了中心点，只是没有设置显示区域 无法缩放
    // CLLocationCoordinate2D location2D = CLLocationCoordinate2DMake(31.3524600000,118.4331300000);
    // [self.mapView setCenterCoordinate:location2D animated:YES];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    
    NSLog(@"定位到了");
    
    CLLocation *location = [locations lastObject];
    
    
    //判断是不是属于国内范围
    if (![WGS84ConvertToGCJ02ForAMapView isLocationOutOfChina:[location coordinate]]) {
        //转换后的coord
        CLLocationCoordinate2D coord = [WGS84ConvertToGCJ02ForAMapView transformFromWGSToGCJ:[location coordinate]];
        location = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
    }
    
    
    //设置显示区域 其实就是设置“缩放级别”
    
    //    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1.0, 1.0);
    //
    //    MKCoordinateRegion adjustedRegion = [self.map regionThatFits:region];
    //
    //    [self.map setRegion:adjustedRegion animated:YES];
    
    
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.003, 0.003);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, span);
    
    [self.map setRegion:region animated:YES];
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *mark = [placemarks lastObject];
        
        NSLog(@"%@", mark.addressDictionary);
        
    }];
    
    [self.manager stopUpdatingLocation];
    
}

@end
