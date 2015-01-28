//
//  ShopCartViewController.h
//  HaiTao
//
//  Created by gtcc on 11/17/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCartViewController : UIViewController
@property (strong,nonatomic) NSMutableArray* cartItems;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *lblTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblGoodsMoney;
@property (weak, nonatomic) IBOutlet UIButton *btnJieSuan;
@end
