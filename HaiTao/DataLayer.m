//
//  DataLayer.m
//  HaiTao
//
//  Created by gtcc on 11/22/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "DataLayer.h"
#import "SBJson/SBJson.h"
#define ServerHost @"Localhost"
#define ServiceAddress @""


@implementation DataLayer

+ (NSDictionary*) FetchData:(NSString*)serviceName
                 methodName:(NSString*)methodName
                 parameters:(NSArray*)parameters
{
    NSError *theError = nil;
    
    NSString* jsonString = [self GetJsonString:serviceName methodName:methodName parameters:parameters];
    NSLog(@"%@",jsonString);
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@%@",ServerHost,ServiceAddress];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serverURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    NSURLResponse *theResponse =[[NSURLResponse alloc]init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&theError];
    NSMutableString *theString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] copy];
    NSDictionary *jsonDictionaryResponse = [theString JSONValue];
    return jsonDictionaryResponse;
}

+ (NSString*) GetJsonString:(NSString*)serviceName
                 methodName:(NSString*)methodName
                 parameters:(NSArray*)parameters
{
    
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSString stringWithString:serviceName], @"serviceName",
                                    [NSString stringWithString:methodName], @"methodName",
                                    [NSArray arrayWithArray:parameters], @"parameters",
                                    nil];
    
    NSString *jsonString = [jsonDictionary JSONRepresentation];
    return jsonString;
}

+(NSMutableString*)FetchDataFromWebByGet:(NSString *)url
{
    NSError *theError = nil;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"GET"];
    NSURLResponse *theResponse =[[NSURLResponse alloc]init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&theError];
    NSMutableString *theString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] copy];
    return theString;
}

// Main page Seller goods info
+(NSArray*)GetSellerGoodsItems
{
    NSMutableArray* items = [[NSMutableArray alloc] init];
    for (int i=0; i<10; i++) {
       NSDictionary* item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //Seller id
         @"Happy Bob", @"name",//Seller name
         @"fans4.png",@"sellerAvatar", //Seller avatar
         @"巴黎",  @"location",                //Seller Location
         [[NSArray alloc] initWithObjects:@"maijia.png",@"maijia2.png",@"maijia3.png", nil], @"goodsPics", //Goods pics
         @"Nice Gift", @"description", //Goods Description,
         [[NSArray alloc] initWithObjects:@"#lextriana",@"#lucastriana",@"#familyfirst", nil], @"tags",// Goods Tags
         [[NSArray alloc] initWithObjects:[[NSArray alloc]   initWithObjects:@"comment1",@"fans1.png",@"So good!!!", nil], nil] //Goods Comments
                         , @"comments",
        nil];
        
        [items addObject:item];
    }
    
    return [items copy];
}

// main page buyer show info
+(NSArray*)GetBuyerGoodsItems
{
    NSMutableArray* items = [[NSMutableArray alloc] init];
    for (int i=0; i<10; i++) {
        NSDictionary* item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //Seller id
                               @"CANDY", @"name",//buyer name
                               @"fans1.png",@"buyerAvatar", //Seller avatar
                               [[NSArray alloc] initWithObjects:@"maijia2.png",@"maijia3.png",@"maijia.png", nil], @"goodsPics", //Goods pics
                               [[NSArray alloc] initWithObjects:@"#连衣裙",@"#潮品", nil], @"tags",// Goods Tags
                               [[NSArray alloc] initWithObjects:[[NSArray alloc]   initWithObjects:@"comment1",@"fans1.png",@"质量不错，毕竟是大牌，卖家@ Happy Bob 也很细心，下次还会光顾 ：-）。", nil],
                                                                               [[NSArray alloc]   initWithObjects:@"comment2",@"fans2.png",@"东西很不错，很稀饭，O(n_n)O, 下次还会来哦 :-)。", nil],nil] //Goods Comments
                               , @"comments",
                               nil];
        
        [items addObject:item];
    }
    
    return [items copy];
}

+(NSArray*)GetAllGoodsByTags
{
    NSMutableArray* items = [[NSMutableArray alloc] init];
    for (int i=0; i<1; i++) {
        NSDictionary* item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                               @"#潮品", @"name",//tag name
                               [[NSArray alloc] initWithObjects:@"test0.png",@"test1.png",@"test3.png", nil], @"goodsPics", //Goods pics
                               nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                               @"#街拍", @"name",//tag name
                               [[NSArray alloc] initWithObjects:@"test2.png",@"test4.png",@"test5.png",@"test6.png", nil], @"goodsPics", //Goods pics
                               nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                               @"#CHANEL", @"name",//tag name
                               [[NSArray alloc] initWithObjects:@"test7.png",@"test8.png",@"test9.png", nil], @"goodsPics", //Goods pics
                               nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                 @"#PRADA", @"name",//tag name
                 [[NSArray alloc] initWithObjects:@"test10.png",@"test11.png",@"test12.png", nil], @"goodsPics", //Goods pics
                 nil];
        
        [items addObject:item];
    }
    
    return [items copy];
}

+(NSArray*)GetAllGoodsBySpecialSelling
{
    NSMutableArray* items = [[NSMutableArray alloc] init];
    for (int i=0; i<1; i++) {
        NSDictionary* item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                 @"#街拍", @"name",//tag name
                 [[NSArray alloc] initWithObjects:@"test2.png",@"test4.png",@"test5.png",@"test6.png", nil], @"goodsPics", //Goods pics
                 nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                 @"#CHANEL", @"name",//tag name
                 [[NSArray alloc] initWithObjects:@"test7.png",@"test8.png",@"test9.png", nil], @"goodsPics", //Goods pics
                 nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                 @"#PRADA", @"name",//tag name
                 [[NSArray alloc] initWithObjects:@"test10.png",@"test11.png",@"test12.png", nil], @"goodsPics", //Goods pics
                 nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                               @"#潮品", @"name",//tag name
                               [[NSArray alloc] initWithObjects:@"test0.png",@"test1.png",@"test3.png", nil], @"goodsPics", //Goods pics
                               nil];
        
        [items addObject:item];
    }
    
    return [items copy];
}

+(NSArray*)GetAllGoodsByNewArrival
{
    NSMutableArray* items = [[NSMutableArray alloc] init];
    for (int i=0; i<1; i++) {
        
        NSDictionary* item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                 @"#CHANEL", @"name",//tag name
                 [[NSArray alloc] initWithObjects:@"test7.png",@"test8.png",@"test9.png", nil], @"goodsPics", //Goods pics
                 nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                 @"#PRADA", @"name",//tag name
                 [[NSArray alloc] initWithObjects:@"test10.png",@"test11.png",@"test12.png", nil], @"goodsPics", //Goods pics
                 nil];
        
        [items addObject:item];
        
         item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                               @"#潮品", @"name",//tag name
                               [[NSArray alloc] initWithObjects:@"test0.png",@"test1.png",@"test3.png", nil], @"goodsPics", //Goods pics
                               nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                 @"#街拍", @"name",//tag name
                 [[NSArray alloc] initWithObjects:@"test2.png",@"test4.png",@"test5.png",@"test6.png", nil], @"goodsPics", //Goods pics
                 nil];
        
        [items addObject:item];
    }
    
    return [items copy];
}

+(NSArray*)GetAllGoodsByHot
{
    NSMutableArray* items = [[NSMutableArray alloc] init];
    for (int i=0; i<1; i++) {
       NSDictionary* item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                 @"#PRADA", @"name",//tag name
                 [[NSArray alloc] initWithObjects:@"test10.png",@"test11.png",@"test12.png", nil], @"goodsPics", //Goods pics
                 nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                               @"#潮品", @"name",//tag name
                               [[NSArray alloc] initWithObjects:@"test0.png",@"test1.png",@"test3.png", nil], @"goodsPics", //Goods pics
                               nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                 @"#街拍", @"name",//tag name
                 [[NSArray alloc] initWithObjects:@"test2.png",@"test4.png",@"test5.png",@"test6.png", nil], @"goodsPics", //Goods pics
                 nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                 @"#CHANEL", @"name",//tag name
                 [[NSArray alloc] initWithObjects:@"test7.png",@"test8.png",@"test9.png", nil], @"goodsPics", //Goods pics
                 nil];
        
        [items addObject:item];
    }
    
    return [items copy];
}

+(NSDictionary*)GetGoodsInfoById:(NSString*)goodsId
{
    NSDictionary* info = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"1",@"id",
                          @"Chanel连衣裙",@"name",
                          @"maijia.png",@"goodsPic",
                          @"Happy Bob", @"sellerName",
                          @"SellerAvatar.png", @"sellerAvatarName",
                          @"巴黎",@"location",
                          @"¥3430",@"price",
                          @"单品",@"goodsType",
                          @"现货",@"goodsStatus",
                          @"可订货",@"canPreOrder",
                          @"1341",@"zanCount",
                          @"341",@"commentCount",
                          @"8",@"goodsCountInCart",
                          @"Nice gift",@"goodsDescription",
                          [[NSArray alloc] initWithObjects:@"#连衣裙",@"#潮品", nil], @"tags",// Goods Tags
                          [[NSArray alloc] initWithObjects:[[NSArray alloc]   initWithObjects:@"comment1",@"fans1.png",@"So good!!!", nil], nil] //Goods Comments
                          , @"comments",
                           nil];
    return info;
}

@end
