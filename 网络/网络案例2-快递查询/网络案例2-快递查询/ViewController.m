//
//  ViewController.m
//  网络案例2-快递查询
//
//  Created by student on 2019/3/26.
//  Copyright © 2019 abc. All rights reserved.
//

#import "ViewController.h"
#import "Express.h"
#import "ExpressTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *expressTableView;

@property (nonatomic, strong) NSMutableArray<Express*> *expresses;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.expresses = [NSMutableArray array];
    
    [self getMessage];
    
    self.expressTableView.rowHeight = 70.0;
}

-(void)getMessage{
    
    NSURL *url = [NSURL URLWithString:@"http://v.juhe.cn/exp/index?key=3aecda3a6394c64594b2790f6e1de257&com=sf&no=446505105190"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    
    NSURLSessionDataTask *task =  [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
      
        if (error) {
            
            NSLog(@"网络访问出错");
        }
        
        else {
            
            NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
            
            if (res.statusCode == 200) {
                
                NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                
                
                NSArray *list = dataDic[@"result"][@"list"];
                
                for (int i = 0; i < list.count; i++) {
                    
                    Express *express = [[Express alloc]initWithDic:list[i]];
                    
                    [self.expresses addObject:express];
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSString *com = dataDic[@"result"][@"company"];
                    NSString *no = dataDic[@"result"][@"no"];
                    
                    self.title = [NSString stringWithFormat:@"%@:%@", com, no];
                    
                    [self.expressTableView reloadData];
                    
                });
                
            }
            
            
        }
        
        
    }];
    
    
    [task resume];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.expresses.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ExpressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"express"];
    
    Express *express = self.expresses[indexPath.row];
    
    [cell configUI:express];
    
    return cell;
    
    
}

@end
