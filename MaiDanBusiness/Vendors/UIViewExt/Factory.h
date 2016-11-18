//
//  Factory.h
//  Demo1
//
//  Created by lin on 16/1/7.
//  Copyright © 2016年 lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Factory : NSObject
/*
 这个类就可以为我们专门来创建一些基本的控件，那么如果要创建Label button textField 就可以通过这个类来创建
 这个类好像一个工厂一样专门生产一些基本控件
 类似于工厂设计模式
 */

//创建Button的工厂，将特殊的元素传入，生产相对应的Button
+ (UIButton *)createButtonWithframe:(CGRect)frame target:(id)target selector:(SEL)selector Title:(NSString *)title;
+ (UIButton *)createButtonWithframe:(CGRect)frame backgroundColor:(UIColor *)color target:(id)target selector:(SEL)selector Title:(NSString *)title ;
+ (UIButton *)createButtonWithframe:(CGRect)frame backgroundColor:(UIColor *)color fontSize:(CGFloat)size target:(id)target selector:(SEL)selector Title:(NSString *)title ;

+ (UIButton *)createButtonWithframe:(CGRect)frame backgroundColor:(UIColor *)color fontSize:(CGFloat)size image:(NSString *)image target:(id)target selector:(SEL)selector Title:(NSString *)title ;
+ (UIButton *)createButtonWithframe:(CGRect)frame backgroundColor:(UIColor *)color fontSize:(CGFloat)size backgroundImage:(NSString *)bgImage target:(id)target selector:(SEL)selector Title:(NSString *)title;
+ (UIButton *)createButtonWithframe:(CGRect)frame
                    backgroundColor:(UIColor *)color
                           fontSize:(CGFloat)size
                              image:(NSString *)image
                    backgroundImage:(NSString *)backgroundImage
                             target:(id)target
                           selector:(SEL)selector
                              Title:(NSString *)title;

//创建Label的工厂，将特殊的元素传入，生产相对应的Label
+ (UILabel *)createLabelWithframe:(CGRect)frame Title:(NSString *)title ;
+ (UILabel *)createLabelWithframe:(CGRect)frame textColor:(UIColor *)color Title:(NSString *)title ;
+ (UILabel *)createLabelWithframe:(CGRect)frame fontSize:(CGFloat)size Title:(NSString *)title ;
+ (UILabel *)createLabelWithframe:(CGRect)frame textColor:(UIColor *)color fontSize:(CGFloat)size  tag:(NSInteger)tag Title:(NSString *)title ;
+ (UILabel *)createLabelWithframe:(CGRect)frame tag:(NSInteger)tag textColor:(UIColor *)color backgroud:(UIColor *)bcolor fontSize:(CGFloat)size Title:(NSString *)title ;

//创建View的工厂，将特殊的元素传入，生产相应的View
+ (UIView *)createViewWithBackgroundColor:(UIColor *)color frame:(CGRect)frame;

//创建textField的工厂，将特殊的元素传入，生产响应的textField
+ (UITextField *)creatTextFieldWithframe:(CGRect)frame textColor:(UIColor *)color borderStyle:(UITextBorderStyle)borderStyle Text:(NSString *)text  placeholder:(NSString *)placeholder;






//这个类的功能就是创建label 和button
+ (UILabel *)creatLabelWithFrame:(CGRect)frame
                            text:(NSString *)text ;
//创建button可以创建 标题按钮和 图片按钮
+ (UIButton *)creatButtonWithFrame:(CGRect)frame
                            target:(id)target
                               sel:(SEL)sel
                               tag:(NSInteger)tag
                             image:(NSString *)name
                             title:(NSString *)title;
//创建UIImageView
+ (UIImageView *)creatImageViewWithFrame:(CGRect)frame imageName:(NSString *)name;
//创建UITextField
+ (UITextField *)creatTextFieldWithFrame:(CGRect)frame delegate:(id<UITextFieldDelegate>)delegate tag:(NSInteger)tag placeHolder:(NSString *)string;
//me
+(UIView *)createViewWithFrame:(CGRect)frame tag:(NSInteger)tag target:(id)target selector:(SEL)selector isCenter:(BOOL)is Image:(NSString *)image Title:(NSString *)title titleDetail:(NSString *)detail;
+(UITextView *)creatTextViewWithFrame:(CGRect)frame bgCol:(UIColor*)bg borC:(UIColor*)bc borW:(int)bw delegate:(id<UITextViewDelegate>)delegate tag:(NSInteger)tag fontSize:(CGFloat)size textCol:(UIColor*)tc  placeHolder:(NSString *)string;

+ (UIView *)createViewWithBackgroundColor:(UIColor *)color frame:(CGRect)frame tag:(int)tag target:(id)target selector:(SEL)selector;



+(UIImageView *)creatImageViewWithFrame:(CGRect)frame tag:(int)tag target:(id)target selector:(SEL)selector image:(NSString*)image;
//商城购物车添加商品
+(void)choosecommodity;
//商城购物车减少商品
+(void)deletecommodityWith:(int)count;

//新加
+ (UIButton *)createButtonWithfontSize:(CGFloat)size textCol:(UIColor*)col tag:(NSInteger)tag  frame:(CGRect)frame target:(id)target selector:(SEL)selector Title:(NSString *)title;

+(UIView *)creatViewLabelWithframe:(CGRect)frame textCol:(NSArray *)cols Font:(NSArray*)fonts bgCol:(UIColor*)bcol tag:(NSArray*)tag titels:(NSArray*)titles;
@end
