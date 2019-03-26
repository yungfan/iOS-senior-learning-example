//
//  ExpressTableViewCell.m
//  网络案例2-快递查询
//
//  Created by student on 2019/3/26.
//  Copyright © 2019 abc. All rights reserved.
//

#import "ExpressTableViewCell.h"

@implementation ExpressTableViewCell

-(void)configUI:(Express *)express{
    
    
    self.datetime.text = express.datetime;
    
    self.remark.text = express.remark;
    
}

@end
