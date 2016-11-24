//
//  CYRootCell.h
//  ShoppingCar
//
//  Created by 刘崇阳 on 2016/11/21.
//  Copyright © 2016年 WKBP. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CYRootCellDelate;
@interface CYRootCell : UITableViewCell
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) NSDictionary *dataDict;
@property (assign, nonatomic) BOOL isSelectShop;
+ (instancetype)rootCellWithTableView:(UITableView *)tableView
							 delegate:(id)delegate
							indexPath:(NSIndexPath *)indexPath;
@end

@protocol CYRootCellDelate <NSObject>
@optional
/** 商品数+1 */
- (void)addButtonClickWithCell:(CYRootCell *)rootCell;
/** 商品数-1 */
- (void)subButtonClickWithCell:(CYRootCell *)rootCell;
/** 选择(取消)商品 */
- (void)selectShopButtonClickWithCell:(CYRootCell *)rootCell;
@end
