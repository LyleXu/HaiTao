//
//  MarkLocationViewController.m
//  HaiTao
//
//  Created by gtcc on 11/14/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "MarkLocationViewController.h"
#import "ReleaseGoodsViewController.h"
#import "TagViewController.h"
@implementation MarkLocationViewController
@synthesize imageMarkLocation;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStyleBordered target:self action:@selector(toNextPage)];
    [self.navigationItem setRightBarButtonItem:barButtonItem];
    
    self.navigationItem.title = @"标记标签";
    
    self.imageMarkLocation.image = self.imgCaptured;
}
- (IBAction)addNewTag:(id)sender {
    TagViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"tagviewcontroller"];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)toNextPage
{
    ReleaseGoodsViewController* ctl = [self.storyboard instantiateViewControllerWithIdentifier:@"releasegoodsviewcontroller"];
    [self.navigationController pushViewController:ctl animated:YES];
}

-(void)passValue:(NSString *)value
{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 100, 21)];
    label.text = value;
    [self.view addSubview:label];
}

@end
