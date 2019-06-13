//
//  ViewController.m
//  地图添加标注
//
//  Created by student on 2019/4/25.
//  Copyright © 2019 student. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"


@interface ViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>

@property(nonatomic, strong) CLLocationManager *manager;

@property (weak, nonatomic) IBOutlet MKMapView *map;

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


//点击地图的任一位置 都可以插入一个标注，标注的标题和副标题显示的是具体位置
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    //点击屏幕产生的坐标如何与地图的经纬度进行转换？
    
    //1.获取点击的坐标
    CGPoint touchPoint = [touches.anyObject locationInView:self.map];
    
    //2.将点击的坐标转换成经纬度
    CLLocationCoordinate2D coordinate =  [self.map convertPoint:touchPoint toCoordinateFromView:self.map];
    
    NSLog(@"%@", NSStringFromCGPoint(touchPoint));
   
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
    
    //1.从重用池取MKPinAnnotationView
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"abc"];
    
    //2.没有的时候创建
    if(annotationView == nil) {
        
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"abc"];
        
    }
    
    //设置棒棒糖的颜色
    annotationView.pinTintColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    
    //显示气泡
    annotationView.canShowCallout = YES;
    
    //添加的时候有动画
    annotationView.animatesDrop = YES;

    //可以拖拽
    annotationView.draggable = YES;
    
    return  annotationView;
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

//点击Annotation事件
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
    
    NSLog(@"%s", __func__);
    
}

@end

