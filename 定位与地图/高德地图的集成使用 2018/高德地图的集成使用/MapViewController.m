//
//  MapViewController.m
//  高德地图的集成使用
//
//  Created by student on 2018/5/16.
//  Copyright © 2018年 student. All rights reserved.
//

#import "MapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    MAMapView *_mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    ///把地图添加至view
    [self.view addSubview:_mapView];
    
    _mapView.showsUserLocation = YES;
    
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    _mapView.zoomLevel = 15;
    
}


@end
