//
//  LoginViewController.h
//  QQDemo
//
//  Created by DotHide on 11-8-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK-Prefix.pch"
#import "CountryPhoneTableViewController.h"
#import "PassValueDelegate.h"
@protocol LoginViewControllerDelegate;
@interface LoginViewController : UIViewController <UITableViewDataSource, UITextFieldDelegate, WBHttpRequestDelegate,PassValueDelegate> {
	IBOutlet UITableView *loginTableView;
	UIButton *btnLogin;
	
    UILabel *lblCountryPhoneCode;
	UITextField *txtUser;
	UITextField *txtPass;
    
	NSArray *dataArray;
}

@property (nonatomic, retain) IBOutlet UITableView *loginTableView;

@property (nonatomic, retain) IBOutlet UIButton *btnLogin;
@property (nonatomic, retain) UILabel *lblCountryPhoneCode;
@property (nonatomic, retain) UITextField *txtUser;
@property (nonatomic, retain) UITextField *txtPass;
@property (nonatomic, retain) NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UIImageView *imageWeibo;

@end

