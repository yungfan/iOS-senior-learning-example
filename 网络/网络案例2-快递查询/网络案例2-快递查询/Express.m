//
//  Express.m
//  网络案例2-快递查询
//
//  Created by student on 2019/3/26.
//  Copyright © 2019 abc. All rights reserved.
//

#import "Express.h"

@implementation Express

-(instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

@end
