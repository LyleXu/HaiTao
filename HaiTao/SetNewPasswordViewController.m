//
//  SetNewPasswordViewController.m
//  HaiTao
//
//  Created by gtcc on 1/18/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "SetNewPasswordViewController.h"
#import "LoginViewController.h"
#import "DataLayer.h"
#import "Utility.h"
@implementation SetNewPasswordViewController
@synthesize lblVeficationCode,verificationCode,uid,txtNewPassword,txtVerificationCode;
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.lblVeficationCode.text = self.verificationCode;
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(toLoginPage)];
    [self.navigationItem setRightBarButtonItem:barButtonItem];
}

-(void)toLoginPage
{
    // todo: server should return the uid as well.
    NSMutableDictionary* result = [DataLayer SetNewPassword:self.uid newPassword:self.txtNewPassword.text verificationCode:self.txtVerificationCode.text];
    NSString* errorCode = result[@"s"];
    if([errorCode isEqualToString:SUCCESS])
    {
        LoginViewController* ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:ctl animated:YES completion:nil];
    }else
    {
        [Utility showErrorMessage:errorCode];
    }
}

@end
