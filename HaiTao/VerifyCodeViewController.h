//
//  VerifyCodeViewController.h
//  HaiTao
//
//  Created by gtcc on 1/23/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerifyCodeViewController : UIViewController
@property (nonatomic,strong) NSString* verificationCode;
@property (weak, nonatomic) IBOutlet UITextField *txtCode;
@property (weak, nonatomic) IBOutlet UILabel *lblCode;


@property (nonatomic,strong) NSString* userName;
@property (nonatomic,strong) NSString* userType;
@property (nonatomic,strong) NSString* phone;
@property (nonatomic,strong) NSString* password;
@property (nonatomic,strong) NSString* areaCode;
@end
