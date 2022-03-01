//
//  LikeStockViewController.m
//  JSBaseProject
//
//  Created by Mini on 2022/1/12.
//

#import "LikeStockViewController.h"

#import "JSSingleLikeStockTabCell.h"

@interface LikeStockViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *stockTab ;

@end

@implementation LikeStockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.cusNavView addSubview:self.cusNavLeftBut];
    self.stockTab = [[UITableView alloc] initWithFrame:CGRectMake(0, MAINNAVHEIGHT, SCREEN_WIDTH, GLOBALSUBHEIGHT)];
    self.stockTab.dataSource = self ;
    self.stockTab.delegate = self ;
    
    [self.view addSubview:self.stockTab] ;
    
//    [self.stockTab registerNib:[UINib nibWithNibName:@"JSSingleLikeStockTabCell" bundle:nil] forCellReuseIdentifier:@"JSSingleLikeStockTabCellidentifier"];
    [self.stockTab registerClass:[JSSingleLikeStockTabCell class] forCellReuseIdentifier:@"JSSingleLikeStockTabCellidentifier"];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JSSingleLikeStockTabCell *cell  ;
    if (cell == nil) {
        cell = [[JSSingleLikeStockTabCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JSSingleLikeStockTabCellidentifier"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    return cell ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 20*50 ;
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
