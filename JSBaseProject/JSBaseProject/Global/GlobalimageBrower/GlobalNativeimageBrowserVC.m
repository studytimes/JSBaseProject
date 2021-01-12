//
//  GlobalNativeimageBrowserVC.m
//  AnpaiPrecision
//
//  Created by Anpai on 2019/3/12.
//  Copyright © 2019 AnPai. All rights reserved.
//

#import "GlobalNativeimageBrowserVC.h"
#import "BrowerImageView.h"

@interface GlobalNativeimageBrowserVC () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *topIndexLabel ;

@property (nonatomic, strong) UIButton *closeBut ;

@property (nonatomic, strong) UIButton *saveBut ;


@end

@implementation GlobalNativeimageBrowserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureSubViews];
}

- (void)configureSubViews {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, MAINSTATUSHEIGHT, SCREEN_WIDTH, GLOBALSUBHEIGHT)];
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
    NSInteger totalimageCount = 0 ;
    if (self.imageUrlGroupArr.count > 0) {
        totalimageCount = self.imageUrlGroupArr.count ;
        for (int i = 0; i < self.imageUrlGroupArr.count; i++) {
            BrowerImageView *view = [[BrowerImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, GLOBALSUBHEIGHT)];
            //        view.isFullWidthForLandScape = self.isFullWidthForLandScape;
            //        view.imageview.tag = i;
            view.imageurlstr = [self.imageUrlGroupArr objectAtIndex:i];
            [view startLoadimage];
            [self.scrollView addSubview:view];
        }
        
    } else if (self.nativeImageGroupArr.count > 0) {
        totalimageCount = self.nativeImageGroupArr.count ;
        for (int i = 0; i < self.nativeImageGroupArr.count; i++) {
            BrowerImageView *view = [[BrowerImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, GLOBALSUBHEIGHT)];
            view.nativeImage = self.nativeImageGroupArr[i];
            [self.scrollView addSubview:view];
        }
    } else {
        NSLog(@"全局浏览图片框架图片数组为空");
    }
    //    [self setupImageOfImageViewForIndex:self.currentImageIndex];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * totalimageCount, GLOBALSUBHEIGHT) ;
    
    self.topIndexLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 120)/2, MAINSTATUSHEIGHT, 120.0, 24.0)];
    self.topIndexLabel.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    self.topIndexLabel.textAlignment = NSTextAlignmentCenter ;
    self.topIndexLabel.textColor = [UIColor colorWithHex:FirstTextColor];
    self.topIndexLabel.font = [UIFont boldSystemFontOfSize:20.0] ;
    if (self.startTag>0) {
        self.topIndexLabel.text = [NSString stringWithFormat:@"%d/%d",self.startTag+1,totalimageCount];
        [self.scrollView scrollRectToVisible:CGRectMake(self.startTag * SCREEN_WIDTH, 0, SCREEN_WIDTH, GLOBALSUBHEIGHT) animated:NO];
    }
    [self.view addSubview:self.topIndexLabel];

    self.topIndexLabel.hidden = totalimageCount == 1 ;
    
    self.closeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBut.frame = CGRectMake(16.0, MAINSTATUSHEIGHT, 48, 48);
    self.closeBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
    [self.closeBut setImage:[UIImage imageNamed:@"login_icon_cancel"] forState:UIControlStateNormal];
    [self.closeBut addTarget:self action:@selector(closeToRoot) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeBut];
    
    self.saveBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveBut.frame = CGRectMake(SCREEN_WIDTH-80.0, SCREEN_HEIGHT - 42.0 - ADJUSBOTHEIGHT - MAINSTATUSHEIGHT, 60.0, 32.0);
    [self.saveBut setTitle:@"保存" forState:UIControlStateNormal];
    self.saveBut.layer.cornerRadius = 4.0 ;
    self.saveBut.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    self.saveBut.hidden = !self.isShowSaveBut ;
    [self.saveBut addTarget:self action:@selector(saveNowImageToAlbum) forControlEvents:UIControlEventTouchUpInside];
    self.saveBut.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    [self.view addSubview:self.saveBut];
    
}


- (void)closeToRoot {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -- 保存当前图片
- (void)saveNowImageToAlbum {
    int autualIndex = self.scrollView.contentOffset.x / SCREEN_WIDTH;
    if (autualIndex < self.nativeImageGroupArr.count) {
        UIImage *tmpimage = self.nativeImageGroupArr[autualIndex];
        if(tmpimage) {
            UIImageWriteToSavedPhotosAlbum(tmpimage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        } else {
            [GlobalUITools showMessage:@"图片资源有误" withView:self.view];
        }
    } else {
        return ;
    }

//    [[SDWebImageDownloader sharedDownloader]
//     downloadImageWithURL:tmpimgurl
//     options:0
//     progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//
//     } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//         if (error) {
//             [GlobalUITools showMessage:[error description] withView:self.view];
//         } else {
//         }
//     }];

    
}

//保存图片完成之后的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    if (error != NULL) {
        [GlobalUITools showMessage:@"图片保存失败" withView:self.view];
    } else   {
        // Show message image successfully saved
        [GlobalUITools showMessage:@"图片保存成功" withView:self.view];
    }
}


#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int autualIndex = scrollView.contentOffset.x  / SCREEN_WIDTH;
    //设置当前下标
    //    self.currentImageIndex = autualIndex;
    self.topIndexLabel.text = [NSString stringWithFormat:@"%d/%d",autualIndex+1,self.imageUrlGroupArr.count];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
