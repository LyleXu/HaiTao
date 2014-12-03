//
//  GoodsDetailViewController.h
//  HaiTao
//
//  Created by gtcc on 11/18/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYSegmentedControl.h"
@interface GoodsDetailViewController : UIViewController
@property (retain, nonatomic)  HYSegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIButton *btnToShopCart;
@property (strong, nonatomic) NSString* goodsId;
@property (weak, nonatomic) IBOutlet UIImageView *imgSellerAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblSellerName;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UIImageView *imgGoods;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblGoodsType;
@property (weak, nonatomic) IBOutlet UILabel *lblGoodsStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblCanPreOrder;
@end
