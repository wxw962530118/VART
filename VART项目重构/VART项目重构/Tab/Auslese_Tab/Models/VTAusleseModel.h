//
//  VTAusleseModel.h
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/13.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTBaseModel.h"
#import "VTAusleseImageModel.h"
typedef NS_ENUM(NSInteger ,AusleseContentType){
   AusleseContentType_Normal,
   AusleseContentType_Works,
};

@interface VTAusleseModel : VTBaseModel
/**要展示的内容类型*/
@property (nonatomic, assign)AusleseContentType type;
/**图片数组*/
@property (nonatomic, strong) NSArray  * imagesArray;
/**标题*/
@property (nonatomic, strong) NSString * title;
/**标签名*/
@property (nonatomic, strong) NSString * tags;
/**内容*/
@property (nonatomic, strong) NSString * content;
/***/
@property (nonatomic, strong) NSURL * urlStr;

@end
