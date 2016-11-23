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
@property (strong, nonatomic) NSDictionary *dict;
@property (assign, nonatomic) BOOL isSelectShop;
+ (instancetype)rootCellWithTableView:(UITableView *)tableView
							 delegate:(id)delegate
							indexPath:(NSIndexPath *)indexPath;
@end

@protocol CYRootCellDelate <NSObject>
@optional
- (void)addButtonClickWithCell:(CYRootCell *)rootCell;
- (void)subButtonClickWithCell:(CYRootCell *)rootCell;
- (void)selectShopButtonClickWithCell:(CYRootCell *)rootCell;
@end
