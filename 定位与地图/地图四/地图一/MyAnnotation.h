//
//  MyAnnotation.h
//  地图一
//
//  Created by teacher on 17/4/13.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


/**
 *  实现大头针协议 就成为了一个大头针数据
 *  将协议中的属性和方法拷贝过来，删除readonly
 */
@interface MyAnnotation : NSObject <MKAnnotation>


@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;



@end
