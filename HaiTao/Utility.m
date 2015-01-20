//
//  Utility.m
//  HaiTao
//
//  Created by gtcc on 11/8/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import "Utility.h"
#import "Constraint.h"

@implementation Utility


+(NSMutableDictionary*)allErrorMessages
{
    static NSMutableDictionary* _allErrorMessages;
    if(_allErrorMessages == nil)
    {
        _allErrorMessages = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                            @"系统出现异常报错",@"0",
                            @"接口请求成功",@"1",
                            @"用户名/密码错误 用户不存在",@"101",
                            @"此状态用户为卖家，且卖家处于待审核状态",@"102",
                            @"通过手机号码或用户ID查询用户不存在",@"103",
                            @"一分钟内不可重复发送验证码",@"104",
                            @"短信验证码超30分钟作废",@"105",
                            @"验证码信息不存在 请重新发送验证码",@"106",
                            @"手机号码格式验证未通过",@"107",
                            @"手机号码已被注册",@"108",
                            @"用户token验证未通过，用户不存在",@"109",
                            @"用户上传图片返回地址为空",@"110",
                            @"商品不存在或已下架删除",@"111",
                            @"不可重复关注(已关注)",@"112",
                            @"购物车ID为空",@"113",
                            @"用户收货地址不存在",@"114",
                            @"验证码匹配补上",@"115",
                            @"用户权限不足不可操作",@"116",
                            @"短信发送异常",@"117",
                            @"参数不能为空",@"118",
                            @"订单不可关闭(只有未付款订单方可关闭)",@"119",
                            @"订单付款状态异常(不可以付款.即只有未付款、预付状态订单方可付款)",@"120",
                            @"订单不存在或已删除",@"121",
                             nil];
    }
    return _allErrorMessages;
}

+(NSString*)getUserId
{
    NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
    return  [mydefault objectForKey:CURRENT_USERID];
}

+(NSString*)getUserToken
{
    NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
    return  [mydefault objectForKey:CURRENT_TOKEN];
}

+(NSString*)getUserType
{
    NSUserDefaults *mydefault = [NSUserDefaults standardUserDefaults];
    return  [mydefault objectForKey:CURRENT_USERTYPE];
}

+(NSString*)getErrorMessage:(NSString*)errorCode
{
    return [[self allErrorMessages] objectForKey:errorCode];
}

+(void)showErrorMessage:(NSString *)errorCode
{
    UIAlertView* av = [[UIAlertView alloc] initWithTitle:nil
                                                 message:[Utility getErrorMessage:errorCode]
                                                delegate:nil
                                       cancelButtonTitle:@"确定"
                                       otherButtonTitles:nil];
    [av show];
}

+(void)showMessage:(NSString *)title message:(NSString*)msg
{
    UIAlertView* av = [[UIAlertView alloc] initWithTitle:title
                                                 message:msg
                                                delegate:nil
                                       cancelButtonTitle:@"确定"
                                       otherButtonTitles:nil];
    [av show];
}

+(void)showConfirmMessage:(NSString*)title message:(NSString*)msg delegate:(id)dlg
{
    UIAlertView* av = [[UIAlertView alloc] initWithTitle:title
                                                 message:msg
                                                delegate:dlg
                                       cancelButtonTitle:@"取消"
                                       otherButtonTitles:@"确定",nil];
    [av show];
}

@end
