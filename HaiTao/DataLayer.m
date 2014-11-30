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

+(NSArray*)GetSellerGoodsItems
{
    NSMutableArray* items = [[NSMutableArray alloc] init];
    for (int i=0; i<10; i++) {
       NSDictionary* item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //Seller id
         @"Happy Bob", @"name",//Seller name
         @"SellerAvatar.png",@"sellerAvatar", //Seller avatar
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

@end
