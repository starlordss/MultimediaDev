//
//  ViewController.m
//  multimediaDev
//
//  Created by Zahi on 2017/12/27.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<UINavigationControllerDelegate,
                             UIImagePickerControllerDelegate>

/**采集图片**/
@property (nonatomic, strong) UIImagePickerController *imgPickerCtrler;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController
- (IBAction)onStartButton:(id)sender {
}
- (IBAction)onStartButton:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(UIImagePickerController *)imgPickerCtrler
{
    if (_imgPickerCtrler == nil) {
        _imgPickerCtrler = [UIImagePickerController new];
        
        // 图片来源
        _imgPickerCtrler.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 图片类型
        _imgPickerCtrler.mediaTypes = @[(__bridge NSString *)kUTTypeImage];
        // 设置代理
        _imgPickerCtrler.delegate = self;
    }
    return _imgPickerCtrler;
}

- (IBAction)pickerImage:(id)sender {
    // 通过摄像头采集
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imgPickerCtrler.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else { // 通过图片库采集
        self.imgPickerCtrler.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:self.imgPickerCtrler animated:YES completion:nil];
}
// 完成多媒体采集的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *type = info[UIImagePickerControllerMediaType];
    if ([type isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        _imageView.image = image;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
// 取消图片采集的回调
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"取消图片采集");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
