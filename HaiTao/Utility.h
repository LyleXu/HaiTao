//
//  Utility.h
//  HaiTao
//
//  Created by gtcc on 11/8/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIImageView.h"

@interface Utility : NSObject
+(NSString*)getUserId;
+(NSString*)getUserType;
+(NSString*)getUserToken;
+(void)setUserId:(NSString*)userId;
+(void)setUserToken:(NSString*)token;
+(void)setUserType:(NSString*)userType;

+(NSString*)getErrorMessage:(NSString*)errorCode;
+(NSMutableDictionary*) allErrorMessages;

+(NSString*)getSmallImageURL:(NSString*)relativeURL;
+(NSString*)getLargeImageURL:(NSString*)relativeURL;

+(void)showErrorMessage:(NSString*)errorCode;
+(void)showMessage:(NSString *)title message:(NSString*)msg;
+(void)showConfirmMessage:(NSString*)title message:(NSString*) msg delegate:(id)dlg;
@end
