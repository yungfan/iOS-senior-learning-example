//
//  ExpressTableViewCell.h
//  网络案例2-快递查询
//
//  Created by student on 2019/3/26.
//  Copyright © 2019 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Express.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExpressTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *datetime;

@property (weak, nonatomic) IBOutlet UILabel *remark;

-(void)configUI:(Express *)express;

@end

NS_ASSUME_NONNULL_END
