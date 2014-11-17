//
//  ShopCartViewController.m
//  HaiTao
//
//  Created by gtcc on 11/17/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "ShopCartViewController.h"

@interface ShopCartViewController () <UITableViewDataSource,UITableViewDelegate>

@end
@implementation ShopCartViewController
@synthesize cartItems =_cartItems;

-(NSDictionary*)cartItems
{
    if(!_cartItems)
    {
        _cartItems = [[NSDictionary alloc] initWithObjectsAndKeys:
                      [[NSArray alloc] initWithObjects:@"2014款xxxxx",@"2013款xxxxx",nil],@"Happy Bob",
                      [[NSArray alloc] initWithObjects:@"2015款xxxxx",nil],@"Sandy",
                      nil];
    }
    
    return _cartItems;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return [self.cartItems count];
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [[self.cartItems  objectForKey:[NSNumber numberWithInteger:section]]  count];
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * tableIdentifier=@"shopcartcell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if(cell==nil)
    {
        // first load
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    NSString* item = [self.cartItems objectForKey:[NSNumber numberWithInteger:indexPath.section]] [indexPath.row];
    cell.textLabel.text = item;
    NSString* url = [NSString stringWithFormat:@"http://localhost/pic/%@.png",item];
    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    cell.imageView.image = [UIImage imageWithData:data];
    
    return cell;
}


#pragma table delegate
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
@end
