//
//  UserViewController.h
//  HaiTao
//
//  Created by gtcc on 11/14/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYSegmentedControl.h"
@interface UserViewController : UIViewController
@property (retain, nonatomic)  HYSegmentedControl *segmentedControl;
@property (retain, nonatomic) IBOutlet UIButton *btnModifyUserInfo;
@end
