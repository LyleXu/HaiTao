//
//  ReceivedAddressViewController.m
//  HaiTao
//
//  Created by gtcc on 1/27/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "ReceivedAddressViewController.h"
#import "DataLayer.h"
#import "Utility.h"
#import "ReceivedAddressTableviewCell.h"
@implementation ReceivedAddressViewController
@synthesize items = _items;

-(NSArray*)items
{
    if(!_items)
    {
        NSMutableDictionary* result = [DataLayer GetAddressList];
        NSString* returnCode = result[@"s"];
        if([returnCode isEqualToString:SUCCESS])
        {
            
        }else
        {
            NSLog(@"%@",[Utility getErrorMessage:returnCode]);
        }
            
    }
    return _items;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * tableIdentifier= @"addressCell";

        ReceivedAddressTableviewCell*  cell=[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        
        if(cell==nil)
        {
            // first load
            cell=[[ReceivedAddressTableviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        
        return cell;
}

@end
