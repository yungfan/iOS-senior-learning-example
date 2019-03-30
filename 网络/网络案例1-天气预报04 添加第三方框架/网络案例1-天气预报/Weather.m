//
//  Weather.m
//  网络案例1-天气预报
//
//  Created by student on 2019/3/22.
//  Copyright © 2019 abc. All rights reserved.
//

#import "Weather.h"

@implementation Weather

-(instancetype)initWithDictionary:(NSDictionary *)dic {
    
    if (self = [super init]) {
    
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}


//属性与字典不匹配时进行改正，不改的话不会崩溃但拿不到值
- (void)setValue:(id)value forKey:(NSString *)key{
    //在这里更改key
    if([key isEqualToString:@"date"]){
        
        key = @"date_y";
    }
    
    [super setValue:value forKey:key];
}


//冗错处理，如果有未定义的字段的话就会走到这里，不重写的话会引起崩溃
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    NSLog(@"value:%@,undefineKey:%@",value,key);
}

@end
