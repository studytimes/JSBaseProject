//
//  GlobalNoNetWorkTipsView.m
//  AnpaiPrecision
//
//  Created by jiangshuai on 2019/1/8.
//  Copyright © 2019 AnPai. All rights reserved.
//

#import "GlobalNoNetWorkTipsView.h"

@implementation GlobalNoNetWorkTipsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor] ;
    self.tryAgainBut.layer.borderWidth = 0.5 ;
    self.tryAgainBut.layer.borderColor = [UIColor blueColor].CGColor ;
    [self.tryAgainBut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal]; ;

}

- (IBAction)tryAgainButClick:(id)sender {
    
    self.tryAgainBlock();
    
}

@end
