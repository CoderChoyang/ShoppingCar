//
//  CYRootCell.m
//  ShoppingCar
//
//  Created by 刘崇阳 on 2016/11/21.
//  Copyright © 2016年 WKBP. All rights reserved.
//

#import "CYRootCell.h"
@interface CYRootCell()
@property (weak, nonatomic)   IBOutlet UIButton *subShopCountBtn;
@property (weak, nonatomic)   IBOutlet UILabel *priceLabel;
@property (weak, nonatomic)   IBOutlet UILabel *shopCountLabel;
@property (weak, nonatomic)   IBOutlet UIImageView *shopImageView;
@property (assign, nonatomic) BOOL isCountOne;
@property (weak, nonatomic)   IBOutlet UIButton *selectShopBtn;
@property (weak, nonatomic)   id <CYRootCellDelate> delegate;
@end
@implementation CYRootCell
- (void)awakeFromNib {
	[super awakeFromNib];
	self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setIsCountOne:(BOOL)isCountOne {
	
	if (isCountOne) {
		[_subShopCountBtn setBackgroundColor:[UIColor orangeColor]];
		_subShopCountBtn.enabled = YES;
	} else {
		[_subShopCountBtn setBackgroundColor:[UIColor grayColor]];
		_subShopCountBtn.enabled = NO;
	}
}
+ (instancetype)rootCellWithTableView:(UITableView *)tableView
							 delegate:(id)delegate
							indexPath:(NSIndexPath *)indexPath {
	//	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	CYRootCell *cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CYRootCell class]) owner:nil options:nil] lastObject];
	cell.delegate = delegate;
	cell.indexPath = indexPath;
	return cell;
}
- (void)setDataDict:(NSDictionary *)dataDict {
	
	self.priceLabel.text = [((NSNumber *)[dataDict objectForKey:@"price"]) stringValue];
	NSInteger shopCount = [((NSNumber *)[dataDict objectForKey:@"count"]) integerValue];
	self.shopCountLabel.text = [@(shopCount) stringValue];
	// 商品数量最少为1
	if (shopCount == 1) {
		self.isCountOne = NO;
	}
	self.isSelectShop = [((NSNumber *)[dataDict objectForKey:@"select"]) boolValue];
//	CYLog(@"%d",self.isSelectShop);
	// 把请求下来的状态赋给cell上的选择商品按钮
	if (self.isSelectShop) {
		self.selectShopBtn.selected = YES;
	} else {
		self.selectShopBtn.selected = NO;
	}
}

- (IBAction)select:(UIButton *)sender {
	// 在xib中做好了button的切换状态对应的不同图片
	sender.selected = !sender.selected;
	// 将状态传到cell上
	self.isSelectShop = sender.selected;
	if ([self.delegate respondsToSelector:@selector(selectShopButtonClickWithCell:)]) {
		[self.delegate selectShopButtonClickWithCell:self];
	}
}

- (IBAction)addShopCount:(UIButton *)sender {
	self.isCountOne = YES;
	if ([self.delegate respondsToSelector:@selector(addButtonClickWithCell:)]) {
		[self.delegate addButtonClickWithCell:self];
	}
}

- (IBAction)subShopCount:(UIButton *)sender {

	if ([self.delegate respondsToSelector:@selector(subButtonClickWithCell:)]) {
		[self.delegate subButtonClickWithCell:self];
	}
}
@end
