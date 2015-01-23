//
//  RegisterUploadImageViewController.h
//  HaiTao
//
//  Created by gtcc on 1/23/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterUploadImageViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@end
