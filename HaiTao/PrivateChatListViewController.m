//
//  PrivateChatListViewController.m
//  HaiTao
//
//  Created by gtcc on 11/26/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "PrivateChatListViewController.h"

@interface PrivateChatListViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation PrivateChatListViewController
@synthesize segmentedControl;
-(void)viewWillAppear:(BOOL)animated
{
        self.segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:0 Titles:@[@"私聊",@"通知",@"赞"] delegate:self] ;

        [self.navigationController.navigationBar addSubview:segmentedControl];
}

-(void)viewWillDisappear:(BOOL)animated
{
    for (UIView * subviews1 in self.navigationController.navigationBar.subviews) {
        if ([subviews1 isKindOfClass:[HYSegmentedControl class]]) {
            //NSLog(@"找到啦");
            [subviews1 removeFromSuperview];
        }
    }
}

#pragma tableview datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* tableIdentifier = @"pricatechatlistcell";
    PrivateChatListCell* cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if(cell == nil)
    {
        cell = [[PrivateChatListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    
    
    return cell;
}

@end
