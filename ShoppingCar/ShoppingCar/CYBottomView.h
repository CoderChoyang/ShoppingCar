//
//  CYBottomView.h
//  ShoppingCar
//
//  Created by 刘崇阳 on 2016/11/21.
//  Copyright © 2016年 WKBP. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYBottomViewDelegate;
@interface CYBottomView : UIView

+ (instancetype)bottomViewWithDelegate:(id)delegate;

@end

@protocol CYBottomViewDelegate <NSObject>
@optional

- (void)selectAllClickWithBottomView:(CYBottomView *)bottomView;
@end
