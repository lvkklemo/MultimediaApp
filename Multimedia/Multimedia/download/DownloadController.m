//
//  DownloadController.m
//  Multimedia
//
//  Created by 宇航 on 2020/5/30.
//  Copyright © 2020 tecent. All rights reserved.
//

#import "DownloadController.h"
#import "KDownloadManager.h"

@interface DownloadController ()
@property(nonatomic,strong)KDownloadManager * downloadManager;
@end

@implementation DownloadController

- (KDownloadManager *)downloadManager{
    if (!_downloadManager) {
        _downloadManager=[[KDownloadManager alloc] init];
    }
    return _downloadManager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)downloadAction:(UIButton *)sender {
    
    HWDownloadModel * download = [[HWDownloadModel alloc] init];
    download.vid = @"101";
    download.fileName=@"apple";
  download.url=@"https://www.apple.com/105/media/cn/ipad-pro/how-to/2017/a0f629be_c30b_4333_942f_13a221fc44f3/films/dock/ipad-pro-dock-cn-20160907_1280x720h.mp4";
    [self.downloadManager startDownloadTask:download];
    
}

@end
