//
//  BaseFunctionViewController.m
//  JSBaseProject
//
//  Created by Mini on 2020/12/30.
//

#import "BaseFunctionViewController.h"

#import "LikeStockViewController.h"

@interface BaseFunctionViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *baseTabView ;

@property (nonatomic, strong) NSMutableArray *funNameArr ;

@end

@implementation BaseFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.baseTabView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.baseTabView.dataSource = self ;
    self.baseTabView.delegate = self ;
    self.baseTabView.frame = CGRectMake(0, MAINNAVHEIGHT, SCREEN_WIDTH, GLOBALSUBHEIGHT) ;
    [self.view addSubview:self.baseTabView];
    
    [self.baseTabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"JSFunctionTableCellidentifier"];
    
    [self.view addSubview:self.baseTabView];
    
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JSFunctionTableCellidentifier" forIndexPath:indexPath] ;
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    NSArray *tmparr = self.funNameArr[indexPath.section] ;
    cell.textLabel.text = tmparr[indexPath.row] ;
    
    return cell ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.funNameArr.count ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *tmparr = self.funNameArr[section] ;
    return tmparr.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
        LikeStockViewController *stockvc = [[LikeStockViewController alloc] init];
        [self.navigationController pushViewController:stockvc animated:YES];
    } else {
        return ;
    }
}

#pragma mark -- Lazy Load
- (NSMutableArray *)funNameArr {
    if (!_funNameArr) {
        _funNameArr = [NSMutableArray arrayWithArray:@[@[@"自定义AVPlayer",@""],
                                                       @[@"仿股票",@""],
                                                       @[@"",@""]
        ]] ;
    }
    return _funNameArr;
}

 
@end
