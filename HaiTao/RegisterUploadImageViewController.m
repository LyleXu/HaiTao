//
//  RegisterUploadImageViewController.m
//  HaiTao
//
//  Created by gtcc on 1/23/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "RegisterUploadImageViewController.h"
#import "MainTabBarController.h"
#import "DataLayer.h"
#import "Utility.h"
@implementation RegisterUploadImageViewController

- (IBAction)toMainPage:(id)sender {
    NSMutableDictionary* result = [DataLayer UploadUserAvatar:self.imgAvatar.image];
    NSString* returnCode = result[@"s"];
    if([returnCode isEqualToString:SUCCESS])
    {
        MainTabBarController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabBarController"];
        [self presentViewController:controller animated:YES completion:nil];
    }else
    {
        [Utility showErrorMessage:returnCode];
    }
}
- (IBAction)takePicture:(id)sender {
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择头像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择头像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate methods
//完成选择图片
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    //加载图片
    self.imgAvatar.image = image;
    //选择框消失
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//取消选择图片
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
    }
}

@end
