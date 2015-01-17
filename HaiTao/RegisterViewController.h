//
//  RegisterViewController.h
//  HaiTao
//
//  Created by gtcc on 1/16/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"
@interface RegisterViewController : UIViewController<UITableViewDataSource, UITextFieldDelegate,PassValueDelegate>
{
    IBOutlet UITableView *registerTableview;
    UIButton *btnRegister;
    
    UILabel *lblCountryPhoneCode;
    UITextField *txtUser;
    UITextField *txtPass;
    UITextField *txtConfirmPass;
    
    NSArray *dataArray;
}
@property (nonatomic, retain) UILabel *lblCountryPhoneCode;
@property (nonatomic, retain) UITextField *txtUser;
@property (nonatomic, retain) UITextField *txtPass;
@property (nonatomic, retain) UITextField *txtConfirmPass;
@property (nonatomic, retain) NSArray *dataArray;
@property (retain, nonatomic) IBOutlet UIButton *btnRegister;
@property (retain, nonatomic) IBOutlet UITableView *registerTableview;
@end
