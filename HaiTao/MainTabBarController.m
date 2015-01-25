//
//  MainTabBarController.m
//  HaiTao
//
//  Created by gtcc on 11/14/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainTableViewController.h"
#import "Constraint.h"
@implementation MainTabBarController
@synthesize centerButton;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.viewControllers = [NSArray arrayWithObjects:
                            [self viewControllerWithTabTitle:@"" image:[UIImage imageNamed:@"feed.png"] storyboardID:@"MainTableViewController"],
                            [self viewControllerWithTabTitle:@"" image:[UIImage imageNamed:@"faxian.png"] storyboardID:@"SearchViewController"],
                            [self viewControllerWithTabTitle:@"" image:nil storyboardID:nil],
                            [self viewControllerWithTabTitle:@"" image:[UIImage imageNamed:@"xiaoxi.png"] storyboardID:@"PrivateChatListViewController"],
                            [self viewControllerWithTabTitle:@"" image:[UIImage imageNamed:@"geren.png"] storyboardID:@"UserViewController"], nil];
    [self addCenterButtonWithImage:[UIImage imageNamed:@"camera-icon.png"] highlightImage:nil];
}

// Create a view controller and setup it's tab bar item with a title and image
-(UIViewController*) viewControllerWithTabTitle:(NSString*) title image:(UIImage*)image storyboardID:(NSString*)sbIdentifier
{
    UIViewController* viewController = nil;
    if(sbIdentifier)
    {
        UINavigationController*  nc1 = [[UINavigationController alloc] init];
        viewController = [self.storyboard instantiateViewControllerWithIdentifier:sbIdentifier];
        viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image tag:0];
        nc1.viewControllers = [NSArray arrayWithObjects:viewController, nil];
        return nc1;
        
    }else
    {
        viewController = [[UIViewController alloc] init];
        viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image tag:0];
        UINavigationController*  nc1 = [[UINavigationController alloc] init];
        nc1.viewControllers = [NSArray arrayWithObjects:viewController, nil];
        return nc1;
        //return viewController;
    }
}

// Create a custom UIButton and add it to the center of our tab bar
-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage
{
    centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    centerButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    centerButton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [centerButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [centerButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [centerButton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    CGFloat buttonHeight = buttonImage.size.height;
    CGFloat tabbarheight = self.tabBar.frame.size.height;
    CGFloat heightDifference = buttonHeight - tabbarheight;
    if (heightDifference < 0)
    {
        centerButton.center = self.tabBar.center;
        centerButton.frame = CGRectMake(centerButton.frame.origin.x, centerButton.frame.origin.y +5, centerButton.frame.size.width,centerButton.frame.size.height);
    }
    else
    {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        centerButton.center = center;
    }
   // [button addTarget:self action:@selector(TouchDown) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:centerButton];
}

-(void)btnClick
{
    [self showCamera];
}

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

- (void)cameraPhoto:(UIImage *)image  //选择完图片
{
    ImageFilterProcessViewController *filter = [[ImageFilterProcessViewController alloc] init];
    [filter setDelegate:self];
    filter.currentImage = image;
    [self presentViewController:filter animated:YES completion:nil];
}

- (void)imageFitlerProcessDone:(UIImage *)image //图片处理完
{
    UINavigationController* nc = [[UINavigationController alloc] init];
    MarkLocationViewController* mlController = [self.storyboard instantiateViewControllerWithIdentifier:@"MarkLocationViewController"];
    mlController.imgCaptured = [image copy];
    nc.viewControllers = [NSArray arrayWithObjects:mlController, nil];
    [self presentViewController:nc animated:YES completion:nil];
}

-(void)cancelCamera
{
    //[self showCamera];
}

@end
