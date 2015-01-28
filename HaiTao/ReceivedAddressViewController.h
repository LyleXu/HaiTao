//
//  ReceivedAddressViewController.h
//  HaiTao
//
//  Created by gtcc on 1/27/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceivedAddressViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray* items;
@end
