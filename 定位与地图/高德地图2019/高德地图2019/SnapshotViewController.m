//
//  SnapshotViewController.m
//  高德地图2019
//
//  Created by student on 2019/4/30.
//  Copyright © 2019 student. All rights reserved.
//

#import "SnapshotViewController.h"

@interface SnapshotViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation SnapshotViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageView.image = self.snapShotImage;
}

@end
