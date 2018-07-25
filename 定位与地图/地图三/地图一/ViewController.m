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
#import "MyAnnotation.h"


@interface ViewController ()<MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *map;

@property(nonatomic, strong) CLLocationManager *CLManager;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLLocationManager *manager = [[CLLocationManager alloc]init];
    
    manager.delegate = self;
    
    [manager requestWhenInUseAuthorization];
    
    [manager startUpdatingLocation];
    
    
    
    manager.desiredAccuracy=kCLLocationAccuracyBest;//指定需要的精度级别
    
    manager.distanceFilter=1000.0f;//设置距离筛选器
    
    self.CLManager = manager;
    
    self.map.delegate = self;
    
    self.map.showsUserLocation = YES;
    
}

/**
 *  点击地图的任一位置 都可以插入一个大头针，大头针的标题和副标题显示的是大头针的具体位置
 *
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint touchPoint = [[touches anyObject] locationInView:self.map];
    
    
    MyAnnotation *annotation = [[MyAnnotation alloc]init];
    
    NSLog(@"%s -- %@", __func__, annotation);
    
    //将坐标转换成为经纬度,然后赋值给大头针
    
    CLLocationCoordinate2D coordinate = [self.map convertPoint:touchPoint toCoordinateFromView:self.map];
    
    annotation.coordinate = coordinate;
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    
    CLLocation *location = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    
    //大头针显示地理位置
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *mark = [placemarks lastObject];
        
        annotation.title = mark.addressDictionary[@"State"];
        
        annotation.subtitle = mark.addressDictionary[@"SubLocality"];
        
        [self.map addAnnotation:annotation];
        
    }];
    

}


/*
 
 * 大头针分两种
 * 1. MKPinAnnotationView：他是系统自带的大头针，继承于MKAnnotationView，形状跟棒棒糖类似，可以设置糖的颜色，和显示的时候是否有动画效果
 * 2. MKAnnotationView：可以用指定的图片作为大头针的样式，但显示的时候没有动画效果，如果没有给图片的话会什么都不显示
 */

/**
 *  每当添加一个大头针 该方法被调用。如果该方法没有实现, 或者返回nil, 那么就会使用系统默认的大头针视图
 *  如果我希望自定义，怎么办？该方法的返回值就是你自定义的的大头针
 *  该方法非常类似 cellForRowAtIndex（返回的是用户定义的一个cell）
 *  参数中的annotation就是自己添加的MyAnnotation对象 自动会传递过来
 *  第一次定位成功以后也会调用一次该方法 显示用户位置 此时传进来的annotation参数是MKUserLocation
 */
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    //判断是不是用户的大头针数据模型 让用户位置的大头针和其他的大头针不一样
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        
        MKAnnotationView *annotationView = [[MKAnnotationView alloc]init];
        
        annotationView.image = [UIImage imageNamed:@"ic_location_classic"];
        
        return annotationView;
    }
    
    
    
    static NSString *Id  = @"ABC";
    
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:Id];
    
    if (pin == nil) {
        
        //这里初始化的时候 可以将annotation传入
        pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:Id];
        
        NSLog(@"%s -- %@", __func__, annotation);
        
    }
    
    pin.canShowCallout = YES;
    
    pin.pinTintColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    
    pin.animatesDrop = YES;
    
    pin.draggable = YES;
    
    return pin;
}


//这种方式地图显示的中心不是定位的位置 设置了中心点也不行

//- (void)locationManager:(CLLocationManager *)manager
//     didUpdateLocations:(NSArray<CLLocation *> *)locations{
//
//
//    CLLocation *location = [locations lastObject];
//    
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.003, 0.003);
//    
//    [self.map setCenterCoordinate:location.coordinate animated:YES];
//    
//    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, span);
//
//    [self.map setRegion:region animated:YES];
//    
//
//    [self.CLManager stopUpdatingLocation];
//
//}



//这种方式在不断回调该方法 百度和高德可以设置调用频率：distanceFilter 和 desiredAccuracy 范围和精度
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    NSLog(@"%s", __func__);
    
    CLLocation *location = userLocation.location;
    
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.003, 0.003);
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, span);

    [mapView setRegion:region animated:YES];
    
    
    [self.CLManager stopUpdatingLocation];
    
}

@end
