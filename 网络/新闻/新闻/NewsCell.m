//
//  NewsCell.m
//  新闻
//
//  Created by teacher on 17/3/2.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "NewsCell.h"
#import "SDWebImage/UIImageView+WebCache.h"

@implementation NewsCell


-(void)setNews:(News *)news{

    _news = news;
    
    self.title.text = news.title;
    
    //SDWebImage加载图片
    [self.cover sd_setImageWithURL:[NSURL URLWithString:news.cover] placeholderImage:[UIImage imageNamed:@"img"]];


}

@end
