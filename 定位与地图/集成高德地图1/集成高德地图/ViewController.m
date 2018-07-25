//
//  ViewController.m
//  集成高德地图
//
//  Created by teacher on 17/4/26.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface ViewController ()<MAMapViewDelegate>

@property(nonatomic, strong) MAMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView = [[MAMapView alloc]initWithFrame:self.view.frame];
    
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    
    [AMapServices sharedServices].enableHTTPS = YES;
    
    self.mapView.showsUserLocation = YES;
    
    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    
    [self.mapView setZoomLevel:17 animated:YES];
    
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    //定位小蓝点自定义 -- 如果想完全自定义－自己添加一个Annotation
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
       r.showsAccuracyRing = NO;///精度圈是否显示，默认YES
    //r.fillColor = [UIColor redColor];///精度圈 填充颜色, 默认 kAccuracyCircleDefaultColor
    //r.strokeColor = [UIColor orangeColor];///精度圈 边线颜色, 默认 kAccuracyCircleDefaultColor
    r.image = [UIImage imageNamed:@"Expression_49"];
//    r.enablePulseAnnimation = NO;///内部蓝色圆点是否使用律动效果, 默认YES
//    r.locationDotBgColor = [UIColor greenColor];///定位点背景色，不设置默认白色
    
//    r.showsHeadingIndicator = YES;
    [self.mapView updateUserLocationRepresentation:r];
}




@end
