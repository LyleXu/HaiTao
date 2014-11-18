//
//  SearchViewController.h
//  HaiTao
//
//  Created by gtcc on 11/13/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYSegmentedControl.h"
#import "GoodsTableViewCell.h"
@interface SearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic,retain) IBOutlet HYSegmentedControl* segmentedControl;
@end
