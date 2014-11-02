//
//  LoginViewController.h
//  QQDemo
//
//  Created by DotHide on 11-8-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryPicker.h"
#import "WeiboSDK-Prefix.pch"
@protocol LoginViewControllerDelegate;
@interface LoginViewController : UIViewController <UITableViewDataSource, UITextFieldDelegate,CountryPickerDelegate, WBHttpRequestDelegate> {
	IBOutlet UITableView *loginTableView;
	UIButton *btnLogin;
	
    UITextField *txtCountryPhoneCode;
	UITextField *txtUser;
	UITextField *txtPass;
    
	NSArray *dataArray;
}

@property (nonatomic, retain) IBOutlet UITableView *loginTableView;

@property (nonatomic, retain) IBOutlet UIButton *btnLogin;
@property (nonatomic, retain) UITextField *txtCountryPhoneCode;
@property (nonatomic, retain) UITextField *txtUser;
@property (nonatomic, retain) UITextField *txtPass;
@property (nonatomic, retain) NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UIImageView *imageWeibo;

@end

