//
//  WGS84ConvertToGCJ02ForAMapView.m
//  WORKING 坐标偏移纠正算法（针对系统CLLocationManager定位坐标（WGS-84）与国内地图坐标（GCJ-02）偏差太大的问题）
//
//  Created by xqzh on 16/11/29.
//  Copyright © 2016年 JieW. All rights reserved.
//

#import "WGS84ConvertToGCJ02ForAMapView.h"

const double a = 6378245.0;
const double ee = 0.00669342162296594323;
const double pi = 3.14159265358979324;

@implementation WGS84ConvertToGCJ02ForAMapView

+(CLLocationCoordinate2D)transformFromWGSToGCJ:(CLLocationCoordinate2D)wgsLoc
{
  CLLocationCoordinate2D adjustLoc;
  if([self isLocationOutOfChina:wgsLoc]){
    adjustLoc = wgsLoc;
  }else{
    double adjustLat = [self transformLatWithX:wgsLoc.longitude - 105.0 withY:wgsLoc.latitude - 35.0];
    double adjustLon = [self transformLonWithX:wgsLoc.longitude - 105.0 withY:wgsLoc.latitude - 35.0];
    double radLat = wgsLoc.latitude / 180.0 * M_PI;
    double magic = sin(radLat);
    magic = 1 - ee * magic * magic;
    double sqrtMagic = sqrt(magic);
    adjustLat = (adjustLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * M_PI);
    adjustLon = (adjustLon * 180.0) / (a / sqrtMagic * cos(radLat) * M_PI);
    adjustLoc.latitude = wgsLoc.latitude + adjustLat - 0.00039900; // 减去这个数字 完全是凑数，准确性有待验证
    adjustLoc.longitude = wgsLoc.longitude + adjustLon;
  }
  return adjustLoc;
}

//判断是不是在中国
+(BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location
{
  if (location.longitude < 72.004 || location.longitude > 137.8347 || location.latitude < 0.8293 || location.latitude > 55.8271)
    return YES;
  return NO;
}

+(double)transformLatWithX:(double)x withY:(double)y
{
  double lat = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
  lat += (20.0 * sin(6.0 * x * M_PI) + 20.0 *sin(2.0 * x * M_PI)) * 2.0 / 3.0;
  lat += (20.0 * sin(y * M_PI) + 40.0 * sin(y / 3.0 * M_PI)) * 2.0 / 3.0;
  lat += (160.0 * sin(y / 12.0 * M_PI) + 320 * sin(y * M_PI / 30.0)) * 2.0 / 3.0;
  return lat;
}

+(double)transformLonWithX:(double)x withY:(double)y
{
  double lon = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
  lon += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
  lon += (20.0 * sin(x * M_PI) + 40.0 * sin(x / 3.0 * M_PI)) * 2.0 / 3.0;
  lon += (150.0 * sin(x / 12.0 * M_PI) + 300.0 * sin(x / 30.0 * M_PI)) * 2.0 / 3.0;
  return lon;
}

@end
