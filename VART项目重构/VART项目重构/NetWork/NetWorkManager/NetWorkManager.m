//
//  NetWorkManager.m
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/11.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "NetWorkManager.h"
@interface  NetWorkManager ()
@property (nonatomic, strong) AFHTTPSessionManager * AFHTTPSessionManager;
@end
    
@implementation NetWorkManager

+(instancetype )shareInstance{
    static NetWorkManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NetWorkManager alloc]init];
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
    

@end
