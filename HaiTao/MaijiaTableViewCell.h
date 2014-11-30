//
//  MaijiaTableViewCell.h
//  HaiTao
//
//  Created by gtcc on 11/7/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaijiaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *sellerAvatar;
@property (weak, nonatomic) IBOutlet UIButton *btnSellerName;
@property (weak, nonatomic) IBOutlet UILabel *lblSellerLocation;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet UILabel *lblSellerDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblGoodCount;
@property (weak, nonatomic) IBOutlet UILabel *lblCommentsCount;
@property (weak, nonatomic) IBOutlet UIView *GoodsImageContainer;
@property (weak, nonatomic) IBOutlet UIButton *btnTag1;
@property (weak, nonatomic) IBOutlet UIButton *btnTag2;
@property (weak, nonatomic) IBOutlet UIButton *btnTag3;
@property (weak, nonatomic) IBOutlet UIButton *btnZan;
@property (weak, nonatomic) IBOutlet UIButton *btnComment;

@end
