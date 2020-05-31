//
//  KDownloadManager.m
//  Multimedia
//
//  Created by 宇航 on 2020/5/30.
//  Copyright © 2020 tecent. All rights reserved.
//

#import "KDownloadManager.h"

@interface KDownloadManager ()<NSURLSessionDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURLSession *session;                 // NSURLSession
@property (nonatomic, strong) NSMutableDictionary *dataTaskDic;      // 同时下载多个文件，需要创建多个NSURLSessionDownloadTask，用该字典来存储
@property (nonatomic, strong) NSMutableDictionary *downloadTaskDic;  // 记录任务调用startDownloadTask:方法时间，禁止同一任务极短时间重复调用，防止状态显示错误
@property (nonatomic, assign) NSInteger currentCount;                // 当前正在下载的个数
@property (nonatomic, assign) NSInteger maxConcurrentCount;          // 最大同时下载数量
@property (nonatomic, assign) BOOL allowsCellularAccess;             // 是否允许蜂窝网络下载

@end

@implementation KDownloadManager
+ (instancetype)shareManager{
    static KDownloadManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

// 开始下载
- (void)startDownloadTask:(HWDownloadModel *)model{
    
}
// 暂停下载
- (void)pauseDownloadTask:(HWDownloadModel *)model{
    
}

// 删除下载任务及本地缓存
- (void)deleteTaskAndCache:(HWDownloadModel *)model{
    
}
@end
