//
//  ReleaseGoodsViewController.h
//  HaiTao
//
//  Created by gtcc on 11/18/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReleaseGoodsViewController : UIViewController
@property (strong, nonatomic) UIImage* imgCaptured;

@property (weak, nonatomic) IBOutlet UIImageView *FirstImageView;
@property (weak, nonatomic) IBOutlet UITextView *txtTitle;
@property (weak, nonatomic) IBOutlet UITextView *txtDescription;
@end
