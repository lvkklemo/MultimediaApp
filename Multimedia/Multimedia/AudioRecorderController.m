//
//  AudioRecorderController.m
//  Multimedia
//
//  Created by 宇航 on 2020/5/14.
//  Copyright © 2020 tecent. All rights reserved.
//

/*音频录制和播放
 * AVAudioRecorder(录音)
 * 1.录音路径设置
 * 2.录音擦参数设置
 * 采样率 录音格式 录音通道 录音质量
 * AVAudioPlayer(播放)
 */
#import "AudioRecorderController.h"

#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface AudioRecorderController ()
//录音
@property(strong,nonatomic)AVAudioRecorder * recorder;
//播放
@property(strong,nonatomic)AVAudioPlayer * player;
@end

@implementation AudioRecorderController

//录音对象创建和加载
- (AVAudioRecorder *)recorder{
    if (_recorder==nil) {
        //录音保存路径
        NSString*path=[NSHomeDirectory() stringByAppendingString:@"/Documents/record"];
        //NSString*path=[[NSBundle mainBundle] pathForResource:@"ab" ofType:@"mp3"];
        NSLog(@"%@",path);
        
        //录音设置
        NSMutableDictionary * settingDict = [NSMutableDictionary dictionary];
        //采样率
        [settingDict setValue:[NSNumber numberWithInt:44100] forKey:AVSampleRateKey];
        //录音格式
        [settingDict setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
        //录音通道
         [settingDict setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
        //录音质量
        [settingDict setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
        _recorder=[[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:path] settings:settingDict error:nil];
        [_recorder prepareToRecord];
    }
    return _recorder;
}

- (AVAudioPlayer *)player{
    if (_player == nil) {
        //音频文件路径
        NSString*path=[NSHomeDirectory() stringByAppendingString:@"/Documents/record"];
        NSLog(@"%@",path);
        //播放器对象
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:path] error:nil];
        [_player prepareToPlay];
    }
    return _player;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
}

- (IBAction)recordDidClick:(UIButton*)sender {

    if (sender.isSelected == NO) {
        //开启录音
        [self.recorder record];
        sender.selected = YES;
    }else{
        //停止录音
        [self.recorder stop];
        sender.selected = NO;
    }
}

- (IBAction)play:(id)sender {
    //播放
    [self.player play];
}

@end
