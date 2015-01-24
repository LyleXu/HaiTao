//
//  DataLayer.m
//  HaiTao
//
//  Created by gtcc on 11/22/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "DataLayer.h"
#import "SBJson/SBJson.h"
#import "Utility.h"
#define ServerHost @"Localhost"
#define ServiceAddress @""

@implementation DataLayer

/*1.1商家（卖家）用户入驻申请
 http://114.215.83.218/d/v1/u/s/r?jc=&m=18651507198&nn=semir&p=admin&s=商家名称&o=商家简介&c=
 */
+(NSMutableDictionary*)RegisterSeller:(NSString*)phone password:(NSString*)p nickName:(NSString*)nn sellerDescription:(NSString*)o messageVerification:(NSString*)c sellerName:(NSString*)s
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/u/s/r?jc=&m=%@&nn=%@&p=%@&s=%@&o=%@&c=%@",SERVER_HOSTURL, phone,nn,p,s,o,c];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*1.2普通用户（买家）注册
 http://114.215.83.218/d/v1/u/r?jc=&m=18651507199&p=123456&nn=昵称&c=257826
 */
+(NSMutableDictionary*)RegisterBuyer:(NSString*)phone password:(NSString*)p nickName:(NSString*)nn messageVerification:(NSString*)c
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/u/r?jc=&m=%@&p=%@&nn=%@&c=%@",SERVER_HOSTURL, phone,p,nn,c];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*1.3普通登录验证
 http://114.215.83.218/d/v1/u/l?jc=&n=1861507191&p=123456
 */
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

/*1.4第三方登录验证
 http://114.215.83.218/d/v1/u/l3?jc=&tp=0&ac=372998843
 */
+(NSMutableDictionary*)LoginFromThirdParty:(NSString*)ty tokenFromThirdParty:(NSString*)ac
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/u/l3?jc=&ty=%@&ac=%@",SERVER_HOSTURL, ty,ac];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*1.5-1用户忘记密码（请求验证码）
 http://114.215.83.218/d/v1/u/sc?jc=&m=18651507191
 */
+(NSMutableDictionary*)ForgetPassword:(NSString*)phone
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/u/sc?jc=&m=%@",SERVER_HOSTURL,phone];
    
    return [self FetchDataFromWebByGet:serverURL];
}

/*1.5-2用户忘记密码（重置密码）
 http://114.215.83.218/d/v1/u/up?jc=&u=1&p=admin&c=601758
 */
+(NSMutableDictionary*)SetNewPassword:(NSString*)uid newPassword:(NSString*)pwd verificationCode:(NSString*)vc
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/u/up?jc=&u=%@&p=%@&c=%@",SERVER_HOSTURL, uid,pwd,vc];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*1.6用户获取个人信息
 http://114.215.83.218/d/v1/u/i?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2
 */
+(NSMutableDictionary*)GetUserInfo
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/u/i?jc=&u=%@&tk=%@",SERVER_HOSTURL, [Utility getUserId],[Utility getUserToken]];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*1.7 添加关注接口（用户、商家、商品）
 http://114.215.83.218/d/v1/u/a?jc=&tk=8E5054AA80C2606488868C845284E6A2&u=2&b=4&g=&t=1&s=1
 */
+(NSMutableDictionary*)AddFocus:(NSString*)focusedUid goodsId:(NSString*)g focusStatus:(NSString*)s focusType:(NSString*)t
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/u/a?jc=&tk=%@&u=%@&b=%@&g=%@&t=%@&s=%@",SERVER_HOSTURL, [Utility getUserToken],[Utility getUserId],focusedUid,g,t,s];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*1.8我关注的用户列表
 http://114.215.83.218/d/v1/u/m?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2&t=1
 */
+(NSMutableDictionary*)GetFocusedUserList:(NSString*)focusType
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/u/m?jc=&u=%@&tk=%@&t=%@",SERVER_HOSTURL, [Utility getUserId],[Utility getUserToken],focusType];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*1.9用户注册发送短信验证码
 http://114.215.83.218/d/v1/u/rs?jc=&m=18651507191
 */
+(NSMutableDictionary*)GetVerificationCode:(NSString*)phone
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/u/rs?jc=&m=%@",SERVER_HOSTURL, phone];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*1.10用户信息修改
 http://114.215.83.218/d/v1/u/ui?jc=&tk=8E5054AA80C2606488868C845284E6A2&u=2&nn=
 */
+(NSMutableDictionary*)UpdateUserInfo:(NSString*)nickName
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/u/ui?jc=&tk=%@&u=%@&nn=%@",SERVER_HOSTURL, [Utility getUserToken],[Utility getUserId],nickName];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*1.11用户上传头像
 http://114.215.83.218/d/v1/u/u/p?jc=&tk=8E5054AA80C2606488868C845284E6A2&u=2
 */
+(NSMutableDictionary*)UploadUserAvatar:(UIImage*)avatar
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/u/u/p?jc=&tk=%@&u=%@",SERVER_HOSTURL, [Utility getUserToken],[Utility getUserId]];
    return [self uploadImage:serverURL img:avatar];
}

/* 2.1商家商品列表
 http://114.215.83.218/d/v1/g/l?u=2&tk=8E5054AA80C2606488868C845284E6A2&s=2&pageIndex=1&pageSize=5
 */
+(NSMutableDictionary*)GetSellerGoodsList:(NSString*)sellerID pageIndex:(NSString*)index pageSize:(NSString*)size
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/g/l?u=%@&tk=%@&s=%@&pageIndex=%@&pageSize=%@",SERVER_HOSTURL, [Utility getUserId],[Utility getUserToken],sellerID,index,size];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*2.2 上传商品图片接口
 http://114.215.83.218/d/v1/g/u?jc=&u=2&token=
 */
+(NSMutableDictionary*)UploadGoodsImage:(UIImage*)image
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/g/u/p?jc=&u=%@&token=%@",SERVER_HOSTURL,[Utility getUserId], [Utility getUserToken]];
    return [self uploadImage:serverURL img:image];
}

/*2.3 商家添加/更新商品
 注:此接口要调用2.7分类列表接口、标签接口、2.2图片上传接口
 http://114.215.83.218/d/v1/g/u?u=2&tk=8E5054AA80C2606488868C845284E6A2&n=香奈儿套装&p=7889.9&num=90&m=描述商品&pic=&s=1&t=1&btn=& btad=
 */
+(NSMutableDictionary*)AddorUpdateGoods:(NSString*)goodsName price:(NSString*)p number:(NSString*)num goodsDescription:(NSString*)m image:(NSString*)pic tag:(NSString*)t buyTagName:(NSString*)bta buyTagID:(NSString*)btad
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/g/u?u=%@&tk=%@&n=%@&p=%@&num=%@&m=%@&pic=%@&t=%@&btn=%@&btad=%@&s=1",SERVER_HOSTURL, [Utility getUserId],[Utility getUserToken],goodsName,p,num,m,pic,t,bta,btad];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*2.4商家对商品上架下架
 http://114.215.83.218/d/v1/g/is?u=2&tk=8E5054AA80C2606488868C845284E6A2&g=16&s=1
 */
+(NSMutableDictionary*)ShelveGoods:(NSString*)goodsId goodsStatus:(NSString*)s
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/g/is?u=%@&tk=%@&g=%@&s=%@",SERVER_HOSTURL, [Utility getUserId],[Utility getUserToken],goodsId,s];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*2.5商品详细
 http://114.215.83.218/d/v1/g/i?u=2&tk=8E5054AA80C2606488868C845284E6A2&g=16
 */
+(NSMutableDictionary*)GetGoodsInfo:(NSString*)goodsId
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/g/i?u=%@&tk=%@&g=%@",SERVER_HOSTURL, [Utility getUserId],[Utility getUserToken],goodsId];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*2.6商品删除
 http://114.215.83.218/d/v1/g/d?u=2&tk=8E5054AA80C2606488868C845284E6A2&g=16
 */
+(NSMutableDictionary*)DeleteGoods:(NSString*)goodsId
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/g/d?u=%@&tk=%@&g=%@",SERVER_HOSTURL, [Utility getUserId],[Utility getUserToken],goodsId];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*2.7商品分类列表
 http://114.215.83.218/d/v1/ca/l?u=2&tk=8E5054AA80C2606488868C845284E6A2
 */
+(NSMutableDictionary*)GetCategoryList
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/ca/l?u=%@&tk=%@",SERVER_HOSTURL, [Utility getUserId],[Utility getUserToken]];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*3.1 添加商品到购物车
 http://114.215.83.218/d/v1/c/a?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2&g=3&num=1
 */
+(NSMutableDictionary*)AddGoodstoCart:(NSString*)goodsId goodsNumber:(NSString*)num
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/c/a?jc=&u=%@&tk=%@&g=%@&num=%@",SERVER_HOSTURL, [Utility getUserId],[Utility getUserToken],goodsId,num];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*3.2 我的购物车
 http://114.215.83.218/d/v1/c/l?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2
 */
+(NSMutableDictionary*)GetMyCartList
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/c/l?jc=&u=%@&tk=%@",SERVER_HOSTURL, [Utility getUserId],[Utility getUserToken]];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*3.3 删除购物车商品
 http://114.215.83.218/d/v1/c/d?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2
 */
+(NSMutableDictionary*)RemoveGoodsfromCart:(NSString*)cartRelatedGoodsID
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/c/d?jc=&u=%@&tk=%@&r=%@",SERVER_HOSTURL, [Utility getUserId],[Utility getUserToken],cartRelatedGoodsID];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*4.1 我的订单
 http://114.215.83.218/d/v1/o/l?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2&s=1
 */
+(NSMutableDictionary*)GetOrderList:(NSString*)orderStatus
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/o/l?jc=&u=%@&tk=%@&s=%@",SERVER_HOSTURL, [Utility getUserId],[Utility getUserToken],orderStatus];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*4.2 购物车生成订单
 http://114.215.83.218/d/v1/o/c2?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2&cid=1&a=1
 */
+(NSMutableDictionary*)CreateOrder:(NSString*)cartId address:(NSString*)a
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/o/c2?jc=&u=%@&tk=%@&cid=%@&a=%@",SERVER_HOSTURL, [Utility getUserId],[Utility getUserToken],cartId,a];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*4.3 订单状态
 http://114.215.83.218/d/v1/o/s?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2&od=1&s=1
 */
+(NSMutableDictionary*)UpdateOrderStatus:(NSString*)orderID orderStatus:(NSString*)s
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/o/s?jc=&u=%@&tk=%@&od=%@&s=%@",SERVER_HOSTURL, [Utility getUserId],[Utility getUserToken],orderID,s];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*4.4订单支付
 http://114.215.83.218/d/v1/o/p?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2&od=1
 */
+(NSMutableDictionary*)PayOrder:(NSString*)orderID
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/o/p?jc=&u=%@&tk=%@&od=%@",SERVER_HOSTURL, [Utility getUserId],[Utility getUserToken],orderID];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*5.1 我的收货地址
 http://114.215.83.218/d/v1/a/l?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2
 */
+(NSMutableDictionary*)GetAddressList
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/a/l?jc=&u=%@&tk=%@",SERVER_HOSTURL, [Utility getUserId],[Utility getUserToken]];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*5.2 地址添加
 http://114.215.83.218/d/v1/a/u?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2&id=1&p=usa&c=&area=&m=&r=&s=&a
 */
+(NSMutableDictionary*)AddAddress:(NSString*)addressId province:(NSString*)p city:(NSString*)c area:(NSString*)region street:(NSString*)s phone:(NSString*)m receiverName:(NSString*)r detailedAddress:(NSString*)a
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/a/u?jc=&u=%@&tk=%@&id=%@&p=%@&c=%@&area=%@&m=%@&r=%@&s=%@&a=%@",SERVER_HOSTURL, [Utility getUserId],[Utility getUserToken],addressId,p,c,region,m,r,s,a];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*5.3 设置默认地址
 http://114.215.83.218/d/v1/a/f?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2&id=1
 */
+(NSMutableDictionary*)SetDefaultAddress:(NSString*)addressId
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/a/f?jc=&u=%@&tk=%@&id=%@",SERVER_HOSTURL, [Utility getUserId],[Utility getUserToken],addressId];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

/*5.4 删除收货地址
 http://114.215.83.218/d/v1/a/d?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2&id=4
 */
+(NSMutableDictionary*)DeleteAddress:(NSString*)addressId
{
    NSString* serverURL = [[NSString alloc] initWithFormat:@"%@/d/v1/a/d?jc=&u=%@&tk=%@&id=%@",SERVER_HOSTURL, [Utility getUserId],[Utility getUserToken],addressId];
    NSMutableDictionary* result = [self FetchDataFromWebByGet:serverURL];
    return result;
}

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
    //NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"GET"];
    NSURLResponse *theResponse =[[NSURLResponse alloc]init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&theError];
    NSMutableString *jsonString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] copy];
    
    NSMutableDictionary *jsonDic = [jsonString  JSONValue];
    //    if(!jsonDic)
    //    {
    //        // todo: should be removed by the server fix the login issue
    //        //return value is {"s":"1","u":1563,	k":"C642125D688E38AEAA805FAA1D8E8253","ut":"0"}
    //        NSString* temp = [jsonString stringByReplacingOccurrencesOfString:@"k\":" withString:@"\"tk\":"];
    //
    //        jsonDic = [temp JSONValue];
    //    }else
    //    {
    //        //NSString* temp1 = @"{\"s\":\"1\",\"u\":1563,\"code\":879631}";
    //        NSString* temp = [jsonString substringFromIndex:1];
    //        temp = [temp substringToIndex:[temp length]-1];
    //        NSArray* array = [temp componentsSeparatedByString:@","];
    //        NSString* finalString = nil;
    //        for (NSString* item in array) {
    //            NSArray* temp2 = [item componentsSeparatedByString:@":"];
    //
    //            if([temp2[1] containsString:@"\""] || [temp2[1] containsString:@"{"])
    //            {
    //                if(finalString)
    //                    finalString = [NSString  stringWithFormat:@"%@%@,",finalString,item];
    //                else
    //                    finalString = [NSString  stringWithFormat:@"%@,",item];
    //            }else
    //            {
    //                if(finalString)
    //                    finalString = [NSString stringWithFormat:@"%@%@:\"%@\",",finalString,temp2[0],temp2[1]];
    //                else
    //                    finalString = [NSString stringWithFormat:@"%@:\"%@\",",temp2[0],temp2[1]];
    //            }
    //        }
    //        finalString = [finalString substringToIndex:[finalString length]-1];
    //        finalString = [NSString stringWithFormat:@"{%@}",finalString];
    //        jsonDic = [finalString JSONValue];
    // }
    
    //    NSString* temp1 = @"{\"s\":\"1\",\"u\":1563,\"code\":879631}";
    //    NSMutableDictionary* testDic = [temp1 JSONValue];
    //    NSLog(@"%d",[[testDic objectForKey:@"u"] intValue]);
    
    return jsonDic;
}

+(NSMutableDictionary*)uploadImage:(NSString*)serverURL img:(UIImage*)image
{
    /*
     turning the image into a NSData object
     getting the image back out of the UIImageView
     setting the quality to 90
     */
    
    NSData *imageData = UIImagePNGRepresentation(image);
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
    [body appendData:[@"Content-Disposition: form-data; name=\"Filedata\"; filename=\"test.png\";\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // now lets make the connection to the web
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",returnString);
    NSMutableDictionary* result = [returnString JSONValue];
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
                               [[NSArray alloc] initWithObjects:@"test0_1_2.png", nil], @"goodsPics", //Goods pics
                               nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                               @"#街拍", @"name",//tag name
                               [[NSArray alloc] initWithObjects:@"test3_4_5.png", nil], @"goodsPics", //Goods pics
                               nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                               @"#CHANEL", @"name",//tag name
                               [[NSArray alloc] initWithObjects:@"test6_7_8.png", nil], @"goodsPics", //Goods pics
                               nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                 @"#PRADA", @"name",//tag name
                 [[NSArray alloc] initWithObjects:@"test9_10_11.png", nil], @"goodsPics", //Goods pics
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
                 [[NSArray alloc] initWithObjects:@"test0_1_2.png", nil], @"goodsPics", //Goods pics
                 nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                 @"#CHANEL", @"name",//tag name
                 [[NSArray alloc] initWithObjects:@"test3_4_5.png", nil], @"goodsPics", //Goods pics
                 nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                 @"#PRADA", @"name",//tag name
                 [[NSArray alloc] initWithObjects:@"test6_7_8.png", nil], @"goodsPics", //Goods pics
                 nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                               @"#潮品", @"name",//tag name
                               [[NSArray alloc] initWithObjects:@"test9_10_11.png", nil], @"goodsPics", //Goods pics
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
                 [[NSArray alloc] initWithObjects:@"test0_1_2.png", nil], @"goodsPics", //Goods pics
                 nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                 @"#PRADA", @"name",//tag name
                 [[NSArray alloc] initWithObjects:@"test3_4_5.png", nil], @"goodsPics", //Goods pics
                 nil];
        
        [items addObject:item];
        
         item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                               @"#潮品", @"name",//tag name
                               [[NSArray alloc] initWithObjects:@"test6_7_8.png", nil], @"goodsPics", //Goods pics
                               nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                 @"#街拍", @"name",//tag name
                 [[NSArray alloc] initWithObjects:@"test9_10_11.png", nil], @"goodsPics", //Goods pics
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
                 [[NSArray alloc] initWithObjects:@"test0_1_2.png", nil], @"goodsPics", //Goods pics
                 nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                               @"#潮品", @"name",//tag name
                               [[NSArray alloc] initWithObjects:@"test3_4_5.png", nil], @"goodsPics", //Goods pics
                               nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                 @"#街拍", @"name",//tag name
                 [[NSArray alloc] initWithObjects:@"test6_7_8.png", nil], @"goodsPics", //Goods pics
                 nil];
        
        [items addObject:item];
        
        item =  [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"id",     //tag id
                 @"#CHANEL", @"name",//tag name
                 [[NSArray alloc] initWithObjects:@"test9_10_11.png", nil], @"goodsPics", //Goods pics
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
