//
//  ShopCartViewController.h
//  HaiTao
//
//  Created by gtcc on 11/17/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCartViewController : UIViewController
@property (strong,nonatomic) NSArray* cartItems;
@property (weak, nonatomic) IBOutlet UITableView *table;
@end
