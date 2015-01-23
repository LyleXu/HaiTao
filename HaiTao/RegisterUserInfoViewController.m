//
//  RegisterUserInfoViewController.m
//  HaiTao
//
//  Created by gtcc on 1/23/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "RegisterUserInfoViewController.h"
#import "RegisterViewController.h"
@implementation RegisterUserInfoViewController

- (IBAction)toRegisterPage:(id)sender {
    RegisterViewController* controler = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    controler.userName = self.txtUserName.text;
    controler.userType = [NSString stringWithFormat: @"%d", self.scUserType.selectedSegmentIndex];
    [self.navigationController pushViewController:controler animated:YES];
}
@end
