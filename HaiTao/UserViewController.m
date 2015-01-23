//
//  UserViewController.m
//  HaiTao
//
//  Created by gtcc on 11/14/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "UserViewController.h"
#import "UserInfoTableViewController.h"
#import "PSCollectionViewCell.h"
#import "CellView.h"
#import "UIImageView+WebCache.h"
#import "Utility.h"
#import "DataLayer.h"
#import "PAImageView.h"
@interface UserViewController()<PSCollectionViewDelegate,PSCollectionViewDataSource,UIScrollViewDelegate,PullPsCollectionViewDelegate>

@end

@implementation UserViewController
@synthesize segmentedControl,btnModifyUserInfo,collectionView,items;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.items = [NSMutableArray array];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置圆角半径
    self.btnModifyUserInfo.layer.masksToBounds = YES;
    self.btnModifyUserInfo.layer.cornerRadius = 4;
    
    // username
    NSMutableDictionary* result = [DataLayer GetUserInfo];
    NSString* returnCode = result[@"s"];
    if([returnCode isEqualToString:SUCCESS])
    {
        if(result[@"i"][@"nn"] != [NSNull null])
        {
            self.navigationItem.title = result[@"i"][@"nn"];
        }
    }else
    {
        
    }
    
    CGFloat imageSize = 75.f;
    PAImageView *avaterImageView = [[PAImageView alloc]initWithFrame:CGRectMake(20, 83, imageSize, imageSize) backgroundProgressColor:[UIColor whiteColor] progressColor:[UIColor lightGrayColor]];
    [self.view addSubview:avaterImageView];
    
    NSString* imageURL = [Utility getLargeImageURL:result[@"i"][@"p"]];
    [avaterImageView setImageURL:imageURL];
    
    //然后再给图层添加一个有色的边框，类似qq空间头像那样
    //self.imgAvatar.layer.borderWidth = 5;
    //self.imgAvatar.layer.borderColor = [[UIColor whiteColor] CGColor];

//    // collection view
//    collectionView = [[PullPsCollectionView alloc] initWithFrame:CGRectMake(0, 270, self.view.frame.size.width, self.view.frame.size.height)];
//    [self.view addSubview:collectionView];
//    collectionView.collectionViewDelegate = self;
//    collectionView.collectionViewDataSource = self;
//    collectionView.pullDelegate=self;
//    collectionView.backgroundColor = [UIColor clearColor];
//    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    
//    
//    collectionView.numColsPortrait = 3;
//    collectionView.numColsLandscape = 3;
//    
//    collectionView.pullArrowImage = [UIImage imageNamed:@"blackArrow"];
//    collectionView.pullBackgroundColor = [UIColor yellowColor];
//    collectionView.pullTextColor = [UIColor blackColor];
//    //    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 45)];
//    //    [headerView setBackgroundColor:[UIColor redColor]];
//    //    self.collectionView.headerView=headerView;
//    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:self.collectionView.bounds];
//    loadingLabel.text = @"Loading...";
//    loadingLabel.textAlignment = UITextAlignmentCenter;
//    collectionView.loadingView = loadingLabel;
//    
//    //    [self loadDataSource];
//    if(!collectionView.pullTableIsRefreshing) {
//        collectionView.pullTableIsRefreshing = YES;
//        [self performSelector:@selector(refreshTable) withObject:nil afterDelay:0];
//    }

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:240 Titles:@[@"交易",@"购物车"] delegate:self] ;
    [self.view addSubview:segmentedControl];
}

- (void) refreshTable
{
    /*
     
     Code to actually refresh goes here.
     
     */
    
    [self.items removeAllObjects];
    [self loadDataSource];
    self.collectionView.pullLastRefreshDate = [NSDate date];
    self.collectionView.pullTableIsRefreshing = NO;
    [self.collectionView reloadData];
}

- (void) loadMoreDataToTable
{
    /*
     
     Code to actually load more data goes here.
     
     */
    //    [self loadDataSource];
    [self.items addObjectsFromArray:self.items];
    [self.collectionView reloadData];
    self.collectionView.pullTableIsLoadingMore = NO;
}
#pragma mark - PullTableViewDelegate

- (void)pullPsCollectionViewDidTriggerRefresh:(PullPsCollectionView *)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3.0f];
}

- (void)pullPsCollectionViewDidTriggerLoadMore:(PullPsCollectionView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:3.0f];
}
- (void)viewDidUnload
{
    [self setCollectionView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"modifyUserInfo"]) {
        
    }else if([[segue identifier] isEqualToString:@"settings"])
    {
        
    }
    
    [self setHidesBottomBarWhenPushed:YES];
}
- (IBAction)modifyUserInfo:(id)sender {
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self setHidesBottomBarWhenPushed:NO];
    [super viewWillDisappear:YES];

}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView viewAtIndex:(NSInteger)index {
    NSDictionary *item = [self.items objectAtIndex:index];
    
    // You should probably subclass PSCollectionViewCell
    CellView *v = (CellView *)[self.collectionView dequeueReusableView];
    //    if (!v) {
    //        v = [[[PSCollectionViewCell alloc] initWithFrame:CGRectZero] autorelease];
    //    }
    if(v == nil) {
        NSArray *nib =
        [[NSBundle mainBundle] loadNibNamed:@"CellView" owner:self options:nil];
        v = [nib objectAtIndex:0];
    }
    
    //    [v fillViewWithObject:item];
    
    //NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://imgur.com/%@%@", [item objectForKey:@"hash"], [item objectForKey:@"ext"]]];
    //NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/pic/%@%@", [item objectForKey:@"hash"], [item objectForKey:@"ext"]]];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.110/pic/%@%@", [item objectForKey:@"hash"], [item objectForKey:@"ext"]]];
    //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    [v.picView  setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"placeholder"]];
    return v;
}

- (CGFloat)heightForViewAtIndex:(NSInteger)index {
    NSDictionary *item = [self.items objectAtIndex:index];
    
    // You should probably subclass PSCollectionViewCell
    return [PSCollectionViewCell heightForViewWithObject:item inColumnWidth:self.collectionView.colWidth];
}

- (void)collectionView:(PSCollectionView *)collectionView didSelectView:(PSCollectionViewCell *)view atIndex:(NSInteger)index {
    // Do something with the tap
}

- (NSInteger)numberOfViewsInCollectionView:(PSCollectionView *)collectionView {
    return [self.items count];
}

- (void)loadDataSource {
    // Request
    //    NSString *URLPath = [NSString stringWithFormat:@"http://imgur.com/gallery.json"];
    //    NSURL *URL = [NSURL URLWithString:URLPath];
    //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    //
    //    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
    
    //        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
    //
    //        if (!error && responseCode == 200) {
    //            id res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //            if (res && [res isKindOfClass:[NSDictionary class]]) {
    //                self.items = [res objectForKey:@"data"];
    //                [self dataSourceDidLoad];
    //            } else {
    //                [self dataSourceDidError];
    //            }
    //        } else {
    //            [self dataSourceDidError];
    //        }
    
    self.items = [[NSMutableArray alloc] initWithObjects:
                  [[NSDictionary alloc] initWithObjectsAndKeys:@"test0",@"hash",@".png",@"ext",@"212",@"width",@"158",@"height" , nil ],
                  [[NSDictionary alloc] initWithObjectsAndKeys:@"test1",@"hash",@".png",@"ext",@"202",@"width",@"178",@"height" , nil ],
                  [[NSDictionary alloc] initWithObjectsAndKeys:@"test2",@"hash",@".png",@"ext",@"216",@"width",@"174",@"height" , nil ],
                  [[NSDictionary alloc] initWithObjectsAndKeys:@"test3",@"hash",@".png",@"ext",@"198",@"width",@"154",@"height" , nil ],
                  [[NSDictionary alloc] initWithObjectsAndKeys:@"test4",@"hash",@".png",@"ext",@"231",@"width",@"147",@"height" , nil ],
                  [[NSDictionary alloc] initWithObjectsAndKeys:@"test5",@"hash",@".png",@"ext",@"183",@"width",@"169",@"height" , nil ],
                  [[NSDictionary alloc] initWithObjectsAndKeys:@"test6",@"hash",@".png",@"ext",@"172",@"width",@"179",@"height" , nil ],
                  [[NSDictionary alloc] initWithObjectsAndKeys:@"test7",@"hash",@".png",@"ext",@"165",@"width",@"170",@"height" , nil ],
//                  [[NSDictionary alloc] initWithObjectsAndKeys:@"test8",@"hash",@".png",@"ext",@"211",@"width",@"142",@"height" , nil ],
//                  [[NSDictionary alloc] initWithObjectsAndKeys:@"test9",@"hash",@".png",@"ext",@"166",@"width",@"154",@"height" , nil ],
//                  [[NSDictionary alloc] initWithObjectsAndKeys:@"test10",@"hash",@".png",@"ext",@"213",@"width",@"153",@"height" , nil ],
//                  [[NSDictionary alloc] initWithObjectsAndKeys:@"test11",@"hash",@".png",@"ext",@"152",@"width",@"154",@"height" , nil ],
                  nil];
    //}];
}


- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    if(index == 0)
    {
        // Maijia shang pin
    }else{
        // Maijia Show
    }
}
@end
