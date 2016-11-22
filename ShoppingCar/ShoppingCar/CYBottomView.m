//
//  CYBottomView.m
//  ShoppingCar
//
//  Created by 刘崇阳 on 2016/11/21.
//  Copyright © 2016年 WKBP. All rights reserved.
//

#import "CYBottomView.h"
@interface CYBottomView()
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@end
@implementation CYBottomView
+ (instancetype)bottomView {
	
	return [[[NSBundle mainBundle] loadNibNamed:@"CYBottomView" owner:nil options:nil] lastObject];
}
- (IBAction)selectAll:(UIButton *)sender {
	
}
@end
