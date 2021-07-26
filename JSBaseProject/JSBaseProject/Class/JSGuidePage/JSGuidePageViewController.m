//
//  JSGuidePageViewController.m
//  JSBaseProject
//
//  Created by Mini on 2021/4/20.
//

#import "JSGuidePageViewController.h"

@interface JSGuidePageViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *pageColView ;

@end

@implementation JSGuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.view addSubview:self.pageColView];
    self.pageColView.dataSource = self ;
    self.pageColView.delegate = self ;
    
}


#pragma mark -- UICollectionViewDataSource,UICollectionViewDelegate
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil ;

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2 ;
}



#pragma mark -- Lazy Load
- (UICollectionView *)pageColView {
    if (!_pageColView) {
        
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal ;
        
        _pageColView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, MAINNAVHEIGHT, SCREEN_WIDTH, GLOBALSUBHEIGHT) collectionViewLayout:flowlayout];
        _pageColView.pagingEnabled = YES ;
    }
    return _pageColView ;
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
