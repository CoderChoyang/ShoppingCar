//
//  CYBottomView.m
//  ShoppingCar
//
//  Created by 刘崇阳 on 2016/11/21.
//  Copyright © 2016年 WKBP. All rights reserved.
//

#import "CYBottomView.h"
@interface CYBottomView()
@property (weak, nonatomic) IBOutlet UIButton *selectAllBtn;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) id <CYBottomViewDelegate> delegate;
@end
@implementation CYBottomView

+ (instancetype)bottomViewWithDelegate:(id)delegate {
	
	CYBottomView *bottomView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CYBottomView class]) owner:nil options:nil] lastObject];
	bottomView.delegate = delegate;
	return bottomView;
}
- (IBAction)selectAll:(UIButton *)sender {
	sender.selected = !sender.selected;
	if ([self.delegate respondsToSelector:@selector(selectAllClickWithBottomView:)]) {
		[self.delegate selectAllClickWithBottomView:self];
	}
}
@end
