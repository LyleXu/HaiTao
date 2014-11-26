//
//  SearchTagUserViewController.h
//  HaiTao
//
//  Created by gtcc on 11/26/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTagUserViewController : UIViewController
@property (nonatomic,strong) NSArray* tagItems;
@property (nonatomic,strong) NSArray* userItems;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@end
