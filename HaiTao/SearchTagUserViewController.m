//
//  SearchTagUserViewController.m
//  HaiTao
//
//  Created by gtcc on 11/26/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "SearchTagUserViewController.h"
typedef void (^SearchReusltHandler)(NSArray*);
@interface SearchTagUserViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSObject* loadingMutex;
    NSUInteger loadingQueueCount;
    NSUInteger searchCounter;
    NSUInteger currentlyDisplaySearchID;
    BOOL delegateManagesTableViewCells;
    BOOL searchesPerformedSynchronously;
}

@property (strong, nonatomic) NSArray* results;
@end

@implementation SearchTagUserViewController
@synthesize tagItems = _tagItems;
@synthesize userItems = _userItems;
@synthesize segmentControl;
-(NSArray*)tagItems
{
    if(_tagItems == nil)
    {
        _tagItems = [[NSArray alloc] initWithObjects:@"Nike",@"Nike id", @"LV", @"Channel", @"Proda", nil];
    }
    
    return _tagItems;
}

-(NSArray*)userItems
{
    if(_userItems == nil)
    {
        _userItems = [[NSArray alloc] initWithObjects:@"Mike",@"Jeffrey",@"Anson",@"Fred",@"Aeron",@"Squall", nil];
    }
    
    return _userItems;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = true;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = false;
}

#pragma search bar delegate

- (void) searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)searchText {
    [self doSearch: searchText];
}

-(void)doSearch:(NSString*)searchText
{
    if([self.searchBar.text isEqualToString:@""])
    {
        self.results = nil;
        [self.resultsTableView reloadData];
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
                [self.resultsTableView reloadData];
            }
        } else {
            NSLog(@"JCAutocompletingSearchController: received out-of-order search results; ignoring. (currently displayed: %i, searchID: %i", currentlyDisplaySearchID, searchID);
        }
        if (loadingQueueCount == 0) {
            //[self setLoading:NO];
        }
    }];
}

- (void)performSearchForQuery:(NSString*)query withResultsHandler:(SearchReusltHandler)resultsHandler
{
    // Simulate the asynchronicity and delay of a web request...
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray* possibleItems = self.segmentControl.selectedSegmentIndex == 0 ? self.tagItems :self.userItems;
        
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

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    NSLog(@"User canceled search");
    [searchBar resignFirstResponder]; // if you want the keyboard to go away
}

#pragma tableview datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.searchBar.text isEqualToString:@""])
        return 0;
    else
        return self.results.count + 1;// plus the display tip
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = indexPath.row;
    if (row == 0) {
        UITableViewCell* cell = [self.resultsTableView dequeueReusableCellWithIdentifier:@"displaytipcell"];
        NSString* searchTip = [NSString stringWithFormat:@"搜索%@的相关%@",self.searchBar.text, self.segmentControl.selectedSegmentIndex  == 0 ? @"标签": @"用户"];
        cell.textLabel.text = searchTip;
        return cell;
    }
    
    if (delegateManagesTableViewCells) {
        return [self tableView:self.resultsTableView cellForRowAtIndexPath:indexPath];
    } else {
        if (row <= self.results.count) {
            NSDictionary* result = (NSDictionary*)[self.results objectAtIndex:row-1];
            UITableViewCell* cell = (UITableViewCell*)[self.resultsTableView dequeueReusableCellWithIdentifier:@"tagusercell"];
            cell.textLabel.text = [result objectForKey:@"label"];
            return cell;
        } else {
            return nil;
        }
    }
}

#pragma tableview delegate

- (void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    
}

- (IBAction)switchTagUser:(id)sender {
    [self doSearch: self.searchBar.text];
}
- (IBAction)returnPreviousPage:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
