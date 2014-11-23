//
//  AppDelegate.h
//  HaiTao
//
//  Created by gtcc on 11/2/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "WeiboSDK-Prefix.pch"
#import <TencentOpenAPI/TencentOAuth.h>
#import "DataLayer.h"
#import "MainTabBarController.h"
#import "MainViewController.h"
#import "CallDelegate.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate,WBHttpRequestDelegate>
{
NSString* wbtoken;
}

@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wb_uid;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *viewController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property(nonatomic,assign) NSObject<CallDelegate> *callDelegate;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

