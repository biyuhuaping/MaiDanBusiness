//
//  UIStoryboard+Category.h
//  SmallThings
//
//  Created by 潇哥 on 15/7/9.
//  Copyright (c) 2015年 潇哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (Category)


/**
 *  @brief 获取Storyboard中的根视图控制器
 */
+ (id)initViewController;

/**
 *  @brief Storyboard中控制器的实例化
 *
 *  @parma identifier : 控制器的Storyboard ID
 */
+ (id)getControllerByID:(NSString *)identifier;


@end
