//
//  ResetPasswordViewController.h
//  HaiTao
//
//  Created by gtcc on 1/18/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"
@interface ResetPasswordViewController : UIViewController<UITableViewDataSource, UITextFieldDelegate,PassValueDelegate,UIAlertViewDelegate>{
    IBOutlet UITableView *ResetTableView;
    UILabel *lblCountryPhoneCode;
    UITextField *txtPhone;
    NSArray *dataArray;
}
@property (retain, nonatomic) IBOutlet UITableView *ResetTableView;

@property (nonatomic, retain) UILabel *lblCountryPhoneCode;
@property (nonatomic, retain) UITextField *txtPhone;
@property (nonatomic, retain) NSArray *dataArray;
@end
