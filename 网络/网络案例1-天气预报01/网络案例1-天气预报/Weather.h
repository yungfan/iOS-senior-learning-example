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

@end

NS_ASSUME_NONNULL_END
