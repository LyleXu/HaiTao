//
//  UserInfoTableViewController.m
//  HaiTao
//
//  Created by gtcc on 11/14/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "UserInfoTableViewController.h"

@implementation UserInfoTableViewController


//upload user avatar
//NSString *urlString = @"http://114.215.83.218/d/v1/u/u/p?jc=&tk=C642125D688E38AEAA805FAA1D8E8253&u=1563";
//int result = [DataLayer uploadImage:urlString img:image];
//if(result == 1)
//{
//    
//}
- (IBAction)selectAvatar:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选 择 图 片"
                                                             delegate:self cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择",nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView: self.view];
}


//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
//    picker.delegate=self;
//    picker.allowsEditing=YES;
//    
//    switch (buttonIndex)
//    {
//        case 0:
//        {
//            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
//            {
//                picker.sourceType=UIImagePickerControllerSourceTypeCamera;
//            }
//            else
//            {
//                return;
//            }
//        }
//            break;
//        case 1:
//        {
//            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary])
//            {
//                picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
//            }
//        }
//            
//            break;
//        case 2:
//        {
//            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum])
//            {
//                picker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//            }
//        }
//            break;
//        default:
//        {
//            return;
//        }
//            break;
//    }
//    UIPopoverController * popOver = [[UIPopoverController alloc]initWithContentViewController: picker];
//
//    popOver.delegate = self;
//    self.popOverController = popOver;
//    [self.popOverController presentPopoverFromRect:CGRectMake(0,100, 0, 0) inView:self.view
//                          permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
//}
//
//
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    [self.popOverController dismissPopoverAnimated:YES];
//    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
//    [selectButton  setBackgroundImage: image forState: UIControlStateNormal];
//}
//
//
//-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    [self.popOverController dismissPopoverAnimated:YES];
//}

@end
