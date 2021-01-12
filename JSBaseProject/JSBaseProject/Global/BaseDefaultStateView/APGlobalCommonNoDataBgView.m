//
//  APGlobalCommonNoDataBgView.m
//  AnpaiPrecision
//
//  Created by jiangshuai on 2019/12/30.
//  Copyright © 2019 AnPai. All rights reserved.
//

#import "APGlobalCommonNoDataBgView.h"

@interface APGlobalCommonNoDataBgView ()


@end

@implementation APGlobalCommonNoDataBgView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configureSubViews] ;
    }
    return self ;
}

- (void)configureSubViews {
    
    self.noimageview = [[UIImageView alloc] init];
    self.noimageview.contentMode = UIViewContentModeCenter ;
    [self addSubview:self.noimageview];
    self.noimageview.image = [UIImage imageNamed:@"global_nodatabg"] ;
    
    self.noTipsLabel = [[UILabel alloc] init];
    [self addSubview:self.noTipsLabel];
    self.noTipsLabel.textAlignment = NSTextAlignmentCenter ;
    self.noTipsLabel.textColor = [UIColor colorWithHex:0x666666];
    self.noTipsLabel.font = [UIFont systemFontOfSize:12.0] ;
    self.noTipsLabel.text = @"暂无数据" ;

    
    [self.noimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.mas_left).offset(15.0);
        make.right.equalTo(self.mas_right).offset(-15.0);
        make.bottom.equalTo(self.noTipsLabel.mas_top) ;
    }];
    
    
    [self.noTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(30);
    }];
    

}

@end
