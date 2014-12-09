//
//  CameraViewController.m
//  HaiTao
//
//  Created by gtcc on 11/14/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "CameraViewController.h"

@implementation CameraViewController

-(void)showCamera
{
    CustomImagePickerController *picker = [[CustomImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }else{
        [picker setIsSingle:YES];
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    [picker setCustomDelegate:self];
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //[self showCamera];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self showCamera];
}

-(void)cancelCamera
{
    //[self showCamera];
}

- (void)cameraPhoto:(UIImage *)image  //选择完图片
{
    ImageFilterProcessViewController *fitler = [[ImageFilterProcessViewController alloc] init];
    [fitler setDelegate:self];
    fitler.currentImage = image;
    [self presentViewController:fitler animated:YES completion:nil];
}
- (void)imageFitlerProcessDone:(UIImage *)image //图片处理完
{
    //self.imgTest.image = image;
    MarkLocationViewController* mlController = [self.storyboard instantiateViewControllerWithIdentifier:@"marklocationviewcontroller"];
    mlController.imgCaptured = [image copy];
    [self.navigationController pushViewController:mlController animated:YES];
    //[self presentViewController:mlController animated:YES completion:nil];
}

@end
