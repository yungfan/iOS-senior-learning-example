//
//  SonViewController.m
//  父子控制器
//
//  Created by student on 2018/6/6.
//  Copyright © 2018年 student. All rights reserved.
//

#import "SonViewController.h"

@interface SonViewController ()<UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tabView;

@property (strong, nonatomic) NSArray *datasource;

@end

@implementation SonViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.datasource = @[@"1", @"2", @"A", @"B", @"3", @"4", @"C", @"D"];
    
    self.tabView.tableFooterView = [[UIView alloc]init];
    
}

-(void)willMoveToParentViewController:(UIViewController *)parent{

    
    NSLog(@"%s", __func__);


}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return self.datasource.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ABC"];
    
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ABC"];
    
    }


    cell.textLabel.text = self.datasource[indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"%@", self.datasource[indexPath.row]);


}

@end
