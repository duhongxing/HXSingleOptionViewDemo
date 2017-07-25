//
//  HXHttpTool.m
//  HXSingleOptionViewDemo
//
//  Created by MacOS on 17/7/25.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import "HXHttpTool.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "NSString+Hashing.h"

#define DEV_SERVER @"" //开发环境
#define PRO_SERVER @"http://app.xxxxxxxxx/index.php?g=apps&m=user&a=" //生产环境
#define MY_String @"" //自己的字符串


@implementation HXHttpTool

+ (void)requestWithMethod:(HXRequestType)methodType url:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{

//    NSURL *baseURL =[NSURL URLWithString:PRO_SERVER];

    NSString *completeURL =[NSString stringWithFormat:@"%@%@",PRO_SERVER,url];

    //获取请求管理者
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    [HXHttpTool sessionManagerConfigWithManager:manager];

    switch (methodType) {
        case HXRequestTypeGet:
        {
            [manager GET:completeURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {

                NSLog(@"%@",downloadProgress);

            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success([HXHttpTool tryToParseDataWithData:responseObject]);
                }

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

                if (failure) {
                    failure(error);
                }
            }];

        }
            break;
        case HXRequestTypePost:
        {
            [manager POST:completeURL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {

            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success([HXHttpTool tryToParseDataWithData:responseObject]);
                }

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];

        }
            break;

        default:
            break;
    }

}

+ (void)loginWithUserName:(NSString *)username Password:(NSString *)password success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSDictionary *params = @{@"token":[NSString getTokenWithString:MY_String],
                             @"username":username,
                             @"password":password};
    [HXHttpTool requestWithMethod:HXRequestTypePost url:@"login" params:params success:success failure:failure];
}


#pragma mark ======  辅助方法     =======

//数据解析
+ (id)tryToParseDataWithData:(id)responseData{
    if ([responseData isKindOfClass:[NSData class]]) {
        if (responseData == nil) {
            return @"";
        }else{
            NSError *error = nil;
            NSDictionary *response =[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
            if (error != nil) {
                return [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            }
            else
            {
                return response;
            }
        }
    }else{
        return [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    }
}

//基本配置
+ (void)sessionManagerConfigWithManager:(AFHTTPSessionManager *)manager{
    //设置请求超时
    manager.requestSerializer.timeoutInterval = 20;

    //打开活动指示器
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;

    /*! 设置相应的缓存策略：此处选择不用加载也可以使用自动缓存【注：只有get方法才能用此缓存策略，NSURLRequestReturnCacheDataDontLoad】 */
    //        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;

    /*! 设置返回数据类型为 json, 分别设置请求以及相应的序列化器 */
    /*!
     json：[AFJSONResponseSerializer serializer](常用)
     http：[AFHTTPResponseSerializer serializer]
     */

    AFHTTPResponseSerializer *response = [AFHTTPResponseSerializer serializer];
    /*! 这里是去掉了键值对里空对象的键值 */
    //        response.removesKeysWithNullValues = YES;
    manager.responseSerializer = response;


    /* 设置请求服务器数类型式为 HTTP */
    /*!
     json：[AFJSONRequestSerializer serializer](常用)
     http：[AFHTTPRequestSerializer serializer]
     */
    AFHTTPRequestSerializer *request = [AFHTTPRequestSerializer serializer];
    request.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer = request;


    /*! 设置apikey ------类似于自己应用中的token---此处仅仅作为测试使用*/
    //        [manager.requestSerializer setValue:apikey forHTTPHeaderField:@"apikey"];

    /*! 复杂的参数类型 需要使用json传值-设置请求内容的类型*/
    //        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    /*! 设置响应数据的基本类型 */
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/xml",@"text/plain", @"application/javascript", @"image/*", nil];

    /*! https 参数配置 */
    /*!
     采用默认的defaultPolicy就可以了. AFN默认的securityPolicy就是它, 不必另写代码. AFSecurityPolicy类中会调用苹果security.framework的机制去自行验证本次请求服务端放回的证书是否是经过正规签名.
     */
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;

    /*! 自定义的CA证书配置如下： */
    /*! 自定义security policy, 先前确保你的自定义CA证书已放入工程Bundle */
    /*!
     https://api.github.com网址的证书实际上是正规CADigiCert签发的, 这里把Charles的CA根证书导入系统并设为信任后, 把Charles设为该网址的SSL Proxy (相当于"中间人"), 这样通过代理访问服务器返回将是由Charles伪CA签发的证书.
     */
    //        NSSet <NSData *> *cerSet = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
    //        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:cerSet];
    //        policy.allowInvalidCertificates = YES;
    //        manager.securityPolicy = policy;

    /*! 如果服务端使用的是正规CA签发的证书, 那么以下几行就可去掉: */
    //        NSSet <NSData *> *cerSet = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
    //        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:cerSet];
    //        policy.allowInvalidCertificates = YES;
    //        manager.securityPolicy = policy;
}


@end
