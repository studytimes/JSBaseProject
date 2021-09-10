//
//  JSCustomDifPageColView.m
//  IntelligentCoffee
//
//  Created by Mini on 2021/6/1.
//

#import "JSCustomDifPageColView.h"

#import "JSCustomDifPageColCell.h"

static NSString *JSCustomDifPageColCellidentifier = @"JSCustomDifPageColCell" ;

@interface JSCustomDifPageColView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *pageColView ;

@end

@implementation JSCustomDifPageColView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame] ;
    if (self) {
        self.userInteractionEnabled = NO ;
        [self initialization];
        [self configureSubViews] ;
    }
    return self ;
}

- (void)initialization {
    
    _currentDotSize = CGSizeMake(self.frame.size.height*2, self.frame.size.height) ;
    _normalDotSize = CGSizeMake(self.frame.size.height, self.frame.size.height) ;
    _currentDotColor = [UIColor whiteColor] ;
    _normalDotColor = [UIColor colorWithWhite:1.0 alpha:0.7] ;
    _innerSpace = 10.0 ;
    
    self.backgroundColor = [UIColor clearColor] ;
    
}

- (void)configureSubViews {
    [self addSubview:self.pageColView];
    self.pageColView.backgroundColor = [UIColor clearColor] ;
    self.pageColView.dataSource = self ;
    self.pageColView.delegate = self ;
    [self.pageColView registerNib:[UINib nibWithNibName:@"JSCustomDifPageColCell" bundle:nil] forCellWithReuseIdentifier:JSCustomDifPageColCellidentifier];
}


#pragma mark -- UICollectionViewDataSource,UICollectionViewDelegate
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JSCustomDifPageColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:JSCustomDifPageColCellidentifier forIndexPath:indexPath] ;
    if (indexPath.item == self.currentPage) {
        if (self.currentDotImage) {
            cell.dotImageView.image = self.currentDotImage ;
        } else {
            cell.dotImageView.image = nil ;
            cell.dotImageView.layer.cornerRadius = ceil(self.frame.size.height/2.0) ;
            cell.dotImageView.backgroundColor = self.currentDotColor ;
        }
    } else {
        if (self.normalDotImage) {
            cell.dotImageView.image = self.normalDotImage ;
        } else {
            cell.dotImageView.image = nil ;
            cell.dotImageView.layer.cornerRadius = ceil(self.frame.size.height/2.0) ;
            cell.dotImageView.backgroundColor = self.normalDotColor ;
        }

    }
    return cell ;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.totalPage ;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == self.currentPage) {
        return self.currentDotSize ;
    } else {
        return self.normalDotSize ;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero ;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return self.innerSpace ;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return self.innerSpace ;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return ;
}

- (void)setTotalPage:(NSInteger)totalPage {
    
    _totalPage = totalPage ;
    float totalWidth;
    float totalHeight = self.frame.size.height ;
    if (totalPage == 1) {
        totalWidth = 10.0;
    } else {
        totalWidth = self.currentDotSize.width + (totalPage -1) * (self.normalDotSize.width + self.innerSpace ) ;
    }
    self.pageColView.bounds = CGRectMake(0, 0, totalWidth, totalHeight) ;
    self.pageColView.center = CGPointMake(self.frame.size.width/2, totalHeight/2);
    [self.pageColView reloadData] ;

}

- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage ;
    [self.pageColView reloadData] ;
    
}

#pragma mark -- Lazy Load
- (UICollectionView *)pageColView {
    if (!_pageColView) {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal ;
        _pageColView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
        _pageColView.showsHorizontalScrollIndicator = NO ;

    }
    return _pageColView ;
}

@end
