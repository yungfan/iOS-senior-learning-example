//
//  POIViewController.m
//  高德地图的集成使用
//
//  Created by student on 2018/5/18.
//  Copyright © 2018年 student. All rights reserved.
//

#import "POIViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

#import <AMapSearchKit/AMapSearchKit.h>

@interface POIViewController () <AMapSearchDelegate>

@property(nonatomic, strong) AMapSearchAPI *search;

@end

@implementation POIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    [self aroundSearch];
    
    
}

-(void)aroundSearch{


    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location  = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
    request.keywords = @"电影院";
    /* 按照距离排序. */
    request.sortrule = 0;
    //request.requireExtension = YES;
    
    [self.search AMapPOIAroundSearch:request];

}


-(void)keywordSearch{

    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    request.keywords            = @"安徽师范大学";
    request.city                = @"芜湖市";
    //    request.types               = @"高等院校";
    //    request.requireExtension    = YES;
    
    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
    request.cityLimit           = YES;
    //    request.requireSubPOIs      = YES;
    
    
    
    [self.search AMapPOIKeywordsSearch:request];


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
        AMapPOI *poi = [response.pois lastObject];
        
        NSLog(@"POI -- %@ -- %@ -- %@ -- %@ -- %@", poi.province, poi.city, poi.district, poi.address, poi.name);
        
    }
    
   
    
}

@end
