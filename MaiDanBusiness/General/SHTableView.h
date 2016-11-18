//
//  SHTableView.h
//  DaJiaZhuanSH
//
//  Created by feng on 15/11/3.
//  Copyright © 2015年 feng. All rights reserved.
//
#import <UIKit/UIKit.h>


@protocol DataParseDelegate <NSObject>

- (void)requestDataFromNet:(int)pag;

@end

@class SHTableView,WaterRefreshLoadMoreView;
typedef NSInteger (^MLTableAlertNumberOfRowsBlock)(NSInteger section);
typedef UITableViewCell* (^MLTableAlertTableCellsBlock)(SHTableView *tableView, NSIndexPath *indexPath);
typedef void (^MLTableAlertRowSelectionBlock)(NSIndexPath *selectedIndex);
typedef NSInteger (^MLTableAlertCompletionBlock)();

@interface SHTableView :UITableView
@property (nonatomic, strong) MLTableAlertRowSelectionBlock selectionBlock;
@property (nonatomic, strong) WaterRefreshLoadMoreView *waterView;

@property (nonatomic,assign)BOOL hastNext;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)float cellHeight;
@property (nonatomic, assign) id<DataParseDelegate> dataDelagate;
@property (nonatomic, assign)int iPage;


@property (nonatomic,strong) UIActivityIndicatorView *testActivityIndicator;
@property (nonatomic, strong) MLTableAlertNumberOfRowsBlock numberOfRows;
@property (nonatomic, strong) MLTableAlertCompletionBlock completionBlock;
@property (nonatomic, strong) MLTableAlertTableCellsBlock cells;

+(SHTableView *)tableAlertWithTitle:(CGRect)frame andCompletionBlock:(MLTableAlertCompletionBlock)comBlock numberOfRows:(MLTableAlertNumberOfRowsBlock)rowsBlock andCells:(MLTableAlertTableCellsBlock)cellsBlock;
-(id)initWithFrame:(CGRect)frame andCompletionBlock:(MLTableAlertCompletionBlock)comBlock numberOfRows:(MLTableAlertNumberOfRowsBlock)rowsBlock andCells:(MLTableAlertTableCellsBlock)cellsBlock;

-(void)configureSelectionBlock:(MLTableAlertRowSelectionBlock)selBlock;

@end
