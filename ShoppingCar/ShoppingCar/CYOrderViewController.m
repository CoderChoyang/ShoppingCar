//
//  CYOrderViewController.m
//  ShoppingCar
//
//  Created by 刘崇阳 on 2016/11/24.
//  Copyright © 2016年 WKBP. All rights reserved.
//

#import "CYOrderViewController.h"

@interface CYOrderViewController ()

@end

@implementation CYOrderViewController

/**
 // 初始化view
 - (void)loadView {
	[super loadView];
 }
 */


- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	UILabel *Label = [[UILabel alloc] init];
	Label.frame = CGRectMake(0, 0, 100, 20);
	Label.center = self.view.center;
	Label.font = [UIFont systemFontOfSize:15.f];
	
	Label.text = @"已接受请求";
	[UIView animateWithDuration:1.5 animations:^{
		
		[self.view addSubview:Label];
	}];
}
/**
 // 完成任何与视图显示相关的任务，例如改变视图方向、状态栏方向、视图显示样式等
 - (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
 }
 */

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
