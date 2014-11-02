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

@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>
{
NSString* wbtoken;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
@property (strong, nonatomic) NSString *wbtoken;


@end

