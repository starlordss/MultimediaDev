//
//  ViewController.m
//  VideoPicker
//
//  Created by Zahi on 2017/12/27.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/**视频录制**/
@property (nonatomic, strong) UIImagePickerController *imgPicker;
/**视频播放**/
@property (nonatomic, strong) AVPlayerViewController *playerVC;
@end

@implementation ViewController{
    NSURL *_videoURL;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)onStartButton:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self presentViewController:self.imgPicker animated:YES completion:nil];
    }
}

- (IBAction)onPlayButton:(id)sender {
    [self.playerVC.player play];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *type = info[UIImagePickerControllerMediaType];
    if ([type isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
        _videoURL =info[UIImagePickerControllerMediaURL];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"取消选中图片");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (AVPlayerViewController *)playerVC
{
    if (_playerVC == nil) {
        _playerVC = [[AVPlayerViewController alloc] init];
        _playerVC.player = [[AVPlayer alloc] initWithURL:_videoURL];
        [self presentViewController:_playerVC animated:YES completion:nil];
    }
    return _playerVC;
}

- (UIImagePickerController *)imgPicker
{
    if (_imgPicker == nil) {
        _imgPicker = [[UIImagePickerController alloc] init];
        _imgPicker.mediaTypes = @[(__bridge NSString *)kUTTypeMovie];
        _imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imgPicker.delegate = self;
        _imgPicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }
    return _imgPicker;
}

@end
