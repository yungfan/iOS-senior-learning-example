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
#import <AMapSearchKit/AMapSearchKit.h>

@interface ViewController ()<MAMapViewDelegate, AMapSearchDelegate>

@property(nonatomic, strong) MAMapView *mapView;

@property(nonatomic, strong) AMapSearchAPI *search;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self showTips];
    
    
}


//输入提示查询
-(void) showTips{

    //1、创建一个搜索器 并设置代理 -- 当有数据从服务器返回时 会回掉
    self.search = [[AMapSearchAPI alloc]init];
    self.search.delegate = self;

    //2、创建一个输入提示请求
    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
    tips.keywords = @"景点";
    tips.city= @"南京";
    tips.cityLimit = YES; //是否限制城市
    
    [self.search AMapInputTipsSearch:tips];
}

//周边搜索
-(void)aroundPOI{
    
    //1、创建一个搜索器 并设置代理 -- 当有数据从服务器返回时 会回掉
    self.search = [[AMapSearchAPI alloc]init];
    self.search.delegate = self;

    
    //2、创建周边搜索
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location  = [AMapGeoPoint locationWithLatitude:31.291 longitude:118.363404];
    request.keywords  = @"美食|职业院校";
    /* 按照距离排序. */
    request.sortrule = 0;
    request.requireExtension = YES;
    
    //3、发起请求
    [self.search AMapPOIAroundSearch:request];
}

//关键字搜索
-(void)keywordsPOI{
    
    //1、创建一个搜索器 并设置代理 -- 当有数据从服务器返回时 会回掉
    self.search = [[AMapSearchAPI alloc]init];
    self.search.delegate = self;


    //2、关键字搜索
    AMapPOIKeywordsSearchRequest *resquest = [[AMapPOIKeywordsSearchRequest alloc]init];

    resquest.keywords = @"职业院校";
    resquest.city = @"芜湖";

    //resquest.types = @"加油站";
    resquest.cityLimit = YES;
    resquest.requireSubPOIs = YES;

    //3、发起请求
    [self.search AMapPOIKeywordsSearch:resquest];
}

-(void)showMap{

    self.mapView = [[MAMapView alloc]initWithFrame:self.view.frame];
    
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    
    self.mapView.showsUserLocation = YES;
    
    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    
    [self.mapView setZoomLevel:17 animated:YES];


}


//修改小蓝点的若干属性
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    //定位小蓝点自定义 -- 如果想完全自定义－自己添加一个Annotation
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
    //r.showsAccuracyRing = NO;///精度圈是否显示，默认YES

    //r.showsHeadingIndicator = YES;
    //r.image = [UIImage imageNamed:@"Expression_49"];//设置显示的图片
    //r.fillColor = [UIColor cyanColor];
    //r.strokeColor = [UIColor redColor];
    [self.mapView updateUserLocationRepresentation:r];
}

//搜索完毕以后 会将数据返回 该方法用于接收服务器返回的poi数据
-(void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{

    if (response.pois.count != 0) {
        for (AMapPOI *poi in response.pois) {
            
            NSLog(@"名称：%@， 地址：%@", poi.name, poi.address);
        }
    }
    
}

/* 输入提示回调. */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    if (response.tips.count != 0) {
        for (AMapTip *tip in response.tips) {
            
            NSLog(@"名称：%@， 地址：%@", tip.name, tip.address);
        }
    }
    
}

@end
