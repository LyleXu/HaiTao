//
//  TagViewController.h
//  HaiTao
//
//  Created by gtcc on 11/18/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"
@interface TagViewController : UIViewController
@property (strong,nonatomic) NSArray* items;
@property (weak, nonatomic) IBOutlet UISearchBar *currentSearchBar;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property(nonatomic,assign) NSObject<PassValueDelegate> *delegate;
@end
