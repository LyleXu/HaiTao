//
//  DataLayer.h
//  HaiTao
//
//  Created by gtcc on 11/22/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constraint.h"
@interface DataLayer : NSObject


+(NSMutableDictionary*)uploadImage:(NSString*)serverURL img:(UIImage*)image;
+(NSMutableDictionary *)FetchDataFromWebByGet:(NSString* )url;

/*1.1商家（卖家）用户入驻申请 
 http://114.215.83.218/d/v1/u/s/r?jc=&m=18651507198&nn=semir&p=admin&s=商家名称&o=商家简介&c=
 */
+(NSMutableDictionary*)RegisterSeller:(NSString*)phone password:(NSString*)p nickName:(NSString*)nn sellerDescription:(NSString*)o messageVerification:(NSString*)c sellerName:(NSString*)s;

/*1.2普通用户（买家）注册
 http://114.215.83.218/d/v1/u/r?jc=&m=18651507199&p=123456&nn=昵称&c=257826
 */
+(NSMutableDictionary*)RegisterBuyer:(NSString*)phone password:(NSString*)p nickName:(NSString*)nn messageVerification:(NSString*)c;

/*1.3普通登录验证
 http://114.215.83.218/d/v1/u/l?jc=&n=1861507191&p=123456
 */
+(NSString*)Login:(NSString*)phone pwd:(NSString*)password;

/*1.4第三方登录验证
 http://114.215.83.218/d/v1/u/l3?jc=&tp=0&ac=372998843
 */
+(NSMutableDictionary*)LoginFromThirdParty:(NSString*)ty tokenFromThirdParty:(NSString*)ac;

/*1.5-1用户忘记密码（请求验证码）
 http://114.215.83.218/d/v1/u/sc?jc=&m=18651507191
 */
+(NSMutableDictionary*)ForgetPassword:(NSString*)phone;

/*1.5-2用户忘记密码（重置密码）
 http://114.215.83.218/d/v1/u/up?jc=&u=1&p=admin&c=601758
 */
+(NSMutableDictionary*)SetNewPassword:(NSString*)uid newPassword:(NSString*)pwd verificationCode:(NSString*)vc;

/*1.6用户获取个人信息
 http://114.215.83.218/d/v1/u/i?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2
 */
+(NSMutableDictionary*)GetUserInfo;

/*1.7 添加关注接口（用户、商家、商品）
 http://114.215.83.218/d/v1/u/a?jc=&tk=8E5054AA80C2606488868C845284E6A2&u=2&b=4&g=&t=1&s=1
 */
+(NSMutableDictionary*)AddFocus:(NSString*)focusedUid goodsId:(NSString*)g focusStatus:(NSString*)s focusType:(NSString*)t;

/*1.8我关注的用户列表
 http://114.215.83.218/d/v1/u/m?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2&t=1
 */
+(NSMutableDictionary*)GetFocusedUserList:(NSString*)focusType;

/*1.9用户注册发送短信验证码
 http://114.215.83.218/d/v1/u/rs?jc=&m=18651507191
 */
+(NSMutableDictionary*)GetVerificationCode:(NSString*)phone;

/*1.10用户信息修改
 http://114.215.83.218/d/v1/u/ui?jc=&tk=8E5054AA80C2606488868C845284E6A2&u=2&nn=
 */
+(NSMutableDictionary*)UpdateUserInfo:(NSString*)nickName;

/*1.11用户上传头像
 http://114.215.83.218/d/v1/u/u/p?jc=&tk=8E5054AA80C2606488868C845284E6A2&u=2
 */
+(NSMutableDictionary*)UploadUserAvatar:(UIImage*)avatar;

/* 2.1商家商品列表
 http://114.215.83.218/d/v1/g/l?u=2&tk=8E5054AA80C2606488868C845284E6A2&s=2&pageIndex=1&pageSize=5
 */
+(NSMutableDictionary*)GetSellerGoodsList:(NSString*)sellerID pageIndex:(NSString*)index pageSize:(NSString*)size;

/*2.2 上传商品图片接口
 http://114.215.83.218/d/v1/g/u?jc=&u=2&token=
 */
+(NSMutableDictionary*)UploadGoodsImage:(UIImage*)image;

/*2.3 商家添加/更新商品
 注:此接口要调用2.7分类列表接口、标签接口、2.2图片上传接口
 http://114.215.83.218/d/v1/g/u?u=2&tk=8E5054AA80C2606488868C845284E6A2&n=香奈儿套装&p=7889.9&num=90&m=描述商品&pic=&s=1&t=1&btn=& btad=
 */
+(NSMutableDictionary*)AddorUpdateGoods:(NSString*)goodsName price:(NSString*)p number:(NSString*)num goodsDescription:(NSString*)m image:(NSString*)pic tag:(NSString*)t buyTagName:(NSString*)bta buyTagID:(NSString*)btad;

/*2.4商家对商品上架下架
 http://114.215.83.218/d/v1/g/is?u=2&tk=8E5054AA80C2606488868C845284E6A2&g=16&s=1
 */
+(NSMutableDictionary*)ShelveGoods:(NSString*)goodsId goodsStatus:(NSString*)s;

/*2.5商品详细
 http://114.215.83.218/d/v1/g/i?u=2&tk=8E5054AA80C2606488868C845284E6A2&g=16
 */
+(NSMutableDictionary*)GetGoodsInfo:(NSString*)goodsId;

/*2.6商品删除
 http://114.215.83.218/d/v1/g/d?u=2&tk=8E5054AA80C2606488868C845284E6A2&g=16
 */
+(NSMutableDictionary*)DeleteGoods:(NSString*)goodsId;

/*2.7商品分类列表
 http://114.215.83.218/d/v1/ca/l?u=2&tk=8E5054AA80C2606488868C845284E6A2
 */
+(NSMutableDictionary*)GetCategoryList;

/*3.1 添加商品到购物车
 http://114.215.83.218/d/v1/c/a?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2&g=3&num=1
 */
+(NSMutableDictionary*)AddGoodstoCart:(NSString*)goodsId goodsNumber:(NSString*)num;

/*3.2 我的购物车
 http://114.215.83.218/d/v1/c/l?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2
*/
+(NSMutableDictionary*)GetMyCartList;

/*3.3 删除购物车商品
 http://114.215.83.218/d/v1/c/d?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2
 */
+(NSMutableDictionary*)RemoveGoodsfromCart:(NSString*)cartRelatedGoodsID;

/*4.1 我的订单
http://114.215.83.218/d/v1/o/l?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2&s=1
 */
+(NSMutableDictionary*)GetOrderList:(NSString*)orderStatus;

/*4.2 购物车生成订单
 http://114.215.83.218/d/v1/o/c2?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2&cid=1&a=1
 */
+(NSMutableDictionary*)CreateOrder:(NSString*)cartId address:(NSString*)a;

/*4.3 订单状态
 http://114.215.83.218/d/v1/o/s?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2&od=1&s=1
 */
+(NSMutableDictionary*)UpdateOrderStatus:(NSString*)orderID orderStatus:(NSString*)s;

/*4.4订单支付
 http://114.215.83.218/d/v1/o/p?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2&od=1
 */
+(NSMutableDictionary*)PayOrder:(NSString*)orderID;

/*5.1 我的收货地址
 http://114.215.83.218/d/v1/a/l?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2
 */
+(NSMutableDictionary*)GetAddressList;

/*5.2 地址添加
 http://114.215.83.218/d/v1/a/u?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2&id=1&p=usa&c=&area=&m=&r=&s=&a
 */
+(NSMutableDictionary*)AddAddress:(NSString*)addressId province:(NSString*)p city:(NSString*)c area:(NSString*)region street:(NSString*)s phone:(NSString*)m receiverName:(NSString*)r detailedAddress:(NSString*)a;

/*5.3 设置默认地址
 http://114.215.83.218/d/v1/a/f?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2&id=1
 */
+(NSMutableDictionary*)SetDefaultAddress:(NSString*)addressId;

/*5.4 删除收货地址
 http://114.215.83.218/d/v1/a/d?jc=&u=2&tk=8E5054AA80C2606488868C845284E6A2&id=4
 */
+(NSMutableDictionary*)DeleteAddress:(NSString*)addressId;


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
