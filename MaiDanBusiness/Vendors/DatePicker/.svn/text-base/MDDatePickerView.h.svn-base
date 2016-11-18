//
//  MDDatePickerView.h
//  MaiDan
//
//  Created by 潇哥 on 16/8/3.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XGStringBlock)(NSString *string);

@interface MDDatePickerView : UIView

@property (nonatomic,copy) XGStringBlock block;

+ (instancetype)shareInstance;

- (void)showBottomView;

- (void)setPickerMode:(UIDatePickerMode)mode;

- (void)setMaxDate;

@end
