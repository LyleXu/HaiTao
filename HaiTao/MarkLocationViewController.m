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
bool isDisplayedTagandLocation = NO;

-(NSMutableArray*)tagLocations
{
    if(_tagLocations == nil)
    {
        _tagLocations = [[NSMutableArray alloc] init];
        [_tagLocations addObject: [NSValue valueWithCGRect: CGRectMake(20, 120, 100, 26)]];
        [_tagLocations addObject: [NSValue valueWithCGRect: CGRectMake(20, 200, 100, 26)]];
        [_tagLocations addObject: [NSValue valueWithCGRect: CGRectMake(40, 160, 100, 26)]];
        [_tagLocations addObject: [NSValue valueWithCGRect: CGRectMake(100, 180, 100, 26)]];
        [_tagLocations addObject: [NSValue valueWithCGRect: CGRectMake(160, 160, 100, 26)]];
    }
    return _tagLocations;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStyleBordered target:self action:@selector(toNextPage)];
    [self.navigationItem setRightBarButtonItem:barButtonItem];
    
    self.navigationItem.title = @"标记标签";
    
    self.imageMarkLocation.image = self.imgCaptured;
    
    self.imageMarkLocation.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageMarkLocationClicked)];
    [self.imageMarkLocation addGestureRecognizer:tap];
    
    self.btnLocation.hidden = YES;
    self.btnTag.hidden = YES;
}

-(void)imageMarkLocationClicked
{
    if(!isDisplayedTagandLocation)
    {
        self.btnTag.hidden = NO;
        self.btnLocation.hidden = NO;
        
        self.btnTag.frame = CGRectZero;
        self.btnTag.center = CGPointMake(62, 150);
        [UIView animateWithDuration:1 animations:^{
            self.btnTag.frame = CGRectMake(62, 224, 34 , 34);
        } completion:nil];
        
        self.btnLocation.frame = CGRectZero;
        self.btnLocation.center = CGPointMake(218, 150);
        [UIView animateWithDuration:1 animations:^{
            self.btnLocation.frame = CGRectMake(218, 224, 34, 34);
        } completion:nil];
        
        isDisplayedTagandLocation = YES;
    }else
    {
        self.btnLocation.hidden = YES;
        self.btnTag.hidden = YES;
        
        isDisplayedTagandLocation = NO;
    }
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
    [self generateTagLabel:value];
}

-(void)generateTagLabel:(NSString*)value
{
    static int i = 0;

    if(i <5)
    {
        CGRect rect = [self.tagLocations[i] CGRectValue];
        UILabel* label = [[UILabel alloc] init];
        label.textColor = [UIColor whiteColor];
        
        CGSize size = [value sizeWithFont:label.font constrainedToSize:CGSizeMake(MAXFLOAT, 26)];
        [label setFrame:CGRectMake(rect.origin.x, rect.origin.y, size.width + 10, rect.size.height)];
        label.textAlignment=NSTextAlignmentRight;
        label.text = value;
        [self.view addSubview:label];
        
        CGSize imgSize = label.frame.size;
        
        UIImage* backgroundImageForLabel = [UIImage imageNamed:@"big_biaoqian.png"];
        NSInteger leftWidth = backgroundImageForLabel.size.width * 0.5;
        NSInteger topHeight = backgroundImageForLabel.size.height;
        backgroundImageForLabel = [backgroundImageForLabel stretchableImageWithLeftCapWidth: leftWidth topCapHeight:topHeight];
        
        UIGraphicsBeginImageContext( imgSize );
        [backgroundImageForLabel drawInRect:CGRectMake(0,0,imgSize.width + 10,imgSize.height)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        label.backgroundColor = [UIColor colorWithPatternImage:newImage];
        
        
    
        //UIImageView* imageView = [[UIImageView alloc] initWithFrame: CGRectMake(rect.origin.x, rect.origin.y, size.width, rect.size.height)];
        //imageView.image = backgroundImageForLabel;
        //[self.view addSubview:imageView];
        
        i++;
    }else
    {
        NSLog(@"You only can have 5 tags");
    }
}

@end
