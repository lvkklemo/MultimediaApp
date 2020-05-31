//
//  HWDownloadModel.m
//  HWProject
//
//  Created by yuhanglv on 2018/4/24.
//  Copyright © 2018年 yuhanglv. All rights reserved.
//

#import "HWDownloadModel.h"

@implementation HWDownloadModel

- (NSString *)localPath
{
    if (!_localPath) {
        NSString *fileName = [_url substringFromIndex:[_url rangeOfString:@"/" options:NSBackwardsSearch].location + 1];
        NSString *str = [NSString stringWithFormat:@"%@_%@", _vid, fileName];
        _localPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:str];
    }
    
    return _localPath;
}


@end
