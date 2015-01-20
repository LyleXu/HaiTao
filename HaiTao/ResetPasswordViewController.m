//
//  ResetPasswordViewController.m
//  HaiTao
//
//  Created by gtcc on 1/18/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "Constraint.h"
#import "CountryPhoneTableViewController.h"
#import "SetNewPasswordViewController.h"
#import "Utility.h"
#import "DataLayer.h"

static NSString *kSourceKey = @"sourceKey";
static NSString *kViewKey = @"viewKey";
@implementation ResetPasswordViewController
@synthesize lblCountryPhoneCode,txtPhone,dataArray,ResetTableView;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataArray = [NSArray arrayWithObjects:
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       @"国家区号: ",kSourceKey,
                       self.lblCountryPhoneCode,kViewKey,
                       nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       @"手机号: ",kSourceKey,
                       self.txtPhone,kViewKey,
                       nil],
                      nil];
    self.editing = NO;
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"resetCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
        // reuseIdentifier:identifier] autorelease];
    }else {
        UIView *viewToCheck = nil;
        viewToCheck = [cell.contentView viewWithTag:kViewTag];
        if (viewToCheck) {
            [viewToCheck removeFromSuperview];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //配置单元格
    cell.textLabel.text = [[dataArray objectAtIndex:indexPath.row] valueForKey:kSourceKey];
    if(indexPath.row == 0)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIButton* lblPhone = [[self.dataArray objectAtIndex:indexPath.row] valueForKey:kViewKey];
        [cell.contentView addSubview:lblPhone];
    }else
    {
        UITextField *tmpTxtField = [[self.dataArray objectAtIndex:indexPath.row] valueForKey:kViewKey];
        [cell.contentView addSubview:tmpTxtField];
    }
    
    return cell;
}

-(void)passValue:(NSString *)value
{
    self.lblCountryPhoneCode.text = value;
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showCountry"]) {
        CountryPhoneTableViewController *controller = (CountryPhoneTableViewController *)[segue destinationViewController];
        controller.delegate = self;
    }else if([[segue identifier] isEqualToString:@"toResetPwd"])
    {
        
        //SetNewPasswordViewController* controller = (SetNewPasswordViewController*)[segue destinationViewController];
        
    }
}
- (IBAction)toSetNewPassword:(id)sender {
    NSString* msg = [NSString stringWithFormat:@"我们将发送验证码到这个号码:\n%@",self.txtPhone.text];
    [Utility showConfirmMessage:@"确认手机号码" message:msg delegate:self];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSString* msg = [[NSString alloc] initWithFormat:@"您按下的第%d个按钮！",buttonIndex];
    if(buttonIndex == 1)
    {
        // ask server to send the verification code
        NSMutableDictionary* result = [DataLayer ForgetPassword:self.txtPhone.text];
        NSString* errorCode = result[@"s"];
        if ([errorCode isEqualToString:SUCCESS]) {
            NSString* verificatoinCode =  [NSString stringWithFormat:@"%d", [[result objectForKey:@"code"] intValue]];
            SetNewPasswordViewController* mlController = [self.storyboard instantiateViewControllerWithIdentifier:@"SetNewPasswordViewController"];
            NSLog(@"verification code:%@",verificatoinCode);
            mlController.verificationCode = verificatoinCode;
            mlController.uid = [NSString stringWithFormat:@"%d", [[result objectForKey:@"u"] intValue]];
            [self.navigationController pushViewController:mlController animated:YES];
        }else
        {
            [Utility showErrorMessage:errorCode];
        }
    }
}

#pragma mark -
#pragma mark TextFields

- (UILabel *)lblCountryPhoneCode{
    if (lblCountryPhoneCode == nil) {
        CGRect frame = CGRectMake(kLeftMargin + 110, 10.0, kTextFieldWidth, kTextFieldHeight);
        lblCountryPhoneCode = [[UILabel alloc] initWithFrame:frame];
        lblCountryPhoneCode.backgroundColor = [UIColor whiteColor];
        lblCountryPhoneCode.tag = kViewTag;
    }
    return lblCountryPhoneCode;
}

- (UITextField *)txtPhone{
    if (txtPhone == nil) {
        CGRect frame = CGRectMake(kLeftMargin + 110, 10.0, kTextFieldWidth, kTextFieldHeight);
        txtPhone= [[UITextField alloc] initWithFrame:frame];
        txtPhone.borderStyle = UITextBorderStyleNone;
        txtPhone.textColor = [UIColor blackColor];
        txtPhone.font = [UIFont systemFontOfSize:17];
        txtPhone.placeholder = @"请输入绑定的手机号";
        txtPhone.backgroundColor = [UIColor whiteColor];
        txtPhone.autocorrectionType = UITextAutocorrectionTypeNo;
        txtPhone.keyboardType = UIKeyboardTypeNumberPad;
        txtPhone.clearButtonMode = UITextFieldViewModeWhileEditing;
        txtPhone.tag = kViewTag;
        txtPhone.delegate = self;
    }
    return txtPhone;
}
- (IBAction)returnPreviousPage:(id)sender {
        [self dismissViewControllerAnimated:true completion:nil];
}

@end
