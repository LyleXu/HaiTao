//
//  UserViewController.m
//  HaiTao
//
//  Created by gtcc on 11/14/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "UserViewController.h"
#import "UserInfoTableViewController.h"
@implementation UserViewController
@synthesize segmentedControl,btnModifyUserInfo;
-(void)viewDidLoad
{
    // 设置圆角半径
    self.btnModifyUserInfo.layer.masksToBounds = YES;
    self.btnModifyUserInfo.layer.cornerRadius = 4;
    
    self.segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:230 Titles:@[@"交易",@"购物车"] delegate:self] ;
    [self.view addSubview:segmentedControl];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"modifyUserInfo"]) {
        
    }else if([[segue identifier] isEqualToString:@"settings"])
    {
        
    }
    
    [self setHidesBottomBarWhenPushed:YES];
}
- (IBAction)modifyUserInfo:(id)sender {
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self setHidesBottomBarWhenPushed:NO];
    [super viewWillDisappear:YES];

}
@end
