//
//  TagViewController.m
//  HaiTao
//
//  Created by gtcc on 11/18/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "TagViewController.h"
#import "DataLayer.h"
typedef void (^SearchReusltHandler)(NSArray*);
@interface TagViewController()<UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate>
{
    NSUInteger searchCounter;
    NSUInteger currentlyDisplaySearchID;
}
@property (strong, nonatomic) NSArray* results;
@end

@implementation TagViewController
@synthesize items = _items;

-(NSArray*)items
{
    if(!_items)
    {
        _items = [DataLayer GetAllTags];
    }
    return _items;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.results = self.items;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.results.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * tableIdentifier=@"tagcell";
    UITableViewCell *cell=[self.mainTableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if(cell==nil)
    {
        // first load
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    NSString* tagName =self.results[indexPath.row];
    cell.textLabel.text = tagName;
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissViewControllerAnimated:true completion:^{
        [self.delegate passValue:self.results[indexPath.row]];
    }];
}

- (IBAction)returnPreviousPage:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)doSearch:(NSString*)searchText
{
    if([self.currentSearchBar.text isEqualToString:@""])
    {
        self.results = nil;
        [self.mainTableView reloadData];
        return;
    }
    
    self.results = [self.items filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText]];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self doSearch: searchString];
    return YES;
}

//searchBar开始编辑时改变取消按钮的文字
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.currentSearchBar.showsCancelButton = YES;
    
    NSArray *subViews;
    
    if (is_IOS_7) {
        subViews = [(self.currentSearchBar.subviews[0]) subviews];
    }
    else {
        subViews = self.currentSearchBar.subviews;
    }
    
    for (id view in subViews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton* cancelbutton = (UIButton* )view;
            [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
            break;
        }
    }
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    //準備搜尋前，把上面調整的TableView調整回全屏幕的狀態
    [UIView animateWithDuration:1.0 animations:^{
        self.mainTableView.frame = CGRectMake(0, 20, 320, SCREEN_HEIGHT-20);
    }];
    
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    //搜尋結束後，恢復原狀
    [UIView animateWithDuration:1.0 animations:^{
        self.mainTableView.frame = CGRectMake(0, is_IOS_7?64:44, 320, SCREEN_HEIGHT-64);
    }];
    
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.results = self.items;
}

@end
