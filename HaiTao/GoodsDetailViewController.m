//
//  GoodsDetailViewController.m
//  HaiTao
//
//  Created by gtcc on 11/18/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "DataLayer.h"
@implementation GoodsDetailViewController
@synthesize  goodsId;
-(void)viewDidLoad
{
    [super viewDidLoad];
    
//    // segment control
//    self.segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:124 Titles:@[@"卖家商品",@"买家SHOW"] delegate:self] ;
//    [self.view addSubview:self.segmentedControl];
    
    // Get the goods info by goods id
    NSDictionary* goodsInfo = [DataLayer GetGoodsInfoById:@"1111111111"];
    self.lblSellerName.text = goodsInfo[@"sellerName"];
    self.imgSellerAvatar.image = [UIImage imageNamed:goodsInfo[@"sellerAvatarName"]];
    self.lblLocation.text = goodsInfo[@"location"];
    self.imgGoods.image = [UIImage imageNamed:goodsInfo[@"goodsPic"]];
    self.lblPrice.text = goodsInfo[@"price"];
    self.lblGoodsType.text = goodsInfo[@"goodsType"];
    self.lblGoodsStatus.text = goodsInfo[@"goodsStatus"];
    self.lblCanPreOrder.text = goodsInfo[@"canPreOrder"];
    
    [self.btnToShopCart setBackgroundColor:[UIColor grayColor]];
    self.btnToShopCart.layer.borderWidth = 1;
    self.btnToShopCart.layer.masksToBounds = YES;
    self.btnToShopCart.layer.cornerRadius = 4;
}

@end
