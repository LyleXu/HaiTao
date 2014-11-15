//
//  MainTabBarController.m
//  HaiTao
//
//  Created by gtcc on 11/14/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "MainTabBarController.h"

@implementation MainTabBarController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //[self addCenterButtonWithImage:[UIImage imageNamed:@"camera-icon@2x.png" ] highlightImage:[UIImage imageNamed:@"camera-icon@2x.png"]];
}

// Create a custom UIButton and add it to the center of our tab bar
-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0)
        button.center = self.tabBar.center;
    else
    {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        button.center = center;
    }
   // [button addTarget:self action:@selector(TouchDown) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)TouchDown
{
    //NSLog(@"sdfsdfsdfsdfsddddddddd");
    //CameraViewController* controller = [[CameraViewController alloc]init];
    //[self presentViewController:controller animated:YES completion:nil];
}

@end
