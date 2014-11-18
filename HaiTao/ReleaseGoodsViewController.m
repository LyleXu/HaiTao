//
//  ReleaseGoodsViewController.m
//  HaiTao
//
//  Created by gtcc on 11/18/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "ReleaseGoodsViewController.h"

@implementation ReleaseGoodsViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleBordered target:self action:@selector(releaseGoods)];
    [self.navigationItem setRightBarButtonItem:barButtonItem];
    
    self.navigationItem.title = @"上架";
}

-(void)releaseGoods
{
    
}

@end
