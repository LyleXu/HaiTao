//
//  MaijiaTableViewCell.h
//  HaiTao
//
//  Created by gtcc on 11/7/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaijiaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *sellerAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblSellerName;
@property (weak, nonatomic) IBOutlet UILabel *lblSellerLocation;
@property (weak, nonatomic) IBOutlet UIImageView *imgSellerPicture;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet UILabel *lblSellerDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblGoodCount;
@property (weak, nonatomic) IBOutlet UIImageView *imgComments;
@property (weak, nonatomic) IBOutlet UILabel *lblCommentsCount;
@property (weak, nonatomic) IBOutlet UIView *GoodsImageContainer;

@end
