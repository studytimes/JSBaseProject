//
//  BrowerImageView.m
//  AnpaiPrecision
//
//  Created by Anpai on 2019/1/15.
//  Copyright © 2019 AnPai. All rights reserved.
//

#import "BrowerImageView.h"

@interface BrowerImageView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *centerScrollerview;

@property (nonatomic, strong) UIImageView *centerimageview ;


@end

@implementation BrowerImageView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.centerScrollerview.frame = CGRectMake(0, 0, frame.size.width, frame.size.height) ;
        self.centerimageview.frame= CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        [self configureSubViews];
        
    }
    return self ;
}

- (void)configureSubViews {
    
    [self addSubview:self.centerScrollerview];
    self.centerScrollerview.delegate = self ;
    [self.centerScrollerview addSubview:self.centerimageview];
    
    
}


- (void)startLoadimage {
//    NSLog(@"%@",self.imageurlstr);
    
    [ self.centerimageview  sd_setImageWithURL:[NSURL URLWithString:self.imageurlstr] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        self.centerimageview.image = image ;
        [self adjustFrame];
        
    }];
    
}


- (void)adjustFrame {
    CGRect frame = self.frame;
    //   NSLog(@"%@",NSStringFromCGRect(self.frame));
    if (self.centerimageview.image) {
        CGSize imageSize = self.centerimageview.image.size;//获得图片的size
        CGRect imageFrame = CGRectMake(0, 0, imageSize.width, imageSize.height);
        
        //图片宽度始终==屏幕宽度
        CGFloat ratio = frame.size.width/imageFrame.size.width;
        imageFrame.size.height = imageFrame.size.height*ratio;
        imageFrame.size.width = frame.size.width;
        
        self.centerimageview.frame = imageFrame;
        self.centerScrollerview.contentSize = self.centerimageview.frame.size;
        self.centerimageview.center = [self centerOfScrollViewContent:self.centerScrollerview];
        //初始化
        self.centerScrollerview.minimumZoomScale = 0.7 ;
        self.centerScrollerview.maximumZoomScale = 3.0 ;
        self.centerScrollerview.zoomScale = 0.8 ;
    } else{
        frame.origin = CGPointZero;
        self.centerimageview.frame = frame;
        //重置内容大小
        self.centerScrollerview.contentSize = self.centerimageview.frame.size;
    }
    self.centerScrollerview.contentOffset = CGPointZero;
    //    self.zoomImageSize = self.imageview.frame.size;
    
}

- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                       scrollView.contentSize.height * 0.5 + offsetY);
    return actualCenter;
}

#pragma mark -- UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.centerimageview ;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView //这里是缩放进行时调整
{
    self.centerimageview.center = [self centerOfScrollViewContent:self.centerScrollerview];
}

#pragma mark -- Lazy Load
- (UIScrollView *)centerScrollerview {
    if (!_centerScrollerview) {
        _centerScrollerview = [[UIScrollView alloc] init];
        _centerScrollerview.showsVerticalScrollIndicator = NO ;
        _centerScrollerview.showsHorizontalScrollIndicator = NO ;
    }
    return _centerScrollerview ;
}

- (UIImageView *)centerimageview {
    if (!_centerimageview) {
        _centerimageview  = [[UIImageView alloc] init];
    }
    return _centerimageview ;
}


- (void)setNativeImage:(UIImage *)nativeImage {
    if (_nativeImage != nativeImage) {
        _nativeImage = nativeImage ;
    }
    self.centerimageview.image = nativeImage ;
    [self adjustFrame];
}

@end

