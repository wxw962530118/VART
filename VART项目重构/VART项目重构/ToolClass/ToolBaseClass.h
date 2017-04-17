//
//  ToolBaseClass.h
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/8.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolBaseClass : NSObject
+(instancetype )manager;
/** *用颜色生成图片 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/** *提示弹窗 快捷方式 otherButtonTitles类型:NSString或NSArray */
- (UIAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(id)otherButtonTitles callBack:(void(^)(NSUInteger index))callBack;

/** *底部弹窗 快捷方式 otherButtonTitles类型:NSString或NSArray */
- (UIActionSheet *)actionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(id)otherButtonTitles callBack:(void (^)(NSUInteger))callBack;


@end



/** Tool: Alert快捷方式, otherButtonTitles类型:NSString或NSArray ,点击取消的返回值为 0 */
CG_INLINE UIAlertView *VTAlertView(NSString *title, NSString *message, NSString *cancelButtonTitle, id otherButtonTitle, void(^callBack)(NSUInteger index)){
    return [[ToolBaseClass manager] alertWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle callBack:^(NSUInteger index) {
        callBack(index);
    }];
}

/** Tool: ActionSheet快捷方式, otherButtonTitles类型:NSString或NSArray */
CG_INLINE UIActionSheet *VTActionSheet(NSString *title, NSString *cancelButtonTitle, NSString *destructiveButtonTitle, id otherButtonTitles, void(^callBack)(NSUInteger index)){
    return [[ToolBaseClass manager] actionSheetWithTitle:title cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles callBack:^(NSUInteger index) {
        callBack(index);
    }];
}

/** Tool: 拨打客服电话, 快捷方式 */
CG_INLINE void ToolCallCustomerServices(){
    [[ToolBaseClass manager] alertWithTitle:@"提示" message:[NSString stringWithFormat:@"您确定要拨打%@?", @""] cancelButtonTitle:@"呼叫" otherButtonTitles:@[@"取消"] callBack:^(NSUInteger index) {
        if (index == 0) {
            NSMutableString *telStr = [[NSMutableString alloc] initWithFormat:@"tel:%@", @""];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]];
        }
    }];
};

/** Tool: 拨打客服电话, 传入拨打电话信息, 电话号码 */
CG_INLINE void ToolCallServiceTelephone(NSString *message, NSString *telephone){
    [[ToolBaseClass manager] alertWithTitle:@"提示" message:message cancelButtonTitle:@"呼叫" otherButtonTitles:@[@"取消"] callBack:^(NSUInteger index) {
        if (index == 0) {
            NSMutableString *telStr = [[NSMutableString alloc] initWithFormat:@"tel:%@", telephone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]];
        }
    }];
}
