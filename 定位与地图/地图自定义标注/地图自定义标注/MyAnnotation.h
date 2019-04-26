//
//  MyAnnotation.h
//  地图添加标注
//
//  Created by student on 2019/4/25.
//  Copyright © 2019 student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  实现大头针协议 就成为了一个大头针数据
 *  将协议中的属性和方法拷贝过来，删除readonly
 */
@interface MyAnnotation : NSObject <MKAnnotation>


/**
 *  大头针的位置
 */
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
/**
 *  主标题
 */
@property (nonatomic,  copy, nullable) NSString *title;
/**
 *  副标题
 */
@property (nonatomic,  copy, nullable) NSString *subtitle;


- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
NS_ASSUME_NONNULL_END
