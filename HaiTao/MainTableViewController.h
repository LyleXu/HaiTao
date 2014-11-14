//
//  MainTableViewController.h
//  HaiTao
//
//  Created by gtcc on 11/7/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYSegmentedControl.h"
#import "SellerViewController.h"
@interface MainTableViewController : UIViewController
@property (retain, nonatomic)  HYSegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UINavigationItem *mainNavigationItem;

@end
