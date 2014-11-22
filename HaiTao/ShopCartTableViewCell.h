//
//  ShopCartTableViewCell.h
//  HaiTao
//
//  Created by gtcc on 11/22/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCartTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageGoods;
@property (weak, nonatomic) IBOutlet UILabel *lblGoodsName;
@property (weak, nonatomic) IBOutlet UILabel *lblGoodsStatus;
@property (weak, nonatomic) IBOutlet UITextField *txtAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UIButton *btnMinusOne;
@property (weak, nonatomic) IBOutlet UIButton *btnInreaseOne;

@end
