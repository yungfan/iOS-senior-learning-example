//
//  MapViewController.m
//  高德地图2019
//
//  Created by student on 2019/4/28.
//  Copyright © 2019 student. All rights reserved.
//

#import "MapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "SnapshotViewController.h"

@interface MapViewController () <MAMapViewDelegate>

- (IBAction)takeSnapshot:(id)sender;
@property(nonatomic, strong) MAMapView *mapView;

@property(nonatomic, strong) MAUserLocationRepresentation *r;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addMap];
    
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

//交互
-(void)interact{
    
    //修改logo的位置
    _mapView.logoCenter = self.view.center;
    //修改指南针位置
    _mapView.compassOrigin= CGPointMake(_mapView.compassOrigin.x, 100); //设置指南针位置
    //修改比例尺位置
    _mapView.scaleOrigin= CGPointMake(_mapView.scaleOrigin.x, 100);  //设置比例尺位置
    
    //禁止缩放
    _mapView.zoomEnabled = NO;
    //禁止滚动
    _mapView.scrollEnabled = NO;
    
   
}

//修改定位小蓝点
-(void)locateDot{
    
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
    
    r.fillColor = [UIColor redColor];///精度圈 填充颜色, 默认 kAccuracyCircleDefaultColor
    
    r.strokeColor = [UIColor blueColor];///精度圈 边线颜色, 默认 kAccuracyCircleDefaultColor
    
    r.image = [UIImage imageNamed:@"left"]; ///定位图标, 与蓝色原点互斥
    
    self.r = r;
    
    [self.mapView updateUserLocationRepresentation:r];

}


#pragma mark - mapview delegate

//重写该方法自定义用户定位蓝点
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views {

    MAAnnotationView *view = views[0];
    
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]]) {
        
        MAUserLocation *userLocation = view.annotation;
        
        [self locateDot];
        
        userLocation.title = @"芜湖市";
        

    }
}


//地图截图
- (IBAction)takeSnapshot:(id)sender {
    
    [_mapView takeSnapshotInRect:self.view.bounds withCompletionBlock:^(UIImage *resultImage, CGRect rect) {
        
        SnapshotViewController *svc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"abc"];
        
        svc.snapShotImage = resultImage;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.navigationController pushViewController:svc animated:YES];
        });
    }];
}
@end
