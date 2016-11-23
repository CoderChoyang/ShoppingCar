//
//  CYRootViewController.m
//  ShoppingCar
//
//  Created by 刘崇阳 on 2016/11/21.
//  Copyright © 2016年 WKBP. All rights reserved.
//

#import "CYRootViewController.h"
#import "CYBottomView.h"
#import "CYRootCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
typedef NS_ENUM(NSInteger, ModifyType) {
	
	ModifyTypeShopCountAdd,
	ModifyTypeShopCountSub,
	ModifyTypeShopSelect,
	ModifyTypeShopUnSelect
};
@interface CYRootViewController ()<UITableViewDelegate,UITableViewDataSource,
									  CYRootCellDelate,CYBottomViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) CYBottomView *bottomView;
@property (strong, nonatomic) NSArray *dataArray;
@property (assign, nonatomic) ModifyType modifyType;
@end
@implementation CYRootViewController
- (UITableView *)tableView {
	
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-45)
												  style:(UITableViewStylePlain)];
		_tableView.delegate = self;
		_tableView.dataSource = self;
		_tableView.rowHeight = 60;
		[_tableView registerNib:[UINib nibWithNibName:@"CYRootCell" bundle:nil] forCellReuseIdentifier:@"cell"];
	}
	return _tableView;
}
- (CYBottomView *)bottomView {
	
	if (!_bottomView) {
		_bottomView = [CYBottomView bottomViewWithDelegate:self];
		_bottomView.frame = CGRectMake(0, HEIGHT-45, WIDTH, 45);
	}
	return _bottomView;
}
/**
 // 初始化view
 - (void)loadView {
	[super loadView];
 }
 */

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.view addSubview:self.tableView];
	[self.view addSubview:self.bottomView];
	[self readData];
}

/**
 // 完成任何与视图显示相关的任务，例如改变视图方向、状态栏方向、视图显示样式等
 - (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
 }
 */
#pragma mark ------ UITableViewDataSource ------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	CYRootCell *cell = [CYRootCell rootCellWithTableView:tableView delegate:self indexPath:indexPath];
	// 绑定数据源
	cell.dict = self.dataArray[indexPath.row];
	return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return [self.dataArray count];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return YES;
}

#pragma mark ------ CYRootCellDelegate ------
- (void)addButtonClickWithCell:(CYRootCell *)rootCell {
	
	[self modifyShopCountAtIndex:rootCell.indexPath.row withModifyType:ModifyTypeShopCountAdd];
}
- (void)subButtonClickWithCell:(CYRootCell *)rootCell {
	
	[self modifyShopCountAtIndex:rootCell.indexPath.row withModifyType:ModifyTypeShopCountSub];
}
- (void)selectShopButtonClickWithCell:(CYRootCell *)rootCell {
	if (rootCell.isSelectShop) {
		[self modifyShopCountAtIndex:rootCell.indexPath.row withModifyType:ModifyTypeShopSelect];
	} else {
		[self modifyShopCountAtIndex:rootCell.indexPath.row withModifyType:ModifyTypeShopUnSelect];
	}
}

#pragma mark ------ CYBottomViewDelegate ------
- (void)selectAllClickWithBottomView:(CYBottomView *)bottomView {
	
	CYLog(@"dfdfdfdfdfdf");
}

#pragma mark ------ reload table ------
- (void)reloadData {
	[self readData];
	[self.tableView reloadData];
}

#pragma mark ------ load data ------
- (void)loadData {
	
	NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ShoppingList.plist" ofType:nil]];
	NSMutableArray *arrayM = [NSMutableArray array];
	for (NSDictionary *dict in array) {
		[arrayM addObject:dict];
	}
	self.dataArray = arrayM;
	[self writeDataWithArray:self.dataArray];
}

#pragma mark ------ read data ------
- (void)readData {
	
	NSArray *array = [[NSUserDefaults standardUserDefaults] arrayForKey:@"ShoppingCarData"];
	if (array.count > 0) {
		self.dataArray = array;
	} else {
		[self loadData];
	}
}

#pragma mark ------ write data ------
- (void)writeDataWithArray:(NSArray *)dataArray {
	
	NSUserDefaults *userDafaults = [NSUserDefaults standardUserDefaults];
	[userDafaults setObject:dataArray forKey:@"ShoppingCarData"];
}

#pragma mark ------ modify shop state ------
- (void)modifyShopCountAtIndex:(NSUInteger)index withModifyType:(ModifyType)type {
	
	NSMutableArray *arrayM = self.dataArray.mutableCopy;
	NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:arrayM[index]];
	NSInteger shopCount = ((NSNumber *)[dictM objectForKey:@"count"]).integerValue;
	if (type == ModifyTypeShopCountAdd) {
		[dictM setObject:@(shopCount+=1) forKey:@"count"];
	} else if (type == ModifyTypeShopCountSub){
		[dictM setObject:@(shopCount-=1) forKey:@"count"];
	} else if (type == ModifyTypeShopSelect) {
		[dictM setObject:@(YES) forKey:@"select"];
	} else if (type == ModifyTypeShopUnSelect) {
		[dictM setObject:@(NO)  forKey:@"select"];
	}
	// 替换数据源相应位置的数据
	[arrayM replaceObjectAtIndex:index withObject:dictM];
	[self writeDataWithArray:arrayM];
	[self reloadData];
}
/**
 // view即将布局其Subviews。
 // 要调整Subviews的位置，在调整之前要做的一些工作就可以在该方法中实现。
 - (void)viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];
 }
 */

/**
 // 已经调整Subviews的位置，在调整完成之后要做的一些工作就可以在该方法中实现。
 - (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
 }
 */

/**
 // 在这个方法中执行视图显示相关附件任务
 - (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
 }
 */

/**
 //view即将从superView中移除且移除动画切换之前，此时还没有调用removeFromSuperview。
 - (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
 }
 */

/**
 // view从superView中移除，移除动画切换之后调用，此时已调用removeFromSuperview。
 - (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
 }
 */

@end
