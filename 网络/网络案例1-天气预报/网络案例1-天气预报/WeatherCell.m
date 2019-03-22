//
//  WeatherCell.m
//  网络案例1-天气预报
//
//  Created by student on 2019/3/22.
//  Copyright © 2019 abc. All rights reserved.
//

#import "WeatherCell.h"

@implementation WeatherCell

-(void)setW:(Weather *)w{
    _w = w;
    
    self.wind.text = w.wind;
    self.temperature.text = w.temperature;
    self.weaher.text = w.weather;
    self.date.text = [NSString stringWithFormat:@"%@ %@", w.date_y, w.week];
    
    
}

@end
