//
//  RegisterViewController.m
//  HaiTao
//
//  Created by gtcc on 1/16/15.
//  Copyright (c) 2015 home. All rights reserved.
//

#import "RegisterViewController.h"
#import "CountryPhoneTableViewController.h"
#define kLeftMargin				20.0
#define kRightMargin			20.0

#define kTextFieldWidth			160.0
#define kTextFieldHeight		25

#define kViewTag				100

static NSString *kSourceKey = @"sourceKey";
static NSString *kViewKey = @"viewKey";

@implementation RegisterViewController
@synthesize registerTableview;
@synthesize btnRegister;
@synthesize lblCountryPhoneCode, txtUser,txtPass,txtConfirmPass;
@synthesize dataArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSArray arrayWithObjects:
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       @"国家区号: ",kSourceKey,
                       self.lblCountryPhoneCode,kViewKey,
                       nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       @"手机号: ",kSourceKey,
                       self.txtUser,kViewKey,
                       nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       @"密码: ",kSourceKey,
                       self.txtPass,kViewKey,
                       nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:
                       @"确认密码: ",kSourceKey,
                       self.txtConfirmPass,kViewKey,
                       nil],

                      nil];
}


- (IBAction)registerWithPhoneNumber:(id)sender {
}


#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"registerCell";
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

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showCountryFromRegister"]) {
        CountryPhoneTableViewController *controller = (CountryPhoneTableViewController *)[segue destinationViewController];
        controller.delegate = self;
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

- (UITextField *)txtUser{
    if (txtUser == nil) {
        CGRect frame = CGRectMake(kLeftMargin + 110, 10.0, kTextFieldWidth, kTextFieldHeight);
        txtUser = [[UITextField alloc] initWithFrame:frame];
        txtUser.borderStyle = UITextBorderStyleNone;
        txtUser.textColor = [UIColor blackColor];
        txtUser.font = [UIFont systemFontOfSize:17];
        txtUser.placeholder = @"Phone Number";
        txtUser.backgroundColor = [UIColor whiteColor];
        txtUser.autocorrectionType = UITextAutocorrectionTypeNo;
        txtUser.keyboardType = UIKeyboardTypeNumberPad;
        txtUser.clearButtonMode = UITextFieldViewModeWhileEditing;
        txtUser.tag = kViewTag;
        txtUser.delegate = self;
    }
    return txtUser;
}

- (UITextField *)txtPass{
    if (txtPass == nil) {
        CGRect frame = CGRectMake(kLeftMargin + 110, 10.0, kTextFieldWidth, kTextFieldHeight);
        txtPass = [[UITextField alloc] initWithFrame:frame];
        txtPass.borderStyle = UITextBorderStyleNone;
        txtPass.textColor = [UIColor blackColor];
        txtPass.font = [UIFont systemFontOfSize:17];
        txtPass.placeholder = @" Your Password";
        txtPass.backgroundColor = [UIColor whiteColor];
        txtPass.autocorrectionType = UITextAutocorrectionTypeNo;
        txtPass.keyboardType = UIKeyboardTypeDefault;
        txtPass.returnKeyType = UIReturnKeyDone;
        txtPass.clearButtonMode = UITextFieldViewModeWhileEditing;
        txtPass.tag = kViewTag;
        txtPass.delegate = self;
        txtPass.secureTextEntry = YES; // Make password display "*******"
    }
    return txtPass;
}

- (UITextField *)txtConfirmPass{
    if (txtConfirmPass == nil) {
        CGRect frame = CGRectMake(kLeftMargin + 110, 10.0, kTextFieldWidth, kTextFieldHeight);
        txtConfirmPass = [[UITextField alloc] initWithFrame:frame];
        txtConfirmPass.borderStyle = UITextBorderStyleNone;
        txtConfirmPass.textColor = [UIColor blackColor];
        txtConfirmPass.font = [UIFont systemFontOfSize:17];
        txtConfirmPass.placeholder = @" Confirm Password";
        txtConfirmPass.backgroundColor = [UIColor whiteColor];
        txtConfirmPass.autocorrectionType = UITextAutocorrectionTypeNo;
        txtConfirmPass.keyboardType = UIKeyboardTypeDefault;
        txtConfirmPass.returnKeyType = UIReturnKeyDone;
        txtConfirmPass.clearButtonMode = UITextFieldViewModeWhileEditing;
        txtConfirmPass.tag = kViewTag;
        txtConfirmPass.delegate = self;
        txtConfirmPass.secureTextEntry = YES; // Make password display "*******"
    }
    return txtConfirmPass;
}

#pragma mark UITextFieldDelegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)returnLoginPage:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)passValue:(NSString *)value
{
    self.lblCountryPhoneCode.text = value;
}

@end
