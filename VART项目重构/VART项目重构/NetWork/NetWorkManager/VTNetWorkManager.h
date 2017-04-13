//
//  VTNetWorkManager.h
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/13.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VTNetWorkManager : NSObject

/**单例创建管理者*/
+(instancetype )shareInstance;

/**
 GET请求
 
 @param URLString  URL
 @param parameters 参数
 @param progress 进度
 @param success 成功回调
 @param failure 失败回调
 */
-(NSURLSessionDataTask *)GET:(NSString *)URLString  parameters:(NSDictionary *)parameters progress:(CGFloat )progress  success:(void(^)(id))success failure:(void(^)(NSURLSessionDataTask * task, NSError * error))failure;

/**
 POST请求
 
 @param URLString  URL
 @param parameters 参数
 @param progress 进度
 @param success 成功回调
 @param failure 失败回调
 */

-(NSURLSessionDataTask *)POST:(NSString *)URLString  parameters:(NSDictionary *)parameters progress:(CGFloat )progress success:(void(^)(id))success failure:(void(^)(NSURLSessionDataTask * task, NSError * error))failure;



/**
 下载文件
 
 @param urlString 文件URL
 @param downloadProgressBlock 下载进度回调
 @param completionHandler  完成的回调
 @param failure  失败的回调
 */
-(NSURLSessionDownloadTask *)downAudioWithUrlString:(NSString *)urlString
                                           progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                  completionHandler:(void (^)(NSURL *filePath))completionHandler
                                     failureHandler:(void (^)(NSError *error))failure;


/**
 DELETE请求
 
 @param URLString URL
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 */
-(NSURLSessionDataTask *)DELETE:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;


/**
 PUT请求
 
 @param URLString URL
 @param parameters 参数
 @param success 成功回调
 @param failur 失败回调
 */
-(NSURLSessionDataTask *)PUT:(NSString *)URLString  parameters:(NSDictionary *)parameters success:(void(^)(id))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failur;


@end
