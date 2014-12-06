//
//  PrivateChatListViewController.m
//  HaiTao
//
//  Created by gtcc on 11/26/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "PrivateChatListViewController.h"
#import "DataLayer.h"
#import "MessageNotificatioinCell.h"
#import "MessageZanCell.h"
@interface PrivateChatListViewController ()<UITableViewDataSource,UITableViewDelegate,HYSegmentedControlDelegate>
@property (strong, nonatomic) NSArray* privateMsgItems;
@property (strong, nonatomic) NSArray* msgNotificationItems;
@property (strong, nonatomic) NSArray* msgZanItems;
@property int currentSegmentedControlIndex;
@property (strong, nonatomic) NSArray* cellIdentifierNames;
@end

@implementation PrivateChatListViewController
@synthesize segmentedControl;


-(NSArray*)privateMsgItems
{
    if(_privateMsgItems == nil)
    {
        _privateMsgItems = [DataLayer GetMessagePrivateChatList:@"abc"];
    }
    
    return _privateMsgItems;
}

-(NSArray*)msgNotificationItems
{
    if(_msgNotificationItems == nil)
    {
        _msgNotificationItems = [DataLayer GetMessageNotificationList:@"abc"];
    }
    return _msgNotificationItems;
}

-(NSArray*)msgZanItems
{
    if(_msgZanItems == nil)
    {
        _msgZanItems = [DataLayer GetMessageZanList:@"abc"];
    }
    return _msgZanItems;
}

-(NSArray*)cellIdentifierNames
{
    if(_cellIdentifierNames == nil)
    {
        _cellIdentifierNames = [[NSArray alloc] initWithObjects:@"privatechatlistcell",@"messagenotificationcell",@"messagezancell", nil];
    }
    return _cellIdentifierNames;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:0 height:44 Titles:@[@"私聊",@"通知",@"赞"] delegate:self] ;

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
    if(self.currentSegmentedControlIndex == 0)
    {
        return self.privateMsgItems.count;
    }else if(self.currentSegmentedControlIndex == 1)
    {
        return self.msgNotificationItems.count;
    }else
        return self.msgZanItems.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* tableIdentifier = self.cellIdentifierNames[self.currentSegmentedControlIndex];
    
    if(self.currentSegmentedControlIndex == 0)
    {
        PrivateChatListCell* cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        
        if(cell == nil)
        {
            cell = [[PrivateChatListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        
        NSDictionary* itemInfo = self.privateMsgItems[indexPath.row];
        cell.imageUser.image = [UIImage imageNamed:itemInfo[@"avatar"]];
        cell.lblName.text = itemInfo[@"name"];
        cell.lblLastMessage.text = itemInfo[@"lastMsg"];
        
        return cell;
    }else if(self.currentSegmentedControlIndex == 1)
    {
        MessageNotificatioinCell* cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        
        if(cell == nil)
        {
            cell = [[MessageNotificatioinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        
        NSDictionary* itemInfo = self.msgNotificationItems[indexPath.row];
        UILabel* lblname = [[UILabel alloc]  init];
        CGFloat nameWidth = [self GetWidthByContent:itemInfo[@"name"] theLabel:lblname];
        [cell addSubview:lblname];
        
        cell.imgAvatar.image = [UIImage imageNamed:itemInfo[@"avatar"]];
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(lblname.frame.origin.x + nameWidth + 10, 10, 68, 21)];
        label.text = @"关注了你";
        label.font = [UIFont systemFontOfSize:13];
        [cell addSubview:label];
        
        return cell;
    }else
    {
        MessageZanCell* cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        
        if(cell == nil)
        {
            cell = [[MessageZanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        
        NSDictionary* itemInfo = self.msgZanItems[indexPath.row];
        UILabel* lblname = [[UILabel alloc]  init];
        CGFloat nameWidth = [self GetWidthByContent:itemInfo[@"name"] theLabel:lblname];
        [cell addSubview:lblname];

        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(lblname.frame.origin.x + nameWidth + 10, 10, 68, 21)];
        label.text = @"赞了";
        label.font = [UIFont systemFontOfSize:13];
        [cell addSubview:label];
        
        cell.imgAvatar.image = [UIImage imageNamed:itemInfo[@"avatar"]];
        
        return cell;
    }
}

-(CGFloat)GetWidthByContent:(NSString*)content theLabel:(UILabel*)label
{
    NSString *str = content;
    CGSize size = [str sizeWithFont:label.font constrainedToSize:CGSizeMake(MAXFLOAT, 21)];
    [label setFrame:CGRectMake(50, 10, size.width, 21)];
    label.text = str;
    return size.width;
}

#pragma HYSegmentedControl delegate
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    self.currentSegmentedControlIndex = (int)index;
    
    [self.mainTableView reloadData];
}

@end
