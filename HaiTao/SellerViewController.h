//
//  SellerViewController.h
//  HaiTao
//
//  Created by gtcc on 11/13/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYSegmentedControl.h"
#import "PSCollectionView.h"
#import "PullPsCollectionView.h"
@interface SellerViewController : UIViewController
@property (retain, nonatomic)  HYSegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIButton *btnFocus;


@property(nonatomic,retain) PullPsCollectionView *collectionView;
@property(nonatomic,retain)NSMutableArray *items;
-(void)loadDataSource;

@end
