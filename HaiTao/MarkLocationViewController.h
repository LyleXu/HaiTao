//
//  MarkLocationViewController.h
//  HaiTao
//
//  Created by gtcc on 11/14/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"
@interface MarkLocationViewController : UIViewController<PassValueDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageMarkLocation;
@property (weak, nonatomic) IBOutlet UILabel *lbltest;

@property (strong, nonatomic) UIImage* imgCaptured;
@end
