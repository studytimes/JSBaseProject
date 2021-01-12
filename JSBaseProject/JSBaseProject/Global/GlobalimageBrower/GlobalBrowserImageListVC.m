//
//  GlobalBrowserImageListVC.m
//  AnpaiPrecision
//
//  Created by Anpai on 2019/1/14.
//  Copyright © 2019 AnPai. All rights reserved.
//

#import "GlobalBrowserImageListVC.h"

#import "BrowerImageView.h"

#import <SDWebImageDownloader.h>


@interface GlobalBrowserImageListVC () <UIScrollViewDelegate>
{
    float imgHeight ;
}

@property (nonatomic, strong)  UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *topIndexLabel ;

@property (nonatomic, strong) UIButton *topBackBut ;

@end

@implementation GlobalBrowserImageListVC


- (instancetype)init {
    self = [super init];
    if (self) {
        [self configureSubViews];
    }
    return self ;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated] ;
    self.navigationController.navigationBarHidden = YES ;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated] ;
    self.navigationController.navigationBarHidden = NO ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)configureSubViews {
    
    self.automaticallyAdjustsScrollViewInsets = NO ;
    
    imgHeight = SCREEN_HEIGHT ;
    self.view.backgroundColor = [UIColor colorWithHex:FirstTextColor];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, imgHeight)];
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    self.topIndexLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, SCREEN_HEIGHT - MAINTABHEIGHT, 80.0, 24.0)];
    self.topIndexLabel.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    self.topIndexLabel.textAlignment = NSTextAlignmentCenter ;
    self.topIndexLabel.textColor = [UIColor whiteColor];
    self.topIndexLabel.font = [UIFont boldSystemFontOfSize:20.0] ;

    [self.view addSubview:self.topIndexLabel];
    
    self.topIndexLabel.hidden = YES;
    
    self.topBackBut = [UIButton buttonWithType:UIButtonTypeCustom] ;
    self.topBackBut.frame = CGRectMake(15, MAINSTATUSHEIGHT, 44, 44) ;
    self.topBackBut.adjustsImageWhenHighlighted = NO ;
    self.topBackBut.backgroundColor = [UIColor clearColor] ;
    self.topBackBut.adjustsImageWhenHighlighted = NO ;
    [self.topBackBut setImage:[UIImage imageNamed:@"main_nav_whiteback"] forState:UIControlStateNormal];
    self.topBackBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
    [self.topBackBut addTarget:self action:@selector(topBackButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.topBackBut];
    
    self.saveBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveBut.frame = CGRectMake(SCREEN_WIDTH- 80 , GLOBALSUBHEIGHT - MAINTABHEIGHT, 60, 30);
    [self.saveBut setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBut addTarget:self action:@selector(saveButClick) forControlEvents:UIControlEventTouchUpInside];
    self.saveBut.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
//    self.saveBut.textColor = [UIColor whiteColor];
    [self.view addSubview:self.saveBut];
    
}


- (void)topBackButClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int autualIndex = scrollView.contentOffset.x  / SCREEN_WIDTH;
    //设置当前下标
    self.topIndexLabel.text = [NSString stringWithFormat:@"%d/%d",autualIndex+1,self.imageUrlGroupArr.count];

}



#pragma mark -- 保存图片到本地
- (void)saveButClick {
    
    NSInteger autualIndex = self.scrollView.contentOffset.x  / SCREEN_WIDTH;
    if (autualIndex<self.imageUrlGroupArr.count) {
        NSString *tmpurl = [NSString stringWithFormat:@"%@",self.imageUrlGroupArr[autualIndex]];
        if ([GlobalMethodsTools Object_IsNotBlank:tmpurl]) {
            NSURL *imgUrl = [NSURL URLWithString:tmpurl] ;
                    
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:imgUrl options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {

            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                if (finished) {
                    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
                }

            }] ;
        }

    }
    
    

    

}

#pragma mark -- <保存到相册>
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if(error){
//        msg = @"保存图片失败" ;
        [GlobalUITools showMessage:@"图片保存失败" withView:self.view] ;
    }else{
//        msg = @"保存图片成功" ;
        [GlobalUITools showMessage:@"图片保存成功" withView:self.view] ;
    }
}


- (void)setImageUrlGroupArr:(NSMutableArray *)imageUrlGroupArr {
    _imageUrlGroupArr = imageUrlGroupArr ;
    NSInteger totalimageCount = 0 ;
    if (imageUrlGroupArr.count > 0) {
        totalimageCount = imageUrlGroupArr.count ;
        for (int i = 0; i < imageUrlGroupArr.count; i++) {
            BrowerImageView *view = [[BrowerImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, imgHeight)];
            view.imageurlstr = [imageUrlGroupArr objectAtIndex:i];
            [view startLoadimage];
            [self.scrollView addSubview:view];
        }
    } else {
        NSLog(@"全局浏览图片框架图片数组为空");
    }
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * totalimageCount, GLOBALSUBHEIGHT) ;
    self.topIndexLabel.hidden = totalimageCount == 1 ;
    self.topIndexLabel.text = [NSString stringWithFormat:@"%d/%d",self.startTag+1,totalimageCount];

}

- (void)setStartTag:(NSInteger)startTag {
    _startTag = startTag ;
    
    self.topIndexLabel.text = [NSString stringWithFormat:@"%d/%d",startTag+1,self.imageUrlGroupArr.count];
    [self.scrollView setContentOffset:CGPointMake(startTag*SCREEN_WIDTH, 0)];
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
