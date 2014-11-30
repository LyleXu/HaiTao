//
//  MainTableViewController.m
//  HaiTao
//
//  Created by gtcc on 11/7/14.
//  Copyright (c) 2014 home. All rights reserved.
//
#define DEVICE_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#import "MainTableViewController.h"
#import "MaijiaTableViewCell.h"
#import "YIFullScreenScroll.h"
#import "ShopCartViewController.h"
#import "AWActionSheet.h"
#import "DataLayer.h"
@interface MainTableViewController ()<UITableViewDataSource,UITableViewDelegate,HYSegmentedControlDelegate,POHorizontalListDelegate,UIActionSheetDelegate,AWActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) NSArray* actionSheetItems;
@property (strong, nonatomic) NSArray* sellerGoodsItems;
@end

@implementation MainTableViewController
{
    YIFullScreenScroll* _fullScreenDelegate;
}
@synthesize segmentedControl;
@synthesize actionSheetItems = _actionSheetItems;
@synthesize sellerGoodsItems = _sellerGoodsItems;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _fullScreenDelegate = [[YIFullScreenScroll alloc] initWithViewController:self];
    _fullScreenDelegate.shouldShowUIBarsOnScrollUp = YES;
    
    self.tabBarController.tabBar.frame = CGRectMake(0, 530, 320, 38);
}

-(NSArray*)sellerGoodsItems
{
    if(_sellerGoodsItems == nil)
    {
        _sellerGoodsItems = [DataLayer GetSellerGoodsItems];
    }
    return _sellerGoodsItems;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * tableIdentifier=@"MaijiaCell";
    MaijiaTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if(cell==nil)
    {
        // first load
        cell=[[MaijiaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    [self InitSellerGoodsCell:cell SellerGoodInfo:self.sellerGoodsItems[indexPath.row]];
    
    return cell;
}

-(void)InitSellerGoodsCell:(MaijiaTableViewCell*) cell SellerGoodInfo:(NSDictionary*) sellerGoodsInfo
{
    cell.btnSellerName.titleLabel.text = sellerGoodsInfo[@"name"];
    cell.sellerAvatar.imageView.image = [UIImage imageNamed:sellerGoodsInfo[@"sellerAvatar"]];
    cell.sellerAvatar.layer.borderWidth = 0;
    cell.lblSellerLocation.text = sellerGoodsInfo[@"location"];
    cell.lblSellerDescription.text = sellerGoodsInfo[@"description"];

    cell.btnTag1.titleLabel.text = sellerGoodsInfo[@"tags"][0];
    cell.btnTag2.titleLabel.text = sellerGoodsInfo[@"tags"][1];
    cell.btnTag3.titleLabel.text = sellerGoodsInfo[@"tags"][2];
    
    CGFloat lastLocationY = 417;
    CGFloat commentAvatarHeight = 22;
    for (id item in sellerGoodsInfo[@"comments"]) {
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, lastLocationY + 1, commentAvatarHeight, commentAvatarHeight)];
        imageView.image = [UIImage imageNamed:item[1]];
        
        [cell addSubview:imageView];
        
        UILabel* lblComment = [[UILabel alloc] initWithFrame:CGRectMake( commentAvatarHeight + 10, lastLocationY + 1, 200, commentAvatarHeight)];
        lblComment.text = item[2];
        [cell addSubview:lblComment];
        
        lastLocationY = lastLocationY + commentAvatarHeight;
    }
    
    // good pics
    NSMutableArray* goodsImageList = [[NSMutableArray alloc] init];
    for (NSString* goodsPicName in sellerGoodsInfo[@"goodsPics"]) {  // get goods pics
        ListItem *item1= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:goodsPicName] text:@"maijia"];
        [goodsImageList addObject:item1];
    }
    
    POHorizontalList* list = [[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 320.0) title:@"abc" items:goodsImageList];
    [list setDelegate:self];
    [cell.GoodsImageContainer addSubview:list];
    
    // set Share button's style
    cell.btnShare.layer.borderWidth = 1;
    cell.btnShare.layer.masksToBounds = YES;
    cell.btnShare.layer.cornerRadius = 4;
    
}

#pragma mark  POHorizontalListDelegate

- (void) didSelectItem:(ListItem *)item {
    //NSLog(@"Horizontal List Item %@ selected", item.imageTitle);
    GoodsDetailViewController* ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"GoodsDetailViewController"];
    [self.navigationController pushViewController:ctl animated:YES];
}

-(void)imageSellerAvatarClicked
{
    // jump to the seller page
    SellerViewController* controller = [[SellerViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

//
//  HYSegmentedControlDelegate method
//
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    if(index == 0)
    {
        // Maijia shang pin
    }else{
        // Maijia Show
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // title
    UILabel* lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(140, 0, 100, 24)];
    lblTitle.text = @"轻 奢";
    [self.navigationController.navigationBar addSubview:lblTitle] ;

    // shop cart
    UIImage *imageBtn = [UIImage imageNamed:@"shopcart.png"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(300, 0, 24, 20)];
    [btn setBackgroundImage:imageBtn forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setRightBarButtonItem:barButtonItem];
    
    // segment control
    UIView* segmentContainer = [[UIView alloc] initWithFrame:CGRectMake(40, 24, 260, 20)];
    self.segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:0 width:240 Titles:@[@"卖家商品",@"买家SHOW"] delegate:self] ;
    //[self.navigationController.navigationBar addSubview:segmentedControl];
    [segmentContainer addSubview:self.segmentedControl];
     [self.navigationController.navigationBar addSubview:segmentContainer];
    
    if (self.toolbarItems.count == 0) {
        [self.navigationController setToolbarHidden:YES animated:animated];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    // remove the segment control in the navigation bar
    for (UIView *views in self.navigationController.navigationBar.subviews) {
        if([views isKindOfClass:[UILabel class]])
        {
            [views removeFromSuperview];
        }
        
        for (UIView * subviews1 in views.subviews) {
            if ([subviews1 isKindOfClass:[HYSegmentedControl class]]) {
                //NSLog(@"找到啦");
                [subviews1 removeFromSuperview];
            }
        }
    }
    
    [self setTop:self.navigationController.navigationBar top:20.0];
    [self setTop:self.tabBarController.tabBar top:DEVICE_HEIGHT - self.tabBarController.tabBar.bounds.size.height];
}

-(void)setTop:(UIView*) view top:(double) top
{
    CGRect tmpFrame = view.frame;
    tmpFrame.origin.y =top;
    view.frame = tmpFrame;
}

-(void)onBtnTouch
{
    // go to shopcart
    ShopCartViewController* ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"shopcartcontroller"];
    [self.navigationController pushViewController:ctl animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.toolbarItems.count > 0) {
        [self.navigationController setToolbarHidden:NO animated:animated];
    }
    
    // set on viewDidAppear, if using tabBarController
    [_fullScreenDelegate layoutTabBarController];
}

#pragma mark -

#pragma mark UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_fullScreenDelegate scrollViewWillBeginDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{    
    [_fullScreenDelegate scrollViewDidScroll:scrollView];
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    return [_fullScreenDelegate scrollViewShouldScrollToTop:scrollView];;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    [_fullScreenDelegate scrollViewDidScrollToTop:scrollView];
}

-(NSArray*)actionSheetItems
{
    if(_actionSheetItems == nil)
    {
        _actionSheetItems = [[NSArray alloc] initWithObjects:
                             [[NSArray alloc] initWithObjects:@"QQ空间", @"share_Qzone.png", nil],
                             [[NSArray alloc] initWithObjects:@"新浪微博", @"weibo.png", nil],
                             [[NSArray alloc] initWithObjects:@"微信", @"weixin.png", nil],
                             nil];
    }
    return _actionSheetItems;
}

#pragma AWActionShee Delegate
-(int)numberOfItemsInActionSheet
{
    return (int)self.actionSheetItems.count;
}

-(AWActionSheetCell *)cellForActionAtIndex:(NSInteger)index
{
    AWActionSheetCell* cell = [[AWActionSheetCell alloc] init];
    
    cell.iconView.image = [UIImage imageNamed:self.actionSheetItems[index][1]];
    cell.titleLabel.text = self.actionSheetItems[index][0];
    cell.index = (int)index;
    return cell;
}

-(void)DidTapOnItemAtIndex:(NSInteger)index title:(NSString *)name
{
    NSLog(@"tap on %d",(int)index);
}
- (IBAction)shareTo:(id)sender {
    AWActionSheet *sheet = [[AWActionSheet alloc] initWithIconSheetDelegate:self ItemCount:[self numberOfItemsInActionSheet]];
    [sheet show];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
