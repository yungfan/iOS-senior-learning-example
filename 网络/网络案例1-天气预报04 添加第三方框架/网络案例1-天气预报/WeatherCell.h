//
//  WeatherCell.h
//  网络案例1-天气预报
//
//  Created by student on 2019/3/22.
//  Copyright © 2019 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weather.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *weaher;
@property (weak, nonatomic) IBOutlet UILabel *temperature;
@property (weak, nonatomic) IBOutlet UILabel *wind;

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) Weather *w;

@end

NS_ASSUME_NONNULL_END
