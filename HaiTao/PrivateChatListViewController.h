//
//  PrivateChatListViewController.h
//  HaiTao
//
//  Created by gtcc on 11/26/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrivateChatListCell.h"
#import "HYSegmentedControl.h"
@interface PrivateChatListViewController : UIViewController
@property (retain, nonatomic)  HYSegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@end
