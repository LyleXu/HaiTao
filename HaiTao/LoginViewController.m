#import "LoginViewController.h"
#define kLeftMargin				20.0
#define kRightMargin			20.0

#define kTextFieldWidth			160.0
#define kTextFieldHeight		25

#define kViewTag				100

static NSString *kSourceKey = @"sourceKey";
static NSString *kViewKey = @"viewKey";

@implementation LoginViewController

@synthesize loginTableView;
@synthesize btnLogin;
@synthesize lblCountryPhoneCode, txtUser,txtPass;
@synthesize dataArray;
-(void)initImageClickEvent
{
    self.imageWeibo.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageWeiboClicked)];
    [self.imageWeibo addGestureRecognizer:singleTap];
}

-(void)imageWeiboClicked
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"LoginViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
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
					  nil];
	self.editing = NO;
    
    [self initImageClickEvent];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;

	txtUser = nil;
    lblCountryPhoneCode = nil;
	txtPass = nil;
	self.dataArray = nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[txtUser resignFirstResponder];
	[txtPass resignFirstResponder];
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSString *identifier = @"loginCell";
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
    if ([[segue identifier] isEqualToString:@"showCountry"]) {       
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

#pragma mark UITextFieldDelegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return YES;
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = @"收到网络回调";
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",result]
                                      delegate:nil
                             cancelButtonTitle:@"确定"
                             otherButtonTitles:nil];
    [alert show];
}

-(void)passValue:(NSString *)value
{
    self.lblCountryPhoneCode.text = value;
}

- (IBAction)Login:(id)sender {

}

- (IBAction)returnLoginPage:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
