//
//  MainTabBarController.h
//  HaiTao
//
//  Created by gtcc on 11/14/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraViewController.h"
@interface MainTabBarController : UITabBarController<CustomImagePickerControllerDelegate,ImageFitlerProcessDelegate>
@property (nonatomic,strong) UIButton* centerButton;
@end
