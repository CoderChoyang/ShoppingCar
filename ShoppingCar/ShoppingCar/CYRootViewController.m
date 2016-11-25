//
//  CYRootViewController.m
//  ShoppingCar
//
//  Created by 刘崇阳 on 2016/11/21.
//  Copyright © 2016年 WKBP. All rights reserved.
//
// 测试sourceTree 本条信息由SourceTree推送
// 测试Github     本条信息由GitHub客户端推送
#import "CYRootViewController.h"
#import "CYBottomView.h"
#import "CYRootCell.h"
#import "CYOrderViewController.h"
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
		_tableView.rowHeight = 76;
//		[_tableView registerNib:[UINib nibWithNibName:@"CYRootCell" bundle:nil] forCellReuseIdentifier:@"cell"];
	}
	return _tableView;
}
- (CYBottomView *)bottomView {
	
	if (!_bottomView) {
		_bottomView = [CYBottomView bottomViewWithDelegate:self];
		_bottomView.frame = CGRectMake(0, HEIGHT-45, WIDTH, 45);
		[_bottomView settlementClickWithDelegate:self action:@selector(enterToOrderView)];
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
	self.navigationItem.title = @"购物车";
	[self.view addSubview:self.tableView];
	[self.view addSubview:self.bottomView];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self loadData];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	// 将购物车中改变之后的信息发送请求到服务器上
	NSLog(@"已发送到服务器");
	// 测试Contribution不显示问题
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	// 删除NSUserDefaults中保存的本地数据保存信息
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ShoppingCarData"];
	NSLog(@"已删除本地保存数据");
	// 测试Contribution不显示问题
}

#pragma mark ------ UITableViewDataSource ------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	CYRootCell *cell = [CYRootCell rootCellWithTableView:tableView delegate:self indexPath:indexPath];
	// 绑定数据源
	cell.dataDict = self.dataArray[indexPath.row];
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
//	CYLog(@"dfdfdfdfdfdfdfd");
}

#pragma mark ------ reload table ------
- (void)reloadData {
	[self readData];
	[self.tableView reloadData];
}

#pragma mark ------ load data from dataSource------
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
//	CYLog(@"%@",array);
	self.dataArray = array;
}

#pragma mark ------ write data ------
- (void)writeDataWithArray:(NSArray *)dataArray {
	
	NSUserDefaults *userDafaults = [NSUserDefaults standardUserDefaults];
	[userDafaults setObject:dataArray forKey:@"ShoppingCarData"];
}

#pragma mark ------ modify shop state ------
- (void)modifyShopCountAtIndex:(NSUInteger)index withModifyType:(ModifyType)type {
	
	NSMutableArray *tempArray = self.dataArray.mutableCopy;
	NSMutableDictionary *tempDict = [NSMutableDictionary dictionaryWithDictionary:tempArray[index]];
	NSInteger shopCount = ((NSNumber *)[tempDict objectForKey:@"count"]).integerValue;
	if (type == ModifyTypeShopCountAdd) {
		[tempDict setObject:@(shopCount+=1) forKey:@"count"];
	} else if (type == ModifyTypeShopCountSub){
		[tempDict setObject:@(shopCount-=1) forKey:@"count"];
	} else if (type == ModifyTypeShopSelect) {
		[tempDict setObject:@(YES) forKey:@"select"];
	} else if (type == ModifyTypeShopUnSelect) {
		[tempDict setObject:@(NO)  forKey:@"select"];
	}
	// 替换数据源相应位置的数据
	[tempArray replaceObjectAtIndex:index withObject:tempDict];
	[self writeDataWithArray:tempArray];
	[self reloadData];
}
#pragma mark ------ push to Order view ------
- (void)enterToOrderView {
	
	[self.navigationController pushViewController:[CYOrderViewController new] animated:YES];

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
@end
