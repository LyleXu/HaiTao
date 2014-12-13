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
@property (weak, nonatomic) IBOutlet UIButton *btnTag;
@property (weak, nonatomic) IBOutlet UIButton *btnLocation;

@property (strong, nonatomic) UIImage* imgCaptured;

@property (strong, nonatomic) NSMutableArray* tagLocations;
@end
