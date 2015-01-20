//
//  SearchViewController.m
//  HaiTao
//
//  Created by gtcc on 11/13/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "SearchViewController.h"
#import "DataLayer.h"
#import "POHorizontalList.h"
#import "SpecialSellingCell.h"
#import "NewArrivalCell.h"
#import "HotCell.h"
int CurrentSelectedSegmentedControlIndexOfSearch = 0;

@interface SearchViewController() <UITableViewDataSource,UITableViewDelegate,POHorizontalListDelegate,HYSegmentedControlDelegate>
@property (strong, nonatomic) NSArray* tagsItems;
@property (strong, nonatomic) NSArray* specialSellingItems;
@property (strong, nonatomic) NSArray* newArrivalItems;
@property (strong, nonatomic) NSArray* hotItems;
@end


@implementation SearchViewController
@synthesize segmentedControl,isSearching;

-(NSArray*)tagsItems
{
    if(_tagsItems == nil)
    {
        _tagsItems = [DataLayer GetAllGoodsByTags];
    }
    
    return _tagsItems;
}

-(NSArray*)specialSellingItems
{
    if(_specialSellingItems == nil)
    {
        _specialSellingItems = [DataLayer GetAllGoodsBySpecialSelling];
    }
    
    return _specialSellingItems;
}

-(NSArray*)newArrivalItems
{
    if(_newArrivalItems == nil)
    {
        _newArrivalItems = [DataLayer GetAllGoodsByNewArrival];
    }
    
    return _newArrivalItems;
}

-(NSArray*)hotItems
{
    if(_hotItems == nil)
    {
        _hotItems = [DataLayer GetAllGoodsByHot];
    }
    
    return _hotItems;
}

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

#pragma Tableview datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tagsItems.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * tableIdentifier= [self GetIdentifiers][CurrentSelectedSegmentedControlIndexOfSearch];
    
    if(CurrentSelectedSegmentedControlIndexOfSearch == 0)
    {
        GoodsTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        
        if(cell==nil)
        {
            // first load
            cell=[[GoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        
        [self SetupCell:cell ItemInfo:self.tagsItems[indexPath.row] PicContainer:cell.GoodsImageContainer];
        
        return cell;
    }else if(CurrentSelectedSegmentedControlIndexOfSearch ==1)
    {
        SpecialSellingCell * cell=[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        
        if(cell==nil)
        {
            // first load
            cell=[[SpecialSellingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        
        [self SetupCell:cell ItemInfo:self.specialSellingItems[indexPath.row] PicContainer:cell.GoodsImageContainer];
        
        return cell;
    }else if(CurrentSelectedSegmentedControlIndexOfSearch ==2)
    {
        NewArrivalCell * cell=[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        
        if(cell==nil)
        {
            // first load
            cell=[[NewArrivalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        
        [self SetupCell:cell ItemInfo:self.newArrivalItems[indexPath.row] PicContainer:cell.GoodsImageContainer];
        
        return cell;
    }else{
        HotCell * cell=[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        
        if(cell==nil)
        {
            // first load
            cell=[[HotCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        
        [self SetupCell:cell ItemInfo:self.hotItems[indexPath.row] PicContainer:cell.GoodsImageContainer];
        
        return cell;
    }
}

-(void)SetupCell:(UITableViewCell*)cell ItemInfo:(NSDictionary*)item PicContainer:(UIView*)picContainer
{
    UILabel* lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 200, 21)];
    [lblTitle setTextColor:[UIColor blueColor]];
    CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(-20 * (CGFloat)M_PI / 180), 1, 0, 0);
    lblTitle.transform = matrix;
    lblTitle.font = [UIFont systemFontOfSize:14];
    lblTitle.text = item[@"name"];
    [cell addSubview:lblTitle];
    
    [self InitGoodsContainer:picContainer GoodsPics:item[@"goodsPics"]];

}

-(void)InitGoodsContainer:(UIView*)picContainter GoodsPics:(NSArray*)picNames
{
    NSMutableArray* goodsImageList = [[NSMutableArray alloc] init];
    for (NSString* goodsPicName in picNames) {  // get goods pics
        ListItem *item1= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:goodsPicName] text:@"ffff"];
        [goodsImageList addObject:item1];
    }
    
    POHorizontalList* list = [[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 82.0) title:@"aaa" items:goodsImageList Distance_between_items:0.0];
    [list setDelegate:self];
    [picContainter addSubview:list];
}

#pragma POHorizontalListDelegate
- (void) didSelectItem:(ListItem *)item
{
    
}

#pragma HYSegmentedControlDelegate
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    CurrentSelectedSegmentedControlIndexOfSearch = (int)index;
    
    [self.mainTableView reloadData];
}

-(NSArray*)GetIdentifiers
{
    NSArray* identifiers = [[NSArray alloc] initWithObjects:@"TagsCell",@"SpecialSellingCell",@"NewArrivalCell",@"HotCell", nil];
    return identifiers;
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
