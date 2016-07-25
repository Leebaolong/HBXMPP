//
//  HBVoiceCell.m
//  XMPP_Chat
//
//  Created by 伍宏彬 on 15/12/18.
//  Copyright © 2015年 Wow_我了个去. All rights reserved.
//

#import "HBVoiceCell.h"
#import "HBRecordHUD.h"

@interface HBVoiceCell()
{
    NSUInteger _countNum;
}
/**
 *  波形显示器
 */
@property (nonatomic, strong) UIImageView *progressImageView;
/**
 *  时间标签
 */
@property (nonatomic, strong) UILabel * timeLable;
@property (nonatomic, strong) UIButton * playBtn;
@property (nonatomic, strong) NSTimer * time;
@end

@implementation HBVoiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.chatBg addSubview:self.playBtn];
        [self.contentView addSubview:self.progressImageView];
        [self.contentView addSubview:self.timeLable];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.progressImageView.HB_Size = CGSizeMake(22, 22);
    self.progressImageView.HB_centerY = self.chatBg.HB_centerY;
    
    if ([self.chatModel.message.outgoing boolValue]) {
        
        self.progressImageView.HB_X = CGRectGetMaxX(self.chatBg.frame) - self.progressImageView.HB_W - 10;
        self.timeLable.HB_centerY = self.chatBg.HB_centerY;
        self.timeLable.HB_X = self.chatBg.HB_X - self.timeLable.HB_W - 5;
        
    }else{
    
        self.progressImageView.HB_X = 15;
        self.timeLable.HB_centerY = self.chatBg.HB_centerY;
        self.timeLable.HB_X = CGRectGetMaxX(self.chatBg.frame) + 5;
        
    }
    
    self.playBtn.frame = self.chatBg.bounds;
    [self.playBtn setBackgroundImage:self.chatBg.image forState:normal];
}
#pragma mark - Method
- (void)setChatModel:(HBChatModel *)chatModel
{
    [super setChatModel:chatModel];
    
    if ([chatModel.message.outgoing boolValue]) {
        
        self.progressImageView.image = [UIImage imageNamed:@"bubble_voice_send_icon_3"];
        
    }else{
    
        self.progressImageView.image = [UIImage imageNamed:@"bubble_voice_receive_icon_3"];
       
    }
    
    self.timeLable.text = [NSString stringWithFormat:@"%@",self.chatModel.voiceTime];
    [self.timeLable sizeToFit];
}
- (void)playChick
{
    whbLog(@"播放录音撒，兄弟");
    [[HBRecordHUD shareRecordHUD] playLocalMusicFileURL:self.chatModel.voiceURL beginPlay:^{
        [self beginProgress];
    } completion:^(BOOL finished) {
        [self stopProgress];
    }];
}
- (void)beginProgress{
    
    [[NSRunLoop mainRunLoop] addTimer:self.time forMode:NSRunLoopCommonModes];
}
- (void)stopProgress{

    if (self.time) {
        [self.time invalidate];
        self.time = nil;
    }
    if ([self.chatModel.message.outgoing boolValue]) {
        
        self.progressImageView.image = [UIImage imageNamed:@"bubble_voice_send_icon_3"];
        
    }else{
        
        self.progressImageView.image = [UIImage imageNamed:@"bubble_voice_receive_icon_3"];
        
    }
}
- (void)timeBegin{
    
    _countNum += 1;
    
    if (_countNum == 4) {
        _countNum = 1;
    }
    
    if ([self.chatModel.message.outgoing boolValue]) {

        self.progressImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"bubble_voice_send_icon_%@",@(_countNum)]];
        
    }else{
        
        self.progressImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"bubble_voice_receive_icon_%@",@(_countNum)]];
        
    }
    
}
#pragma mark - getter
- (UIImageView *)progressImageView
{
    if (!_progressImageView) {
        _progressImageView = [[UIImageView alloc] init];
        _progressImageView.contentMode = UIViewContentModeCenter;
        _progressImageView.backgroundColor = [UIColor redColor];
        _progressImageView.userInteractionEnabled = YES;
    }
    return _progressImageView;
}
- (UILabel *)timeLable
{
    if (!_timeLable) {
        _timeLable = [[UILabel alloc] init];
//        _timeLable.backgroundColor = [UIColor redColor];
        
    }
    return _timeLable;
}
- (UIButton *)playBtn
{
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn addTarget:self action:@selector(playChick) forControlEvents:UIControlEventTouchUpInside];
        _playBtn.backgroundColor = [UIColor clearColor];
    }
    return _playBtn;
}
- (NSTimer *)time
{
    if (!_time) {
        _time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeBegin) userInfo:nil repeats:YES];
    }
    return _time;
}
@end
