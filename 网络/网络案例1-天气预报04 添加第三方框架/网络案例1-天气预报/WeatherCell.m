//
//  WeatherCell.m
//  网络案例1-天气预报
//
//  Created by student on 2019/3/22.
//  Copyright © 2019 abc. All rights reserved.
//

#import "WeatherCell.h"
#import "SDWebImage/UIImageView+WebCache.h"

@implementation WeatherCell

-(void)setW:(Weather *)w{
    _w = w;
    
    self.wind.text = w.wind;
    self.temperature.text = w.temperature;
    self.weaher.text = w.weather;
    self.date.text = [NSString stringWithFormat:@"%@  %@", w.date_y, w.week];
    
    
    //通过SDWebImage加载图片
    NSURL *url = [NSURL URLWithString:@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1571140150,993479906&fm=26&gp=0.jpg"];
    
    [self.icon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"rain"]];
}

@end
