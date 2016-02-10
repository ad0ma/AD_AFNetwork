//
//  ADRequestManager.m
//  AD_AFNetwork
//
//  Created by Adoma's MacbookPro on 16/2/10.
//  Copyright © 2016年 adoma. All rights reserved.
//

#import "ADRequestManager.h"

@implementation ADRequestManager

+ (void)GET:(NSString *)URL
    success:(void (^)(id response))success
    failure:(void (^)(NSError *error))Error
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //生成请求
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:URL parameters:nil error:nil];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            Error(error);
        } else {
            success(responseObject);
        }
    }];
    [dataTask resume];
}

+ (void)POST:(NSString *)URL
      params:(NSDictionary * )params
     success:(void (^)(id response))success
     failure:(void (^)(NSError *error))Error
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //生成请求
    NSMutableURLRequest *request =[[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:URL parameters:params error:nil];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            Error(error);
        } else {
            success(responseObject);
        }
    }];
    [dataTask resume];
}

+ (void)UPLOADIMAGE:(NSString *)URL
             params:(NSDictionary *)params
       progressView:(UIProgressView *)progressView
        uploadImage:(UIImage *)image
          imageName:(NSString *)imageName
            success:(void (^)(id response))success
            failure:(void (^)(NSError *error))Error
{
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:URL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        //打包需要上传的图片数据
        NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
        
        [formData appendPartWithFileData:imageData name:imageName fileName:[NSString stringWithFormat:@"%@.jpg",imageName] mimeType:@"image/jpeg"];
        
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //主线程更新progressView
                          [progressView setProgress:uploadProgress.fractionCompleted];
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          Error(error);
                      } else {
                          success(responseObject);
                      }
                  }];
    
    [uploadTask resume];

}

+ (void)MonitorNetwork:(void (^)(NSString * status))netStatus
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        netStatus(AFStringFromNetworkReachabilityStatus(status));
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

@end
