//
//  VTMacroEnvironment.h
//  VART项目重构
//
//  Created by 王新伟 on 2017/4/11.
//  Copyright © 2017年 王新伟. All rights reserved.
//
/*  环境参数修改说明
 *
 *  [开发环境] 下修改 <开发阶段> 环境配置
 *
 *  [发布状态] 无需修改 该配置文件
 */

#ifndef TCMacroEnvironment_h
#define TCMacroEnvironment_h

#ifdef DEBUG // 处于开发阶段
#define TCLog(...) NSLog(__VA_ARGS__)

#else // 处于发布阶段
#define TCLog(...)
#endif

#ifndef __OPTIMIZE__

/* -------------- <开发阶段> ---------------- */

#define NSLog(...) NSLog(__VA_ARGS__)

//正式发布接口
//#define VTInterFaceNet   @"http://api.vart.cc/4/"

//测试接口

//#define VTInterFaceNet   @"http://api-test.vart.cc/4/"

//测试接口
#define VTInterFaceNet    @"http://api.vart.cc/4/"

/* ----------------------------------------- */

#else

/* --------------- <发布阶段> --------------- */

#define NSLog(...) {}

#define TCInterFaceNet @"http://admin.letscharge.cn"

/* ----------------------------------------- */

#endif

#endif /* TCMacroEnvironment_h */
