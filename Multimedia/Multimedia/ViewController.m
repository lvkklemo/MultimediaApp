//
//  ViewController.m
//  Multimedia
//
//  Created by 宇航 on 2020/5/14.
//  Copyright © 2020 tecent. All rights reserved.
//

/*
 *1.图片的采集和显示
 *2.音频的录制和播放
 *3.视频的录制和播放
 */
#import "ViewController.h"
#import "ImagePickerController.h"
#import "AudioRecorderController.h"
#import "VideoController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)imageDidClick:(id)sender {
    ImagePickerController*vc=[[ImagePickerController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)voiceDidClick:(id)sender {
    AudioRecorderController*vc=[[AudioRecorderController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)vedioDidClick:(id)sender {
    VideoController*vc=[[VideoController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
