//
//  HXHttpTool.h
//  HXSingleOptionViewDemo
//
//  Created by MacOS on 17/7/25.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,HXRequestType) {
    HXRequestTypeGet = 1,
    HXRequestTypePost = 2
};


@interface HXHttpTool : NSObject


/**
 请求方法

 @param methodType 请求方式
 @param url URL
 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestWithMethod:(HXRequestType)methodType
                      url:(NSString *)url
                   params:(NSDictionary *)params
                  success:(void(^)(id response))success
                  failure:(void(^)(NSError *error))failure;


/**
 登录请求

 @param username 用户名
 @param password 密码
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)loginWithUserName:(NSString *)username
                 Password:(NSString *)password
                  success:(void(^)(id response))success
                  failure:(void(^)(NSError *error))failure;

@end
