//
//  VTNetWorkManager.m
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/13.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTNetWorkManager.h"
@interface VTNetWorkManager ()

@property (nonatomic, strong) AFHTTPSessionManager * AFHTTPSessionManager;

@end

@implementation VTNetWorkManager

+(instancetype )shareInstance{
    static VTNetWorkManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[VTNetWorkManager alloc]init];
    });
    return manager;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        _AFHTTPSessionManager = [AFHTTPSessionManager manager];
        //最大的超时请求时间
        _AFHTTPSessionManager.requestSerializer.timeoutInterval = 15.f;
        //请求队列的最大并发数
        _AFHTTPSessionManager.operationQueue.maxConcurrentOperationCount = 5;
    }
    return self;
}

-(NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(NSDictionary *)parameters progress:(CGFloat)progress success:(void (^)(id))success failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure{
    NSURLSessionDataTask * task = [self.AFHTTPSessionManager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
        NSDictionary * response = responseObject;
        if(response == nil){
            ErrorLog(@"JSON解析失败");
            NSError * error = [NSError errorWithDomain:kPrivateErrorDomain code:1 userInfo:@{kPrivateErrorMessage:@"JSON解析失败"}];
            failure(task,error);
        }else{
            success(response);
        }
        success(response);
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        failure(task ,error);
    }];
    return task;
}

-(NSURLSessionDataTask *)PUT:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    NSURLSessionDataTask * task = [self.AFHTTPSessionManager PUT:URLString parameters:parameters success:^(NSURLSessionDataTask * task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        failure(task ,error);
    }];
    return task;
}

-(NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(NSDictionary *)parameters progress:(CGFloat)progress success:(void (^)(id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    NSURLSessionDataTask *  dataDask = [self.AFHTTPSessionManager POST:URLString parameters:parameters progress:^(NSProgress * uploadProgress) {
        
    } success:^(NSURLSessionDataTask * task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        failure(task ,error);
    }];
    return  dataDask;
}


-(NSURLSessionDataTask *)DELETE:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    NSURLSessionDataTask * dataTask = [self.AFHTTPSessionManager DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * task, id  responseObject) {
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        
    }];
    return dataTask;
}


-(NSURLSessionDownloadTask *)downAudioWithUrlString:(NSString *)urlString progress:(void (^)(NSProgress *))downloadProgressBlock completionHandler:(void (^)(NSURL *))completionHandler failureHandler:(void (^)(NSError *))failure{
    //下载地址
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    __block NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    downloadURL = [downloadURL URLByAppendingPathComponent:@"audio"];
    NSString *pathString = [downloadURL.absoluteString substringFromIndex:7];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:pathString isDirectory:nil]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:pathString withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *filePathString = [pathString stringByAppendingString:urlString.lastPathComponent];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePathString isDirectory:nil]) {
        filePathString = [NSString stringWithFormat:@"file://%@",filePathString];
        downloadURL = [NSURL URLWithString:filePathString];
        completionHandler(downloadURL);
        return nil;
    }
    filePathString = [NSString stringWithFormat:@"file://%@",filePathString];
    downloadURL = [NSURL URLWithString:filePathString];
    NSURLSessionDownloadTask * dataTask = [self.AFHTTPSessionManager downloadTaskWithRequest:request progress:^(NSProgress * downloadProgress) {
        downloadProgressBlock(downloadProgress);
    } destination:^NSURL * (NSURL * targetPath, NSURLResponse * response) {
        return downloadURL;
    } completionHandler:^(NSURLResponse * response, NSURL * filePath, NSError * error) {
        if (error == nil) {
            completionHandler(filePath);
        }else{
            failure(error);
        }
    }];
    [dataTask resume];
    return dataTask;
}

@end
