//
//  VerifyCodeViewController.m
//  HaiTao
//
//  Created by gtcc on 1/23/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "VerifyCodeViewController.h"
#import "DataLayer.h"
#import "Utility.h"
#import "RegisterUploadImageViewController.h"
@implementation VerifyCodeViewController
@synthesize verificationCode,txtCode,lblCode;

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.lblCode.text = self.verificationCode;
    
    self.navigationItem.title = @"验证手机号";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStyleBordered target:self action:@selector(toNextPage)];
}
- (void)toNextPage
{
    // check if it's seller orbuyer
    
    NSMutableDictionary* result = nil;
    
    if([self.userType isEqualToString:@"0"])
    {
         result= [DataLayer RegisterSeller:self.phone password:self.password nickName:self.userName sellerDescription:@"" messageVerification:self.lblCode.text sellerName:self.userName];
    }else
    {
         result = [DataLayer RegisterBuyer:self.phone password:self.password nickName:self.userName messageVerification:self.lblCode.text];
    }
   
    NSString* returnCode = result[@"s"];
    if ([returnCode isEqualToString:SUCCESS]) {
        [Utility setUserId:result[@"u"]];
        [Utility setUserToken:result[@"tk"]];
        [Utility setUserType:result[@"ut"]];
        
        RegisterUploadImageViewController* mlController = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterUploadImageViewController"];
        [self presentViewController:mlController animated:YES completion:nil];
        
    }else
    {
        [Utility showErrorMessage:returnCode];
    }
    
}
@end
