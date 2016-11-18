//
//  UIView+Category.h
//  Test
//
//  Created by 潇哥 on 15/7/9.
//  Copyright (c) 2015年 潇哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)

@property (nonatomic,assign) CGFloat top;
@property (nonatomic,assign) CGFloat bottom;
@property (nonatomic,assign) CGFloat left;
@property (nonatomic,assign) CGFloat right;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGSize  size;
@property (nonatomic,assign) CGPoint origin;


//- (void)addNoContentView;
//- (void)addNoContentViewWithTitle:(NSString *)title;
//- (void)addNoContentViewWithTitle:(NSString *)title centerY:(CGFloat)centerY;
//
//- (void)removeNoContentView;

/**
 *  @brief 移除此view上得所有控件
 */
- (void)removeAllSubviews;

/**
 *  @brief 获取此view所属的viewController
 */
- (UIViewController *)viewController;

/**
 *  @brief 设置view的圆角属性
 *
 *  @parma radius : 圆角弧度
 */
- (void)setCornerWithRadius:(CGFloat)radius;

/**
 *  @brief 根据view的边界属性
 *
 *  @parma color  : 边界颜色
 *  @parma width  : 边界宽度
 */
- (void)setBorderWithColor:(UIColor *)color Width:(CGFloat)width;


@end
