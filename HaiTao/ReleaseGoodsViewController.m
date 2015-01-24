//
//  ReleaseGoodsViewController.m
//  HaiTao
//
//  Created by gtcc on 11/18/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "ReleaseGoodsViewController.h"
#import "DataLayer.h"
#import "Utility.h"
#import "MainTabBarController.h"
@implementation ReleaseGoodsViewController
@synthesize imgCaptured;
-(void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleBordered target:self action:@selector(releaseGoods)];
//    [self.navigationItem setRightBarButtonItem:barButtonItem];
//        self.navigationItem.title = @"上架";
    
    self.FirstImageView.image = imgCaptured;
    

    
//    if (self.toolbarItems.count == 0) {
//        [self.navigationController setToolbarHidden:YES animated:YES];
//    }
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    if (self.toolbarItems.count == 0) {
//        [self.navigationController setToolbarHidden:YES animated:animated];
//    }
//}
- (IBAction)releaseGoods:(id)sender {
    // upload the pic first
    NSMutableDictionary* uploadResult = [DataLayer UploadGoodsImage:self.FirstImageView.image];
    NSString* uploadReturnCode = uploadResult[@"s"];
    if([uploadReturnCode isEqualToString:SUCCESS])
    {
        NSMutableDictionary* result = [DataLayer AddorUpdateGoods:self.txtTitle.text price:@"1310" number:@"20" goodsDescription:self.txtDescription.text image:uploadResult[@"p"] tag:@"1" buyTagName:@"2" buyTagID:@"3"];

        NSString* returnCode = result[@"s"];
        if([returnCode isEqualToString:SUCCESS])
        {
            MainTabBarController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabBarController"];
            [self presentViewController:controller animated:YES completion:nil];
        }else
        {
            [Utility showErrorMessage:returnCode];
        }

    }else
    {
        [Utility showErrorMessage:uploadReturnCode];
    }
}
- (IBAction)toPreviousPage:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];

}

@end
