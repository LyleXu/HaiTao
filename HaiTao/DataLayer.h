//
//  DataLayer.h
//  HaiTao
//
//  Created by gtcc on 11/22/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataLayer : NSObject

+(int)Login:(NSString*)phone pwd:(NSString*)password;
+(int)uploadImage:(NSString*)serverURL img:(UIImage*)image;
+(NSMutableDictionary *)FetchDataFromWebByGet:(NSString* )url;

+(NSArray*)GetSellerGoodsItems;
+(NSArray*)GetBuyerGoodsItems;

+(NSArray*)GetAllGoodsByTags;
+(NSArray*)GetAllGoodsBySpecialSelling;
+(NSArray*)GetAllGoodsByNewArrival;
+(NSArray*)GetAllGoodsByHot;

+(NSDictionary*)GetGoodsInfoById:(NSString*)goodsId;

+(NSArray*)GetMessagePrivateChatList:(NSString*)userId;
+(NSArray*)GetMessageNotificationList:(NSString*)userId;
+(NSArray*)GetMessageZanList:(NSString*)userId;

+(NSArray*)GetAllTags;
+(NSArray*)GetAllLocations;
@end
