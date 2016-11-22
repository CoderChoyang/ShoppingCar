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
@interface CYRootViewController ()<UITableViewDelegate,UITableViewDataSource,CYRootCellDelate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) CYBottomView *bottomView;
@property (strong, nonatomic) NSArray *dataArray;
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
		_bottomView = [CYBottomView bottomView];
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
	
	CYRootCell *cell = [CYRootCell rootCellWithTableView:tableView delegate:self indexPath:indexPath dict:self.dataArray[indexPath.row]];
	
	return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return [self.dataArray count];
}
#pragma mark ------ CYRootCellDelegate ------
- (void)addButtonClickWithCell:(CYRootCell *)rootCell {
	
	NSDictionary *dict = self.dataArray[rootCell.indexPath.row];
	rootCell.shopCount = ((NSNumber *)[dict objectForKey:@"count"]).integerValue;
	NSLog(@"%ld",rootCell.shopCount);
	rootCell.shopCountLabel.text = @(rootCell.shopCount+=1).stringValue;
}
- (void)subButtonClickWithCell:(CYRootCell *)rootCell {

}
#pragma mark ------ 加载数据 ------
- (void)loadData {
	
	NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ShoppingList.plist" ofType:nil]];
	NSMutableArray *arrayM = [NSMutableArray array];
	for (NSDictionary *dict in array) {
		[arrayM addObject:dict];
	}
	self.dataArray = arrayM;
	[self writeDataWithArray:self.dataArray];
}
#pragma mark ------ 读取数据 ------
- (void)readData {
	
	NSArray *array = [[NSUserDefaults standardUserDefaults] arrayForKey:@"ShoppingCarData"];
	if (array.count > 0) {
		self.dataArray = array;
	} else {
		[self loadData];
	}
}
#pragma mark ------ 写入数据 ------
- (void)writeDataWithArray:(NSArray *)dataArray {
	
	NSUserDefaults *userDafaults = [NSUserDefaults standardUserDefaults];
	[userDafaults setObject:dataArray forKey:@"ShoppingCarData"];
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
