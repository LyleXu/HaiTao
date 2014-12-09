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
@interface TagViewController()<UITableViewDataSource>
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
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
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

#pragma Searchbar delegate

- (void) searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)searchText {
    [self doSearch: searchText];
}

-(void)doSearch:(NSString*)searchText
{
    if([self.currentSearchBar.text isEqualToString:@""])
    {
        self.results = nil;
        [self.mainTableView reloadData];
        return;
    }
    
    ++searchCounter;
    NSUInteger searchID = searchCounter;
    __block BOOL searchResultsReturned = NO;
    //[self setLoading:YES];
    
    [self performSearchForQuery:searchText withResultsHandler:^(NSArray* searchResults) {
        NSAssert(!searchResultsReturned, @"JCAutocompletingSearchController: delegate called results handler more than once for the same search execution.");
        searchResultsReturned = YES;
        
        if (searchID >= currentlyDisplaySearchID) {
            currentlyDisplaySearchID = searchID;
            if (searchResults) {
                self.results = searchResults;
                [self.mainTableView reloadData];
            }
        } else {
            NSLog(@"JCAutocompletingSearchController: received out-of-order search results; ignoring. (currently displayed: %i, searchID: %i", currentlyDisplaySearchID, searchID);
        }
    }];
}

- (void)performSearchForQuery:(NSString*)query withResultsHandler:(SearchReusltHandler)resultsHandler
{
    // Simulate the asynchronicity and delay of a web request...
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray* possibleItems = self.items;
        
        NSMutableArray* predicates = [NSMutableArray new];
        for (__strong NSString* queryPart in [query componentsSeparatedByString:@" "]) {
            if (queryPart && (queryPart = [queryPart stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]).length > 0) {
                [predicates addObject:[NSPredicate predicateWithFormat:@"SELF like[cd] %@", [NSString stringWithFormat:@"%@*", queryPart]]];
            }
        }
        NSPredicate* predicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
        
        NSArray* matchedItems = [possibleItems filteredArrayUsingPredicate:predicate];
        NSMutableArray* results = [NSMutableArray new];
        for (NSString* item in matchedItems) {
            [results addObject:@{@"label": item}];
        }
        
        double delayInSeconds = 0.4;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            resultsHandler(results);
        });
    });
    
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

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self handleSearch:searchBar];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self handleSearch:searchBar];
}

- (void)handleSearch:(UISearchBar *)searchBar {
    //NSLog(@"User searched for %@", searchBar.text);
    [searchBar resignFirstResponder]; // if you want the keyboard to go away
}

@end
