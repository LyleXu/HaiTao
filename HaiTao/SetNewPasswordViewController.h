//
//  SetNewPasswordViewController.h
//  HaiTao
//
//  Created by gtcc on 1/18/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetNewPasswordViewController : UIViewController
@property (nonatomic,strong) IBOutlet UILabel* lblVeficationCode;
@property (nonatomic,strong) NSString* verificationCode;
@property (nonatomic,strong) NSString* uid;
@property (weak, nonatomic) IBOutlet UITextField *txtVerificationCode;
@property (weak, nonatomic) IBOutlet UITextField *txtNewPassword;
@end
