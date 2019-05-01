//
//  AnnotationViewController.m
//  高德地图2019
//
//  Created by student on 2019/4/30.
//  Copyright © 2019 student. All rights reserved.
//

#import "AnnotationViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface AnnotationViewController ()<MAMapViewDelegate>

@property(nonatomic, strong) MAMapView *mapView;

@end

@implementation AnnotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addMap];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(31.2916511800, 118.3633587000);
    pointAnnotation.title = @"芜湖市";
    pointAnnotation.subtitle = @"人民路666号";
    
    [self.mapView addAnnotation:pointAnnotation];
    
}

//添加地图
-(void)addMap{
    
    ///初始化地图
    MAMapView *_mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    ///把地图添加至view
    [self.view addSubview:_mapView];
    
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    //设置缩放级别
    [_mapView setZoomLevel:16.1 animated:YES];
    
    _mapView.delegate = self;
    
    self.mapView = _mapView;
    
}


//如果想显示，必须导入素材包 AMap.bundle
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    /**
     if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
     static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
     MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
     if (annotationView == nil) {
     annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
     }
     annotationView.canShowCallout = YES;       //设置气泡可以弹出，默认为NO
     annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
     annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
     annotationView.pinColor = MAPinAnnotationColorPurple;
     return annotationView;
     }
     return nil;
     */
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"right"];
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        
        annotationView.canShowCallout = YES;
        return annotationView;
    }
    return nil;
}

@end
