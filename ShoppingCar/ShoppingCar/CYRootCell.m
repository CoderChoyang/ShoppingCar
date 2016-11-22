//
//  CYRootCell.m
//  ShoppingCar
//
//  Created by 刘崇阳 on 2016/11/21.
//  Copyright © 2016年 WKBP. All rights reserved.
//

#import "CYRootCell.h"
@interface CYRootCell()
@property (weak, nonatomic) IBOutlet UIButton *subShopCountBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) id <CYRootCellDelate> delegate;
@end
@implementation CYRootCell
- (void)awakeFromNib {
	[super awakeFromNib];
	self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setIsSubCount:(BOOL)isSubCount {
	
	if (isSubCount) {
		[_subShopCountBtn setBackgroundColor:[UIColor orangeColor]];
		_subShopCountBtn.enabled = YES;
	} else {
		[_subShopCountBtn setBackgroundColor:[UIColor grayColor]];
		_subShopCountBtn.enabled = NO;
	}
}
+ (instancetype)rootCellWithTableView:(UITableView *)tableView delegate:(id)delegate
							indexPath:(NSIndexPath *)indexPath dict:(NSDictionary *)dict {
	//	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	CYRootCell *cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CYRootCell class]) owner:nil options:nil] lastObject];
	cell.delegate = delegate;
	cell.indexPath = indexPath;
	cell.priceLabel.text = ((NSNumber *)[dict objectForKey:@"price"]).stringValue;
	cell.shopCountLabel.text = @(((NSNumber *)[dict objectForKey:@"count"]).integerValue).stringValue;
	return cell;
}
- (IBAction)select:(UIButton *)sender {
	
	sender.selected = !sender.selected;
}
- (IBAction)addShopCount:(UIButton *)sender {
	self.isSubCount = YES;
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
