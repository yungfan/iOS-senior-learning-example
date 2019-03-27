//
//  Weather.h
//  网络案例1-天气预报
//
//  Created by student on 2019/3/22.
//  Copyright © 2019 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Weather : NSObject

@property (nonatomic, copy) NSString * temperature;
@property (nonatomic, copy) NSString * weather;
@property (nonatomic, copy) NSString * wind;
@property (nonatomic, copy) NSString * week;
@property (nonatomic, copy) NSString * date_y;

//初始化方法
- (instancetype)initWithDictionary:(NSDictionary *)dic;

//获取网络数据，参数是传出去的Block
-(void)getWeather:(void (^)(NSArray *))callback;

@end

NS_ASSUME_NONNULL_END
