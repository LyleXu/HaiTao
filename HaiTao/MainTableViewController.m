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
#import "BuyerShowCell.h"

int CurrentSelectedSegmentedControlIndex = 0;
@interface MainTableViewController ()<UITableViewDataSource,UITableViewDelegate,HYSegmentedControlDelegate,POHorizontalListDelegate,UIActionSheetDelegate,AWActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) NSArray* actionSheetItems;
@property (strong, nonatomic) NSArray* sellerGoodsItems;
@property (strong, nonatomic) NSArray* buyerGoodsItems;
@end

@implementation MainTableViewController
{
    YIFullScreenScroll* _fullScreenDelegate;
}
@synthesize segmentedControl;
@synthesize actionSheetItems = _actionSheetItems;
@synthesize sellerGoodsItems = _sellerGoodsItems;
@synthesize buyerGoodsItems = _buyerGoodsItems;

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

-(NSArray*)buyerGoodsItems
{
    if(_buyerGoodsItems == nil)
    {
        _buyerGoodsItems = [DataLayer GetBuyerGoodsItems];
    }
    return _buyerGoodsItems;
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
    return CurrentSelectedSegmentedControlIndex == 0 ? self.sellerGoodsItems.count : self.buyerGoodsItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * tableIdentifier= CurrentSelectedSegmentedControlIndex ==0 ? @"MaijiaCell" : @"BuyerShowCell";
    if(CurrentSelectedSegmentedControlIndex == 0)
    {
       MaijiaTableViewCell*  cell=[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        
        if(cell==nil)
        {
            // first load
            cell=[[MaijiaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        
        [self InitSellerGoodsCell:cell SellerGoodInfo:self.sellerGoodsItems[indexPath.row]];
        
        return cell;
    }else
    {
        BuyerShowCell*  cell=[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        
        if(cell==nil)
        {
            // first load
            cell=[[BuyerShowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        
        [self InitBuyerShowCell:cell BuyerShowGoodsInfo:self.buyerGoodsItems[indexPath.row]];
        
        return cell;
    }
}

-(void)InitSellerGoodsCell:(MaijiaTableViewCell*) cell SellerGoodInfo:(NSDictionary*) sellerGoodsInfo
{
    [cell.btnSellerName setTitle:sellerGoodsInfo[@"name"] forState:UIControlStateNormal];
    [cell.sellerAvatar setImage:[UIImage imageNamed:sellerGoodsInfo[@"sellerAvatar"]] forState:UIControlStateNormal];
    cell.sellerAvatar.layer.borderWidth = 0;
    cell.lblSellerLocation.text = sellerGoodsInfo[@"location"];
    cell.lblSellerDescription.text = sellerGoodsInfo[@"description"];

    [cell.btnTag1 setTitle:sellerGoodsInfo[@"tags"][0] forState:UIControlStateNormal];
    [cell.btnTag2 setTitle:sellerGoodsInfo[@"tags"][1] forState:UIControlStateNormal];
    [cell.btnTag3 setTitle:sellerGoodsInfo[@"tags"][0] forState:UIControlStateNormal];
    
    [self InitComments:cell CommentItems:sellerGoodsInfo[@"comments"] LastLocationY:417];
    
    // good pics
    [self InitGoodsContainer:cell.GoodsImageContainer GoodsPics:sellerGoodsInfo[@"goodsPics"]];
    
    // set Share button's style
    [self InitRoundCornerButton:cell.GoodsImageContainer];
}

-(void)InitBuyerShowCell:(BuyerShowCell*) cell BuyerShowGoodsInfo:(NSDictionary*) buyerShowGoodsInfo
{
    [cell.btnBuyerName setTitle:buyerShowGoodsInfo[@"name"] forState:UIControlStateNormal];
    [cell.buyerAvatar setImage:[UIImage imageNamed:buyerShowGoodsInfo[@"buyerAvatar"]] forState:UIControlStateNormal];
    cell.buyerAvatar.layer.borderWidth = 0;
    
    [cell.btnBuyerTag1 setTitle:buyerShowGoodsInfo[@"tags"][0] forState:UIControlStateNormal];
    [cell.btnBuyerTag2 setTitle:buyerShowGoodsInfo[@"tags"][1] forState:UIControlStateNormal];
    
    [self InitComments:cell CommentItems:buyerShowGoodsInfo[@"comments"] LastLocationY:407];
    [self InitGoodsContainer:cell.buyerGoodsImageContainer GoodsPics:buyerShowGoodsInfo[@"goodsPics"]];
    [self InitRoundCornerButton:cell.buyerGoodsImageContainer];
}

-(void)InitRoundCornerButton:(UIView*)parent
{
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(247, 8, 60, 22)];
    [button setTitle:@"分 享" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(shareTo:) forControlEvents:UIControlEventTouchUpInside];
    
    button.layer.borderWidth = 1;
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 4;
    
    [parent addSubview:button];
}

-(void)InitGoodsContainer:(UIView*)picContainter GoodsPics:(NSArray*)picNames
{
    NSMutableArray* goodsImageList = [[NSMutableArray alloc] init];
    for (NSString* goodsPicName in picNames) {  // get goods pics
        ListItem *item1= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:goodsPicName] text:@"maijia"];
        [goodsImageList addObject:item1];
    }
    
    POHorizontalList* list = [[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 320.0) title:@"abc" items:goodsImageList Distance_between_items:0.0];
    [list setDelegate:self];
    [picContainter addSubview:list];
}

-(void)InitComments:(UIView*)cell CommentItems:(NSArray*)comments LastLocationY:(CGFloat)lastLocationY
{
    CGFloat commentAvatarHeight = 22;
    
    for (id item in comments) {
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, lastLocationY + 1, commentAvatarHeight, commentAvatarHeight)];
        imageView.image = [UIImage imageNamed:item[1]];
        
        [cell addSubview:imageView];
        
        UILabel* lblComment = [[UILabel alloc] init];
        lblComment.font = [UIFont systemFontOfSize:14];
        lblComment.numberOfLines = 0;
        lblComment.lineBreakMode = NSLineBreakByCharWrapping;
        CGFloat height = [self GetLabelHeightByContent:item[2]];
        lblComment.frame = CGRectMake(commentAvatarHeight + 10, lastLocationY + 1, 280, height);
        lblComment.text = item[2];
        [cell addSubview:lblComment];
        
        lastLocationY = lastLocationY + height;
    }
}

-(CGFloat)GetLabelHeightByContent:(NSString*)labelStr
{
    CGSize labelSize = {0, 0};
    labelSize = [labelStr sizeWithFont:[UIFont systemFontOfSize:14]
                     constrainedToSize:CGSizeMake(280.0, 5000)
                         lineBreakMode:NSLineBreakByWordWrapping];
    return labelSize.height;
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
    CurrentSelectedSegmentedControlIndex = (int)index;
    
    [self.mainTableView reloadData];
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
