//
//  JSSingleLikeStockTabCell.m
//  JSBaseProject
//
//  Created by Mini on 2022/1/12.
//

#import "JSSingleLikeStockTabCell.h"

#import "JSStockLeftNameTabCell.h"
#import "JSStockRightContentTabCell.h"

@interface JSSingleLikeStockTabCell () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *leftTab ;

@property (nonatomic, strong) UITableView *rightTab ;

@property (nonatomic, strong) UIScrollView *rightStockView ;

@end

@implementation JSSingleLikeStockTabCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ;
    if (self) {
        [self configureSubViews] ;
    }
    return self ;
}

- (void)configureSubViews {
    
    [self.contentView addSubview:self.leftTab];
    [self.contentView addSubview:self.rightStockView];
    [self.rightStockView addSubview:self.rightTab] ;
    
    [self.leftTab registerNib:[UINib nibWithNibName:@"JSStockLeftNameTabCell" bundle:nil] forCellReuseIdentifier:@"JSStockLeftNameTabCellidentifier"];
    [self.rightTab registerNib:[UINib nibWithNibName:@"JSStockRightContentTabCell" bundle:nil] forCellReuseIdentifier:@"JSStockRightContentTabCellidentifier"];
    
    
    [self layoutIfNeeded];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTab) {
        JSStockLeftNameTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JSStockLeftNameTabCellidentifier" forIndexPath:indexPath] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        return cell ;

    } else if (tableView == self.rightTab) {
        JSStockRightContentTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JSStockRightContentTabCellidentifier" forIndexPath:indexPath] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        return cell ;
    } else {
        return nil ;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}



- (UITableView *)leftTab {
    if (!_leftTab) {
        _leftTab = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTab.delegate = self ;
        _leftTab.dataSource = self ;
    }
    return _leftTab ;
}


- (UITableView *)rightTab {
    if (!_rightTab) {
        _rightTab =  [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _rightTab.dataSource = self ;
        _rightTab.delegate = self ;
        _rightTab.scrollEnabled = NO ;
    }
    return _rightTab ;
}

- (UIScrollView *)rightStockView {
    if (!_rightStockView) {
        _rightStockView = [[UIScrollView alloc] init];
    }
    return _rightStockView ;
}


- (void)layoutSubviews {
    
    self.leftTab.frame = CGRectMake(0, 0, 120, 20*50) ;
    self.rightTab.frame = CGRectMake(0,0,SCREEN_WIDTH,20*50) ;
    self.rightStockView.frame = CGRectMake(120,0,SCREEN_WIDTH-120,20*50) ;
    self.rightStockView.contentSize = CGSizeMake(SCREEN_WIDTH, 20*50) ;
    
}


@end
