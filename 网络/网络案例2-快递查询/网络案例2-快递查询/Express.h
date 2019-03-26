//
//  Express.h
//  网络案例2-快递查询
//
//  Created by student on 2019/3/26.
//  Copyright © 2019 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Express : NSObject

@property (nonatomic, copy) NSString *datetime;

@property (nonatomic, copy) NSString *remark;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
