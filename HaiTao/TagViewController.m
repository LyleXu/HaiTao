//
//  TagViewController.m
//  HaiTao
//
//  Created by gtcc on 11/18/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "TagViewController.h"

@interface TagViewController()<UITableViewDataSource>

@end

@implementation TagViewController
@synthesize items = _items;

-(NSArray*)items
{
    if(!_items)
    {
        _items = [[NSArray alloc] initWithObjects:@"Nike",@"Channel",@"LV", nil];
    }
    return _items;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * tableIdentifier=@"tagcell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if(cell==nil)
    {
        // first load
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    cell.textLabel.text = self.items[indexPath.row];
    
    return cell;

}
- (IBAction)returnPreviousPage:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
