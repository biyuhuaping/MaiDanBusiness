//
//  RecordViewController.h
//  MaiDanSH
//
//  Created by lin on 16/10/20.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "BaseViewController.h"
#import "MyAccountDetailTableViewCell.h"

//typedef NS_ENUM(NSUInteger, RecordType) {
//    RecordTypeRecharge,
//    RecordTypeWithdraw
//};

@interface RecordViewController : BaseViewController

/** 记录类型 */
@property (nonatomic, assign) MyAccountDetailType type;

@end
