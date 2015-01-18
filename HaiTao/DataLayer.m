//
//  DataLayer.m
//  HaiTao
//
//  Created by gtcc on 11/22/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "DataLayer.h"
#import "SBJson/SBJson.h"
#import "Constraint.h"
#import "Utility.h"
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

+(NSMutableDictionary*)FetchDataFromWebByGet:(NSString *)url
{
    NSError *theError = nil;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"GET"];
    NSURLResponse *theResponse =[[NSURLResponse alloc]init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&theError];
    NSMutableString *jsonString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] copy];
    
    NSMutableDictionary *jsonDic = [jsonString  JSONValue];
    if(!jsonDic)
    {
        // todo: should be removed by the server fix the login issue
        //return value is {"s":"1","u":1563,	k":"C642125D688E38AEAA805FAA1D8E8253","ut":"0"}
         jsonDic = [[jsonString stringByReplacingOccurrencesOfString:@"k\":" withString:@"\"tk\":"] JSONValue];
    }
    
    return jsonDic;
}

+(int)uploadImage:(NSString*)serverURL img:(UIImage*)image
{
    /*
     turning the image into a NSData object
     getting the image back out of the UIImageView
     setting the quality to 90
     */
    
    NSData *imageData = UIImageJPEGRepresentation(image, 90);    
    // setting up the request object now
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:serverURL]];
    [request setHTTPMethod:@"POST"];
    
    /*
     add some header info now
     we always need a boundary when we post a file
     also we need to set the content type
     
     You might want to generate a random boundary.. this is just the same
     as my output from wireshark on a valid html post
     */
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    /*
     now lets create the body of the post
     */
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"Filedata\"; filename=\"test.jpeg\";\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // now lets make the connection to the web
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",returnString);
    NSMutableDictionary* result = [returnString JSONValue];
    return [result[@"s"] intValue];
}

+(NSString*)Login:(NSString*)phone pwd:(NSString*)password
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/u/l?jc=&n=%@&p=%@",SERVER_HOSTURL,phone,password];
    
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    
    NSString* returnCode = result[@"s"];
    if([returnCode isEqualToString:SUCCESS])
    {
        NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
        [mydefault setObject:result[@"u"] forKey:CURRENT_USERID];
        [mydefault setObject:result[@"tk"] forKey:CURRENT_TOKEN];
        [mydefault setObject:result[@"ut"] forKey:CURRENT_USERTYPE];
        [mydefault synchronize];
    }
    
    return returnCode;
}

+(NSMutableDictionary*)GetUserInfo
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/u/i?jc=&u=%@&tk=%@",SERVER_HOSTURL, [Utility getUserId],[Utility getUserToken]];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
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

+(NSArray*)GetMessagePrivateChatList:(NSString*)userId
{
    NSMutableArray* items = [[NSMutableArray alloc] init];
    for (int i=0; i<3; i++) {
        NSDictionary* item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                               @"Winston", @"name",
                               @"fans2.png",@"avatar",
                               @"你今天早走？", @"lastMsg",
                               nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"2", @"id",     //tag id
             @"Andy", @"name",
             @"fans3.png",@"avatar",
             @"Hi, 这款最低多少钱？", @"lastMsg",
             nil];
    
        [items addObject:item];
    
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"2", @"id",     //tag id
             @"Bob", @"name",
             @"fans4.png",@"avatar",
             @"Hi, 能交个朋友吗？", @"lastMsg",
             nil];
    
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"2", @"id",     //tag id
             @"Justin", @"name",
             @"fans1.png",@"avatar",
             @"我出新专辑了！", @"lastMsg",
             nil];
    
        [items addObject:item];
    }
    
    return [items copy];
}

+(NSArray*)GetMessageNotificationList:(NSString*)userId
{
    NSMutableArray* items = [[NSMutableArray alloc] init];
    for (int i=0; i<3; i++) {
        NSDictionary* item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                               @"Winston Leong", @"name",
                               @"fans2.png",@"avatar",
                               nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"2", @"id",     //tag id
                 @"Andy", @"name",
                 @"fans3.png",@"avatar",
                 nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"2", @"id",     //tag id
                 @"Bob", @"name",
                 @"fans4.png",@"avatar",
                 nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"2", @"id",     //tag id
                 @"Justin", @"name",
                 @"fans1.png",@"avatar",
                 nil];
        
        [items addObject:item];
    }
    
    return [items copy];
}

+(NSArray*)GetMessageZanList:(NSString*)userId
{
    NSMutableArray* items = [[NSMutableArray alloc] init];
    for (int i=0; i<3; i++) {
        NSDictionary* item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                               @"Winston", @"name",
                               @"fans2.png",@"avatar",
                               nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"2", @"id",     //tag id
                 @"Andy", @"name",
                 @"fans3.png",@"avatar",
                 nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"2", @"id",     //tag id
                 @"Bob", @"name",
                 @"fans4.png",@"avatar",
                 nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"2", @"id",     //tag id
                 @"Justin", @"name",
                 @"fans1.png",@"avatar",
                 nil];
        
        [items addObject:item];
    }
    
    return [items copy];
}

+(NSArray*)GetAllTags
{
    NSMutableArray* items = [[NSMutableArray alloc] initWithObjects:@"Chanel",@"LV",@"Prada",@"gucci",@"micheal kros",@"Fendi",@"Hermes",@"Burberry", nil];
    return [items copy];
}

+(NSArray*)GetAllLocations
{
    NSMutableArray* items = [[NSMutableArray alloc] initWithObjects:@"上海",@"北京","Prada",@"gucci",@"micheal kros",@"Fendi",@"Hermes",@"Burberry", nil];
    return [items copy];
}

@end
