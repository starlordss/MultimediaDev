//
//  ViewController.m
//  AudioPicker
//
//  Created by Zahi on 2017/12/27.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
/**音频采集**/
@property (nonatomic, strong) AVAudioRecorder *recorder;
/**播放器**/
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)onStartButton:(id)sender {
}
- (IBAction)onRecordButton:(UIButton *)btn {
    if (btn.isSelected == NO) { // 开始录音
        [self.recorder record];
        btn.selected = YES;
    } else { // 停止录音
        [self.recorder stop];
        btn.selected = NO;
    }
}
- (IBAction)onPlayButton:(UIButton *)btn {
    [self.player play];
}

- (AVAudioPlayer *)player
{
    if (!_player) {

        NSURL *URL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].lastObject URLByAppendingPathComponent:@"record"];
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:URL error:nil];
        // 准备播放
        [_player prepareToPlay];
    }
    return _player;
}


- (AVAudioRecorder *)recorder {
    if (!_recorder) {
        // 录音存放路径
        NSURL *URL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].lastObject URLByAppendingPathComponent:@"record"];
        // 录音设置
        NSDictionary *settings = @{
                                   // 采样率
                                   AVSampleRateKey       : @44100,
                                   // 录音格式
                                   AVFormatIDKey         : @(kAudioFormatMPEG4AAC),
                                   // 录音通道
                                   AVNumberOfChannelsKey : @1,
                                   // 录音质量
                                   AVEncoderBitRateKey   : @(AVAudioQualityHigh)
                                };
        // 实例初始化音频采样
        _recorder = [[AVAudioRecorder alloc] initWithURL:URL
                                                settings:settings
                                                   error:nil];
        // 准备录音
        [_recorder prepareToRecord];
    }
    return _recorder;
}
@end
