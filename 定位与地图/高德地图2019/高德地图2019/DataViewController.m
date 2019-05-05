//
//  DataViewController.m
//  高德地图2019
//
//  Created by student on 2019/4/30.
//  Copyright © 2019 student. All rights reserved.
//

#import "DataViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>



@interface DataViewController ()<AMapSearchDelegate>

@property (nonatomic, strong) AMapSearchAPI *search;

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    
    [self trafficSearch];
}

//公交信息搜索
-(void)trafficSearch{
    // 一、搜索公交站
    //    AMapBusStopSearchRequest *stop = [[AMapBusStopSearchRequest alloc] init];
    //    stop.keywords = @"商贸学院";
    //    stop.city = @"芜湖市";
    //    [self.search AMapBusStopSearch:stop];
    
    
    //二、搜索线路
    AMapBusLineNameSearchRequest *line = [[AMapBusLineNameSearchRequest alloc] init];
    line.keywords = @"37路";
    line.city = @"芜湖市";
    line.requireExtension   = YES;
    [self.search AMapBusLineNameSearch:line];
}

//周边搜索
-(void)aroundSearch{
    
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location = [AMapGeoPoint locationWithLatitude:31.29065118 longitude:118.3623587];
    request.keywords = @"电影院";
    /* 按照距离排序. */
    request.sortrule = 0;
    request.requireExtension    = YES;
    
    [self.search AMapPOIAroundSearch:request];
}

//关键字搜索
-(void)keywordsSearch{
    
    
    //关键字搜索
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    request.keywords = @"大学";
    request.city = @"南京";
    request.types = @"高等院校";
    request.requireExtension = YES;
    
    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
    request.cityLimit           = YES;
    request.requireSubPOIs      = YES;
    
    [self.search AMapPOIKeywordsSearch:request];
}

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    if (response.pois.count == 0) {
        return;
    }
    
    //解析response获取POI信息
    for(AMapPOI *poi in response.pois) {
        
        NSLog(@"%@ -- %@", poi.name, poi.address);
        
    }
}

/* 公交站点回调*/
- (void)onBusStopSearchDone:(AMapBusStopSearchRequest *)request response:(AMapBusStopSearchResponse *)response {
    
    if (response.busstops.count == 0) {
        return;
    }
    
    //解析response获取公交站点信息
    for(AMapBusStop *bus in response.busstops) {
        
        
        for (AMapBusLine * line in bus.buslines) {
            
            //打印起始公交站
            NSLog(@"%@ -- %@", line.startStop, line.endStop);
        }
        
    }
}

/* 公交路线回调*/
- (void)onBusLineSearchDone:(AMapBusLineBaseSearchRequest *)request response:(AMapBusLineSearchResponse *)response{
    
    if (response.buslines.count == 0) {
        return;
        
    }
    
    //解析response获取公交线路信息
    //打印出所有的站
    for (AMapBusLine * line in response.buslines) {
        
        for (AMapBusStop *viaBusStop in line.busStops) {
            
            NSLog(@"%@", viaBusStop.name);
            
        }
        
        NSLog(@"===============一趟结束================");
    }
}

@end
