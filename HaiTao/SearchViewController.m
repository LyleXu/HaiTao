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
@synthesize segmentedControl,isSearching;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:0 width:270 height:44 Titles:@[@"标签",@"特卖",@"最新",@"最热"] delegate:self] ;
    [self.navigationController.navigationBar addSubview:segmentedControl];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    for (UIView * subviews1 in self.navigationController.navigationBar.subviews) {
        if ([subviews1 isKindOfClass:[HYSegmentedControl class]]) {
            [subviews1 removeFromSuperview];
        }
    }
}

- (IBAction)cancelSearch:(id)sender {
    [self.searchBar resignFirstResponder];
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


//#pragma mark -
//#pragma mark Content Filtering
//
//- (void)filterContentForSearchText:(NSString*)searchText
//{
//    NSPredicate* p = [NSPredicate predicateWithBlock:
//                      ^BOOL(id obj, NSDictionary *d) {
//                          CBook* s = obj;
//                          NSStringCompareOptions options = NSCaseInsensitiveSearch;
//                          return ([s.title rangeOfString:searchText
//                                                 options:options].location != NSNotFound);
//                      }];
//    NSMutableArray* filteredData = [NSMutableArray new];
//    // sectionData is an array of arrays
//    // for every array ...
//    for (NSMutableArray* arr in self.sectionData) {
//        // generate an array of strings passing the search criteria
//        [filteredData addObject: [arr filteredArrayUsingPredicate:p]];
//    }
//    self.filteredListData = filteredData;
//    
//    isSearching = YES;
//}
//
//#pragma search display controller delegate
//- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
//{
//    searchString = [searchString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    
//    [self filterContentForSearchText:searchString];
//    
//    // Return YES to cause the search result table view to be reloaded.
//    return YES;
//}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    isSearching = NO;
}

@end
