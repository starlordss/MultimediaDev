//
//  ViewController.m
//  AudioPicker
//
//  Created by Zahi on 2017/12/27.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
/**音频采集**/
@property (nonatomic, strong) AVAudioRecorder *recorder;
/**播放器**/
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation ViewController{
    // 录音存放路径
    NSURL *_URL;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)onRecordButton:(UIButton *)btn {
    
    [self.recorder record];
    if (btn.isSelected == NO) {
        // 开始录音
        [self.recorder record];
        btn.selected = YES;
    } else {
        // 停止录音
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
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:_URL error:nil];
        // 准备播放
        [_player prepareToPlay];
    }
    return _player;
}


- (AVAudioRecorder *)recorder {
    if (!_recorder) {
        // 录音存放路径
        _URL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].lastObject URLByAppendingPathComponent:@"record"];
        NSLog(@"%@",_URL.absoluteString);
        // 录音设置
        NSDictionary *settings = @{
                                   // 录音格式: .aac
                                   AVFormatIDKey         : @(kAudioFormatMPEG4AAC),
                                   // 采样率: 44100MHz
                                   AVSampleRateKey       : @44100,
                                   // 录音通道: 单通道
                                   AVNumberOfChannelsKey : @1,
                                   // 录音质量: 高质量 注意这个不要写：会导致初始化不成功
                                   //AVEncoderBitRateKey   : @(AVAudioQualityHigh),
                                   // PCM位深: 8bit
                                   AVLinearPCMBitDepthKey: @(8)
                                };
        // 实例初始化音频采样
        NSError *error;
        _recorder = [[AVAudioRecorder alloc] initWithURL:_URL
                                                settings:settings
                                                   error:&error];

        // 准备录音
        [_recorder prepareToRecord];
    }
    return _recorder;
}
@end
