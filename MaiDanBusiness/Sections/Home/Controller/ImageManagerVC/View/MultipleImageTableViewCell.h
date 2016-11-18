//
//  MultipleImageTableViewCell.h
//  MaiDanSH
//
//  Created by lin on 16/10/12.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XGIntegerBlock)(NSInteger index);

@interface MultipleImageTableViewCell : UITableViewCell

/** 图片轻击的回调 */
@property (nonatomic, copy) void(^tapBlock)(UIImageView *imageView);

/** 图片长按的回调 */
@property (nonatomic, copy) void(^longPressBlock)(UIImageView *imageView);

- (void)updateCellLayoutWithImages:(NSArray *)images;

@end
