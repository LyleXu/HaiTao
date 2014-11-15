//
//  CustomImagePickerController.h
//  MeiJiaLove
//
//  Created by Wu.weibin on 13-7-9.
//  Copyright (c) 2013年 Wu.weibin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomImagePickerControllerDelegate;

@interface CustomImagePickerController : UIImagePickerController
<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    id<CustomImagePickerControllerDelegate> __unsafe_unretained _customDelegate;
}
@property(nonatomic)BOOL isSingle;
@property(unsafe_unretained)id<CustomImagePickerControllerDelegate> customDelegate;
@end

@protocol CustomImagePickerControllerDelegate <NSObject>

- (void)cameraPhoto:(UIImage *)image;
- (void)cancelCamera;
@end
