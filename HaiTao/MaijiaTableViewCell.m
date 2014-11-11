//
//  MaijiaTableViewCell.m
//  HaiTao
//
//  Created by gtcc on 11/7/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "MaijiaTableViewCell.h"

@implementation MaijiaTableViewCell
@synthesize lblSellerName,lblCommentsCount,lblGoodCount,lblSellerDescription,lblSellerLocation,btnShare,imgComments,imgGood,imgSellerPicture,sellerAvatar;

-(void)roundedImagesWithBorder:(UIImageView *)view :(NSString *)image
{
    [view.layer setCornerRadius:CGRectGetHeight([view bounds]) / 4];
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 2;
    view.layer.borderColor = [[UIColor grayColor] CGColor];
    view.layer.contents = (id)[[UIImage imageNamed:image] CGImage];
}

- (void)awakeFromNib {
    // Initialization code
    [self roundedImagesWithBorder : self.sellerAvatar : @"QQ_logo64X64"];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
