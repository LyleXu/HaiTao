//
//  CameraViewController.h
//  HaiTao
//
//  Created by gtcc on 11/14/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomImagePickerController.h"
#import "ImageFilterProcessViewController.h"
#import "MarkLocationViewController.h"
@interface CameraViewController : UIViewController
<CustomImagePickerControllerDelegate,ImageFitlerProcessDelegate>
{
    IBOutlet UIImageView *imageView;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgTest;
@end
