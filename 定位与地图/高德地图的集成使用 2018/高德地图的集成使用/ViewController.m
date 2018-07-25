//
//  ViewController.m
//  高德地图的集成使用
//
//  Created by student on 2018/5/16.
//  Copyright © 2018年 student. All rights reserved.
//

#import "ViewController.h"

#import <AMapFoundationKit/AMapFoundationKit.h>

#import <AMapLocationKit/AMapLocationKit.h>


#import <AMapSearchKit/AMapSearchKit.h>

@interface ViewController () <AMapSearchDelegate>

@property(nonatomic, strong)  AMapLocationManager *locationManager;

@property(nonatomic, strong) AMapSearchAPI *search;

@property(nonatomic, strong) CLLocation *location;

- (IBAction)searchPOI:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
}



- (IBAction)onceLocation:(UIButton *)sender {
    
    self.locationManager = [[AMapLocationManager alloc]init];
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //   定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout =2;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 2;
    
    
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        NSLog(@"location:%@", location);
        
        self.location = location;
        
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
        }
    }];

}


-(void)aroundSearch{
    
    
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location  = [AMapGeoPoint locationWithLatitude:self.location.coordinate.latitude longitude:self.location.coordinate.longitude];
    request.keywords = @"商场";
    /* 按照距离排序. */
    //request.sortrule = 0;
    //request.requireExtension = YES;
    
    [self.search AMapPOIAroundSearch:request];
    
}

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        
        NSLog(@"查无信息");
        return;
    }
    
    
    
    for (int i = 0 ; i < response.pois.count; i++) {
        
        //解析response获取POI信息
        AMapPOI *poi = [response.pois objectAtIndex:i];
        
        NSLog(@"POI -- %@ -- %@ -- %@ -- %@ -- %@", poi.province, poi.city, poi.district, poi.address, poi.name);
        
    }
    
    
    
}


- (IBAction)searchPOI:(id)sender {
    
    [self aroundSearch];
    
}
@end
