//
//  ReleaseGoodsViewController.m
//  HaiTao
//
//  Created by gtcc on 11/18/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "ReleaseGoodsViewController.h"

@implementation ReleaseGoodsViewController
@synthesize imgCaptured;
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleBordered target:self action:@selector(releaseGoods)];
    [self.navigationItem setRightBarButtonItem:barButtonItem];
    
    self.FirstImageView.image = imgCaptured;
    
    self.navigationItem.title = @"上架";
    
//    if (self.toolbarItems.count == 0) {
//        [self.navigationController setToolbarHidden:YES animated:YES];
//    }
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    if (self.toolbarItems.count == 0) {
//        [self.navigationController setToolbarHidden:YES animated:animated];
//    }
//}

-(void)releaseGoods
{
    
}

@end
