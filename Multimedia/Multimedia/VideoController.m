//
//  VideoController.m
//  Multimedia
//
//  Created by 宇航 on 2020/5/15.
//  Copyright © 2020 tecent. All rights reserved.
//

/*视频录制和播放
 *UIImagePickerController(录视频)
 *AVPlayerViewController(播放)
 *1采集源类型(sourceType)UIImagePickerControllerSourceTypeCamera
 *2媒体类型mediaTypes kUTTypeImage,kUTTypeMovie
 *3协议
 *
 */
#import "VideoController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface VideoController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    NSURL * mediaUrl;
}
@property(nonatomic,strong)UIImagePickerController * pickerCon;
@property(nonatomic,strong)AVPlayerViewController * playerCon;
@end

@implementation VideoController

//采集视频
- (UIImagePickerController *)pickerCon{
    if (!_pickerCon) {
        _pickerCon = [[UIImagePickerController alloc] init];
        //采集源类型
        _pickerCon.sourceType = UIImagePickerControllerSourceTypeCamera;
        //媒体类型
        _pickerCon.mediaTypes = [NSArray arrayWithObjects:(__bridge NSString*)kUTTypeMovie, nil];
        //设置代理
        _pickerCon.delegate=self;
        //视频质量
        _pickerCon.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }
    return _pickerCon;
}

//播放视频
- (AVPlayerViewController *)playerCon{
    if (_playerCon == nil) {
        _playerCon = [[AVPlayerViewController alloc] init];
        //采集avplayer对象
        _playerCon.player = [[AVPlayer alloc] initWithURL:mediaUrl];
        //全屏播放窗口
        //[self presentViewController:self.playerCon animated:YES completion:nil];
        
        //播放窗口
        self.playerCon.view.frame = CGRectMake(10, 100, 300, 300);
        [self.view addSubview:self.playerCon.view];
    }
    return _playerCon;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频";
    
}
- (IBAction)collectVidelDidClick:(id)sender {
    //如果摄像头可用,从摄像头采集视频数据
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self presentViewController:self.pickerCon animated:YES completion:nil];
    }
}
- (IBAction)playVideo:(id)sender {
    [self.playerCon.player play];
}

//采集媒体数据完成的回调处理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    //获取媒体类型
    NSString * type = info[UIImagePickerControllerMediaType];
    //如果是视频类型
    if ([type isEqualToString:(__bridge NSString*)kUTTypeMovie]) {
        //获取视频url
       mediaUrl = info[UIImagePickerControllerMediaURL];
        
        NSURL *newVideoUrl ; //一般.mp4
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        newVideoUrl = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]]] ;
        //这个是保存在app自己的沙盒路径里，后面可以选择是否在上传后删除掉。我建议删除掉，免得占空间。
        [self convertVideoQuailtyWithInputURL:mediaUrl outputURL:newVideoUrl completeHandler:nil];
     
        
    }
    [self dismissViewControllerAnimated:self.pickerCon completion:nil];
}

- (void) convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                               outputURL:(NSURL*)outputURL
                         completeHandler:(void (^)(AVAssetExportSession*))handler{
    
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
    //  NSLog(resultPath);
    exportSession.outputURL = outputURL;
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse= YES;
    [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
     {
         switch (exportSession.status) {
             case AVAssetExportSessionStatusCancelled:
                 NSLog(@"AVAssetExportSessionStatusCancelled");
                 break;
             case AVAssetExportSessionStatusUnknown:
                 NSLog(@"AVAssetExportSessionStatusUnknown");
                 break;
             case AVAssetExportSessionStatusWaiting:
                 NSLog(@"AVAssetExportSessionStatusWaiting");
                 break;
             case AVAssetExportSessionStatusExporting:
                 NSLog(@"AVAssetExportSessionStatusExporting");
                 break;
             case AVAssetExportSessionStatusCompleted:
             {
                 NSLog(@"AVAssetExportSessionStatusCompleted");
                 NSLog(@"%@",[NSString stringWithFormat:@"%f s", [self getVideoLength:outputURL]]);
                 NSLog(@"%@", [NSString stringWithFormat:@"%.2f kb", [self getFileSize:[outputURL path]]]);
                 NSData *data = [NSData dataWithContentsOfURL:outputURL];
             }
                 break;
             case AVAssetExportSessionStatusFailed:
                 NSLog(@"AVAssetExportSessionStatusFailed");
                 break;
         }
         
     }];
}

- (CGFloat)getFileSize:(NSString *)path{
    NSLog(@"%@",path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }else{
        NSLog(@"找不到文件");
    }
    return filesize;
}
//此方法可以获取文件的大小，返回的是单位是KB。
- (CGFloat) getVideoLength:(NSURL *)URL{
    
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:URL];
    CMTime time = [avUrl duration];
    int second = ceil(time.value/time.timescale);
    return second;
}

//采集媒体数据取消的回调处理
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"%s",__func__);
    [self dismissViewControllerAnimated:self.pickerCon completion:nil];
}
@end
