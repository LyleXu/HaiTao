//
//  SellerViewController.m
//  HaiTao
//
//  Created by gtcc on 11/13/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "SellerViewController.h"

@implementation SellerViewController
@synthesize segmentedControl;
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置圆角半径
    self.btnFocus.layer.masksToBounds = YES;
    self.btnFocus.layer.cornerRadius = 4;
    
    // segment control
    self.segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:230 Titles:@[@"最新商品",@"最IN商品"] delegate:self] ;
    [self.view addSubview:segmentedControl];

    // remove the segment control in the navigation bar
    for (UIView *views in self.navigationController.navigationBar.subviews) {
        if ([views isKindOfClass:[HYSegmentedControl class]]) {
            //NSLog(@"找到啦");
            [views removeFromSuperview];
        }
    }
}

@end
