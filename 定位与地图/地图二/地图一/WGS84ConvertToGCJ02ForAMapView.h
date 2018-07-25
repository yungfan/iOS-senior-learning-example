//
//  WGS84ConvertToGCJ02ForAMapView.h
//  WORKING 坐标偏移纠正算法（针对系统CLLocationManager定位坐标（WGS-84）与国内地图坐标（GCJ-02）偏差太大的问题）
//
//  Created by xqzh on 16/11/29.
//  Copyright © 2016年 JieW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface WGS84ConvertToGCJ02ForAMapView : NSObject
//判断是否已经超出中国范围
+(BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location;
//转GCJ-02
+(CLLocationCoordinate2D)transformFromWGSToGCJ:(CLLocationCoordinate2D)wgsLoc;
@end
