//
//  JSCommonAVPlayer.m
//  JSBaseProject
//
//  Created by Mini on 2021/4/6.
//

#import "JSCommonAVPlayer.h"
#import <AVKit/AVKit.h>

@interface JSCommonAVPlayer ()

@property (nonatomic, strong) UIButton *backBut ;

@property (nonatomic, strong) UIView *videoBgView ;
/**播放器载体 */
@property (nonatomic, strong) UIView *videoContainView ;
/**播放器操作界面 */
@property (nonatomic, strong) UIView *videoCoverView ;
/**底部工具栏*/
@property (nonatomic, strong) UIView *bottomToolView ;

@property (nonatomic, strong) UIImageView *playStateImageView ;
/**已经播放时间*/
@property (nonatomic, strong) UILabel *playTimeLabel ;
/**进度滑杆*/
@property (nonatomic, strong) UISlider *videoSlider ;
/**剩余时间 */
@property (nonatomic, strong) UILabel *residueTimeLabel ;
/**全屏播放*/
@property (nonatomic, strong) UIButton *fullScreenBut ;

@property (nonatomic, strong) id AVPlayerTimeObserver ;
/**视频播放要素 */
@property (nonatomic, strong) AVPlayer *avPlayer ;

@property (nonatomic, strong) AVPlayerItem * avPlayerItem;

@property (nonatomic, strong) AVPlayerLayer * avPlayerLayer;

@property (nonatomic, assign) BOOL isPlaying ;

@property (nonatomic, assign) BOOL isEnd ;

@property (nonatomic, strong) UIView *fatherView ;

@property (nonatomic, assign) CGRect originFrame ;


@end

@implementation JSCommonAVPlayer

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    self = [super init] ;
    if (self) {
        
    }
    return self ;
}


- (void)configureSubViews {
    
}

@end
