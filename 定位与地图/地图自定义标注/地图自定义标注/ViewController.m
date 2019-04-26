//
//  ViewController.m
//  地图自定义标注
//
//  Created by student on 2019/4/26.
//  Copyright © 2019 student. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"


@interface ViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>

@property(nonatomic, strong) CLLocationManager *manager;

@property (weak, nonatomic) IBOutlet MKMapView *map;

- (IBAction)addAnnotation:(id)sender;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _manager = [[CLLocationManager alloc]init];
    
    [_manager requestAlwaysAuthorization];
    
    _map.showsUserLocation = YES;
    
    _map.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 
 * 标注分三种
 * 1. MKPinAnnotationView：他是系统自带的大头针样式，继承于MKAnnotationView，形状跟棒棒糖类似，可以设置糖的颜色，和显示的时候是否有动画效果
 * 2. MKAnnotationView：可以用指定的图片作为标注的样式，但显示的时候没有动画效果，如果没有给图片的话会什么都不显示
 * 3. MKMarkerAnnotationView  iOS11新增的API，使用它最简单，不需要实现代理方法，直接添加标注即可
 */

/**
 *  每当添加一个标注该方法被调用。如果该方法没有实现, 或者返回nil, 那么就会使用系统默认的标注视图（iOS 11之后是MKMarkerAnnotationView）
 *  如果我希望自定义，怎么办？该方法的返回值就是你自定义的的样式
 *  该方法非常类似 cellForRowAtIndex（返回的是用户定义的一个cell）
 *  参数中的annotation就是自己添加的MyAnnotation对象 自动会传递过来
 *  第一次定位成功以后也会调用一次该方法 显示用户位置 此时传进来的annotation参数是MKUserLocation
 */
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    
    //判断是不是用户的数据模型 让用户位置的标注不一样
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        
        return  nil;
    }
    
    //1.从重用池取MKAnnotationView
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"abc"];
    
    //2.没有的时候创建
    if(annotationView == nil) {
        
        annotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"abc"];
        
    }
    
    
    //设置标注的图片
    int i =  arc4random() % 11;
    
    NSString *imgName = [NSString stringWithFormat:@"icon_map_cateid_%d", i];
    
    annotationView.image = [UIImage imageNamed:imgName];
    
    //左边视图
    annotationView.leftCalloutAccessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"left"]];
    
    //右边视图
    annotationView.rightCalloutAccessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"right"]];
    
    
    
    annotationView.canShowCallout = YES;

    return  annotationView;
}


//点击标注时会调用
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
    
    NSLog(@"%s", __func__);
    
}

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
    
    NSLog(@"%s", __func__);
    
}

//百度和高德可以设置调用频率：distanceFilter 和 desiredAccuracy 范围和精度
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


//点击 + 添加标注
- (IBAction)addAnnotation:(id)sender {
    
    //点击屏幕产生的坐标如何与地图的经纬度进行转换？
    
    NSInteger w = (NSInteger)[UIScreen mainScreen].bounds.size.width;
    NSInteger h = (NSInteger)[UIScreen mainScreen].bounds.size.height;
    
    //1.获取随机的坐标
    CGPoint  anyPoint = CGPointMake( arc4random() % w, arc4random() % h);
    
    //2.将点击的坐标转换成经纬度
    CLLocationCoordinate2D coordinate =  [self.map convertPoint:anyPoint toCoordinateFromView:self.map];
    
    NSLog(@"%@", NSStringFromCGPoint(anyPoint));
    
    NSLog(@"%f-- %f", coordinate.latitude, coordinate.longitude);
    
    //3.添加标注 分三步
    //(1)创建标注模型 (2)重写地图的代理方法 返回标注的样式 (3)将标注添加到地图
    
    MyAnnotation *annotation = [[MyAnnotation alloc]init];
    
    annotation.coordinate = coordinate;
    
    //反地理编码添加标注的气泡信息
    CLLocation *location = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *mark = placemarks.firstObject;
        
        annotation.title = mark.locality;
        
        annotation.subtitle = mark.thoroughfare;
        
    }];
    
    
    [self.map addAnnotation:annotation];
    
    //添加一个圆形到地图上 半径100米
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:coordinate radius:100];
    
    [self.map addOverlay:circle];
}

//添加圆形区域
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    
    // 创建圆形区域渲染对象
    if ([overlay isKindOfClass:[MKCircle class]])
    {
        MKCircleRenderer *circleRender = [[MKCircleRenderer alloc] initWithOverlay:overlay];
        
        circleRender.fillColor = [UIColor cyanColor];
        
        circleRender.alpha = 0.3;
        
        return circleRender;
    }
    return nil;
    
}

@end
