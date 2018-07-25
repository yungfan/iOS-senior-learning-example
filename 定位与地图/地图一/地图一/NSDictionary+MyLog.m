//
//  NSDictionary+MyLog.m
//  地图一
//
//  Created by teacher on 17/4/11.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "NSDictionary+MyLog.h"

@implementation NSDictionary (MyLog)


- (NSString *)descriptionWithLocale:(id)locale
{
    NSArray *allKeys = [self allKeys];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\t\n "];
    for (NSString *key in allKeys) {
        id value= self[key];
        [str appendFormat:@"\t \"%@\" = %@,\n",key, value];
    }
    [str appendString:@"}"];
    
    return str;
}
@end
