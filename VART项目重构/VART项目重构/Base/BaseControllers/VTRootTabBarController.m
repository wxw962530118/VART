//
//  VTRootTabBarController.m
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/8.
//  Copyright © 2017年 王新伟. All rights reserved.
//

#import "VTRootTabBarController.h"
#import "VTRootTabItemModel.h"
#import "MJExtension.h"
#import "VTRootNavigationController.h"
/** TabBar根控制器目录 */
#define TabControllerCatalog @"TabCatalog"

@interface VTRootTabBarController ()

@end

@implementation VTRootTabBarController

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static VTRootTabBarController * sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.viewControllers = [self foundTabBarControllers];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self foundTabBarControllers];
}

/** 从本地获取Tabbar根控制器目录 */
- (NSArray<VTRootTabItemModel *> *)fetchTabCatalogFromBundle{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:TabControllerCatalog ofType:@"plist"];
    NSArray *tabConCatalog = [[NSArray alloc] initWithContentsOfFile:plistPath];
    NSMutableArray * tabModels = (NSMutableArray *)[VTRootTabItemModel objectArrayWithKeyValuesArray:tabConCatalog];
    for (VTRootTabItemModel * model in tabModels) {
        model.rIcon_normal = [UIImage imageNamed:model.icon_normal];
        model.rIcon_selected = [UIImage imageNamed:model.icon_selected];
    }

    return tabModels;
}

/** 解析数据创建Tab的子控制器 */
- (NSArray *)foundTabBarControllers{
    NSMutableArray * arrayTabControllers = [NSMutableArray array];
    for (VTRootTabItemModel * tabModel in [self fetchTabCatalogFromBundle]) {
        UIViewController *tabController = [[[NSClassFromString(tabModel.class_name) class] alloc] init];
        tabController.title = tabModel.title;
        tabController.tabBarItem = [[UITabBarItem alloc] initWithTitle:tabModel.title image:tabModel.rIcon_normal selectedImage:tabModel.rIcon_selected];
        [arrayTabControllers addObject:[[VTRootNavigationController alloc] initWithRootViewController:tabController]];
    }
    return arrayTabControllers;
}

@end
