//
//  CountryPhoneTableViewController.h
//  HaiTao
//
//  Created by gtcc on 11/8/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"
@interface CountryPhoneTableViewController : UIViewController<UITableViewDataSource,UITabBarControllerDelegate>
@property(nonatomic,assign) NSObject<PassValueDelegate> *delegate;
@end
