//
//  KDownloadManager.h
//  Multimedia
//
//  Created by 宇航 on 2020/5/30.
//  Copyright © 2020 tecent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWDownloadModel.h"

@interface KDownloadManager : NSObject
// 初始化下载单例，若之前程序杀死时有正在下的任务，会自动恢复下载
+ (instancetype)shareManager;

// 开始下载
- (void)startDownloadTask:(HWDownloadModel *)model;

// 暂停下载
- (void)pauseDownloadTask:(HWDownloadModel *)model;

// 删除下载任务及本地缓存
- (void)deleteTaskAndCache:(HWDownloadModel *)model;
@end

