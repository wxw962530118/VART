//
//  VTAusleseNetWork.m
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/13.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTAusleseNetWork.h"

@implementation VTAusleseNetWork
+(instancetype)manager{
    static VTAusleseNetWork * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}


-(NSURLSessionDataTask *)getAusleseDataWith:(NSString *)URLString  parameters:(NSDictionary *)parameters success:(void (^)(id))success faile:(void (^)(NSURLSessionDataTask *, NSError *))faile{
    NSURLSessionDataTask * task = [[VTNetWorkManager shareInstance]GET:URLString parameters:parameters progress:0 success:^(id response) {
        success(response);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        faile(task,error);
    }];
    return  task;
}
@end
