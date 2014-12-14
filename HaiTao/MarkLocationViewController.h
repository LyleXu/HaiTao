//
//  MarkLocationViewController.h
//  HaiTao
//
//  Created by gtcc on 11/14/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"
#import <CoreLocation/CoreLocation.h>
@interface MarkLocationViewController : UIViewController<PassValueDelegate,CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageMarkLocation;
@property (weak, nonatomic) IBOutlet UIButton *btnTag;
@property (weak, nonatomic) IBOutlet UIButton *btnLocation;

@property (strong, nonatomic) UIImage* imgCaptured;

@property (strong, nonatomic) NSMutableArray* tagLocations;

@property (strong, nonatomic) CLLocationManager* locationManager;
@end
