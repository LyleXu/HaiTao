//
//  GoodsDetailViewController.m
//  HaiTao
//
//  Created by gtcc on 11/18/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "GoodsDetailViewController.h"
@implementation GoodsDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // segment control
    self.segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:124 Titles:@[@"卖家商品",@"买家SHOW"] delegate:self] ;
    [self.view addSubview:self.segmentedControl];
}

@end
