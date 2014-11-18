//
//  MarkLocationViewController.m
//  HaiTao
//
//  Created by gtcc on 11/14/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "MarkLocationViewController.h"
#import "ReleaseGoodsViewController.h"
@implementation MarkLocationViewController
@synthesize imageMarkLocation;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStyleBordered target:self action:@selector(toNextPage)];
    [self.navigationItem setRightBarButtonItem:barButtonItem];
    
    self.navigationItem.title = @"标记标签";
}

-(void)toNextPage
{
    ReleaseGoodsViewController* ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"releasegoodsviewcontroller"];
    [self.navigationController pushViewController:ctl animated:YES];
}

@end
