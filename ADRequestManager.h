//
//  ADRequestManager.h
//  AD_AFNetwork
//
//  Created by Adoma's MacbookPro on 16/2/10.
//  Copyright © 2016年 adoma. All rights reserved.
//  个人GitHub - https://github.com/ad0ma 如果喜欢请给个星,谢谢

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface ADRequestManager : NSObject

///GET请求数据
+ (void)GET:(NSString *)URL
    success:(void (^)(id response))success
    failure:(void (^)(NSError *error))Error;

///POST请求数据
+ (void)POST:(NSString *)URL
      params:(NSDictionary * )params
     success:(void (^)(id response))success
     failure:(void (^)(NSError *error))Error;

///上传图片(带进度条需自定义)
+ (void)UPLOADIMAGE:(NSString *)URL
             params:(NSDictionary *)params
       progressView:(UIProgressView *)progressView
        uploadImage:(UIImage *)image
          imageName:(NSString *)imageName
            success:(void (^)(id response))success
            failure:(void (^)(NSError *error))Error;

///网络监听
+ (void)MonitorNetwork:(void (^)(NSString * status))netStatus;

@end
