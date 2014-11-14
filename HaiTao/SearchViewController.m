//
//  SearchViewController.m
//  HaiTao
//
//  Created by gtcc on 11/13/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController() <UITableViewDataSource,UITableViewDelegate>
@end


@implementation SearchViewController
@synthesize segmentedControl;

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:64 Titles:@[@"标签",@"特卖",@"最新",@"最热"] delegate:self] ;
    [self.view addSubview:segmentedControl];
}

#pragma Tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * tableIdentifier=@"SearchCell";
    GoodsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if(cell==nil)
    {
        // first load
        cell=[[GoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    return cell;
}

@end
