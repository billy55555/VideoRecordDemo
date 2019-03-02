//
//  PlayerVC.m
//  VideoRecordDemo
//
//  Created by 邻汇吧 on 2019/2/20.
//  Copyright © 2019年 邻汇吧. All rights reserved.
//

#import "PlayerVC.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

@interface PlayerVC ()<AVPlayerViewControllerDelegate>
@property(nonatomic,strong) UIButton *cancelBtn;
@property(nonatomic,strong) UIButton *playBtn;

@property (nonatomic,strong)AVPlayerViewController * PlayerVC;
@end

@implementation PlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"播放器";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.cancelBtn];
    [self.view addSubview:self.playBtn];
//    [self doPlay];
    
    [self.view addSubview:self.PlayerVC.view];
}

- (AVPlayerViewController *)PlayerVC {
    if (!_PlayerVC) {
        AVPlayerViewController *playerVC = [[AVPlayerViewController alloc] init];
        AVPlayer *player = [AVPlayer playerWithURL:self.url];
        playerVC.player = player;
        //    playerVC.view.frame = self.view.frame;
        playerVC.view.frame = CGRectMake(0, 200, KWidth, 300);
        playerVC.delegate = self;
        playerVC.showsPlaybackControls = YES;
        
        _PlayerVC = playerVC;
    }
    return _PlayerVC;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.frame = CGRectMake(0, 20, 50, 44);
        _cancelBtn.backgroundColor = [UIColor grayColor];
        [_cancelBtn addTarget:self action:@selector(didClickCancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_playBtn setTitle:@"播放" forState:UIControlStateNormal];
        _playBtn.frame = CGRectMake(KWidth-50, 20, 50, 44);
        _playBtn.backgroundColor = [UIColor grayColor];
        [_playBtn addTarget:self action:@selector(didClickPlay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (void)didClickCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didClickPlay {
    [self.PlayerVC.player play];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - AVPlayerViewControllerDelegate

@end
