//
//  ImagePickerController.m
//  Multimedia
//
//  Created by 宇航 on 2020/5/14.
//  Copyright © 2020 tecent. All rights reserved.
//

#import "ImagePickerController.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

/*
 *图片的采集和显示
 *kUTTypeImage
 *查看图片格式
 */
@interface ImagePickerController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(strong,nonatomic) UIImagePickerController *imagePickerCon;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation ImagePickerController

- (UIImagePickerController *)imagePickerCon{
    if (_imagePickerCon == nil) {
        _imagePickerCon = [[UIImagePickerController alloc] init];
        //采集源类型
        _imagePickerCon.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //媒体类型
        _imagePickerCon.mediaTypes = [NSArray arrayWithObjects:(__bridge NSString*)kUTTypeImage, nil];
        //设置代理
        _imagePickerCon.delegate =self;
    }
    return _imagePickerCon;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}
- (IBAction)collectImageDidClick:(id)sender {
    //通过摄像头来采集
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerCon.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
     //通过图片库来采集
      self.imagePickerCon.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:self.imagePickerCon animated:YES completion:nil];
}

//完成采集图像处理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    NSLog(@"%s",__func__);
    //获取媒体类型
    NSString*type = info[UIImagePickerControllerMediaType];
    //如果媒体类型是图片类型
    if ([type isEqualToString:(__bridge NSString*)kUTTypeImage]) {
        //获取采集的图片
        UIImage * image = info[UIImagePickerControllerOriginalImage];
        
        // 把图片转成NSData类型的数据来保存文件(存入到沙盒中)
        NSData *imageData;
        // 判断图片是不是png格式的文件
        if (UIImagePNGRepresentation(image)) {
            // 返回为png图像。
            imageData = UIImagePNGRepresentation(image);
        }else {
            // 返回为JPEG图像
            imageData = UIImageJPEGRepresentation(image, 1.0);
        }
        // 路径拼接,写入-----
        NSString * imageSavePath ;
        [imageData writeToFile:imageSavePath atomically:YES];
        

        UIImagePNGRepresentation(image);
        UIImageJPEGRepresentation(image, 1);
        //显示
        self.iconView.image = image;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
//取消采集图像处理
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"%s",__func__);
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
