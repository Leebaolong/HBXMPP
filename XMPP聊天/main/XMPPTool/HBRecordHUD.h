//
//  HBRecordHUD.h
//  XMPP_Chat
//
//  Created by 伍宏彬 on 16/6/23.
//  Copyright © 2016年 Wow_我了个去. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,recordStatus) {
    
    recordStatusNormal,
    recordStatusFaile

};
typedef void(^playCompletionBlcok)(BOOL finished);
typedef void(^beginPlayBlcok)();
typedef void(^recordTimeBlcok)(NSTimeInterval time);

@interface HBRecordHUD : NSObject
+ (instancetype)shareRecordHUD;

#pragma mark - 录音相关
- (void)starRecord;
- (void)stopRecord;
#pragma mark - 播放相关
- (void)playLocalMusicFileURL:(NSURL *)localURL beginPlay:(beginPlayBlcok)beginPlay completion:(playCompletionBlcok)completion;
- (void)stopPlay;
#pragma mark - 展示当前状态
- (void)showRecordingImageNames:(NSArray *)recordingNames;
- (void)showFailRecordImageName:(NSString *)failName;
- (void)showShortTimeImageName:(NSString *)shortName;
- (void)hideCorver;
#pragma mark - 其他
- (void)recordTime:(recordTimeBlcok)time;
- (NSString *)lastVoicePath;
- (NSTimeInterval)lastVoiceLengthTime;
@end
