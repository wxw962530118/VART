//
//  NetWorkManager.h
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/11.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkManager : NSObject

/**单例创建管理者*/
+(instancetype )shareInstance;
    
/**
 GET请求
 @param URLString  URL
 @param parameters 参数
 @param progress 进度
 @param success 成功回调
 @param faile 失败回调
 */
-(NSURLSessionDataTask *)GET:(NSString *)URLString  parameters:(NSDictionary *)parameters progress:(CGFloat )progress  success:(void(^)(id))success faile:(void(^)(id))faile;

/**
 POST请求
 @param URLString  URL 
 @param parameters 参数
 @param progress 进度
 @param success 成功回调
 @param faile 失败回调
*/
    
-(NSURLSessionDataTask *)POST:(NSString *)URLString  parameters:(NSDictionary *)parameters progress:(CGFloat )progress success:(void(^)(id))success faile:(void(^)(id))faile;
@end
