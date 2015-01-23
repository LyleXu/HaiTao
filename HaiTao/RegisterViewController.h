//
//  RegisterViewController.h
//  HaiTao
//
//  Created by gtcc on 1/16/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"
@interface RegisterViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate,PassValueDelegate,UIAlertViewDelegate>
{
    IBOutlet UITableView *registerTableview;
    
    UILabel *lblCountryPhoneCode;
    UITextField *txtUser;
    UITextField *txtPass;
    
    NSArray *dataArray;
}
@property (nonatomic, retain) UILabel *lblCountryPhoneCode;
@property (nonatomic, retain) UITextField *txtUser;
@property (nonatomic, retain) UITextField *txtPass;
@property (nonatomic, retain) NSArray *dataArray;
@property (retain, nonatomic) IBOutlet UITableView *registerTableview;

@property (nonatomic,strong) NSString* userName;
@property (nonatomic,strong) NSString* userType;
@end
