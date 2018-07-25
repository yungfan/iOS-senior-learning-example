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


@interface ViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *map;
- (IBAction)addAnnotation:(id)sender;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.map.delegate = self;

}

/**
 *  点击地图的任一位置 都可以插入一个大头针，大头针的标题和副标题显示的是大头针的具体位置
 *
 */
#pragma mark - 决定有没有大头针
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint touchPoint = [[touches anyObject] locationInView:self.map];
    
    
    MyAnnotation *annotation = [[MyAnnotation alloc]init];
    
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
    
    
    
    //添加一个圆形到地图上
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:coordinate radius:1000];
    
    [self.map addOverlay:circle];

    
    

}


/*
 
 * 大头针分两种
 
 * 1. MKPinAnnotationView：他是系统自带的大头针，继承于MKAnnotationView，形状跟棒棒糖类似，可以设置糖的颜色，和显示的时候是否有动画效果
 
 * 2. MKAnnotationView：可以用指定的图片作为大头针的样式，但显示的时候没有动画效果，如果没有给图片的话会什么都不显示
 
 * 3. 在这里我为了自定义大头针的样式，使用的是MKAnnotationView
 
 */
#pragma mark - 决定大头针长什么样
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    static NSString *Id  = @"ABC";
    
    MKAnnotationView *mkav = [mapView dequeueReusableAnnotationViewWithIdentifier:Id];
    
    if (mkav == nil) {
        
        mkav = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:Id];
        
    }
    
    mkav.canShowCallout = YES;
    
    //随机产生0-10的一个整数
    int i = arc4random()%11;
    
    NSString *imgName = [NSString stringWithFormat:@"icon_map_cateid_%d", i];
    //NSString *imgName = [NSString stringWithFormat:@"1"];
    mkav.image = [UIImage imageNamed:imgName];
    
    
    UIImage *leftImage = [UIImage imageNamed:@"icon_listheader_animation_1"];
    UIImage *rightImage = [UIImage imageNamed:@"icon_listheader_animation_2"];
    
    //弹出的起泡的左右视图与详细视图
    mkav.leftCalloutAccessoryView = [[UIImageView alloc]initWithImage:leftImage];
    mkav.rightCalloutAccessoryView = [[UIImageView alloc]initWithImage:rightImage];
    mkav.detailCalloutAccessoryView = [UISwitch new];
    
    return mkav;
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
    NSLog(@"%s", __func__);

}

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
    
    NSLog(@"%s", __func__);


}


//在这里添加Annotation
- (IBAction)addAnnotation:(id)sender {
    
    
    CGPoint touchPoint = CGPointMake(arc4random() % 400, arc4random()%700);
    
    
    MyAnnotation *annotation = [[MyAnnotation alloc]init];
    
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
