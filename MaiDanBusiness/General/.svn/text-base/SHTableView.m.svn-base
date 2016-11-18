//
//  SHTableView.m
//  DaJiaZhuanSH
//
//  Created by feng on 15/11/3.
//  Copyright © 2015年 feng. All rights reserved.
//

#import "SHTableView.h"
#import "WaterRefreshLoadMoreView.h"
@interface SHTableView ()<UITableViewDataSource,UITableViewDelegate,WaterLoadMoreDelegate,WaterRefreshDelegate>


@end
@implementation SHTableView

@synthesize dataArray;


#pragma mark - MLTableAlert Class Method

+(SHTableView *)tableAlertWithTitle:(CGRect)frame andCompletionBlock:(MLTableAlertCompletionBlock)comBlock numberOfRows:(MLTableAlertNumberOfRowsBlock)rowsBlock andCells:(MLTableAlertTableCellsBlock)cellsBlock{
    return [[self alloc] initWithFrame:frame andCompletionBlock:comBlock numberOfRows:rowsBlock andCells:cellsBlock];
}

#pragma mark - MLTableAlert Initialization
-(id)initWithFrame:(CGRect)frame andCompletionBlock:(MLTableAlertCompletionBlock)comBlock numberOfRows:(MLTableAlertNumberOfRowsBlock)rowsBlock andCells:(MLTableAlertTableCellsBlock)cellsBlock{
    // Throw exception if rowsBlock or cellsBlock is nil
    if (rowsBlock == nil || cellsBlock == nil || comBlock == nil)
    {
        [[NSException exceptionWithName:@"rowsBlock and cellsBlock Error" reason:@"These blocks MUST NOT be nil" userInfo:nil] raise];
        return nil;
    }
    
    self = [super initWithFrame:frame];
    if (self)
    {
        _hastNext = 1;
        _iPage = 1;
        self.separatorStyle =  UITableViewCellSeparatorStyleSingleLine;
        self.backgroundColor = RGBCOLOR(251, 250, 248);
        self.tableFooterView = [[UIView alloc] init];
        self.delegate = self;
        self.dataSource = self;
        
        // 创建刷新控件
        _numberOfRows = rowsBlock;
        _completionBlock = comBlock;
        _cells = cellsBlock;
        _waterView = [[WaterRefreshLoadMoreView alloc] initWithWithType:WaterRefreshTypeRefreshAndLoadMore];
        _waterView.refreshDelegate    = self;
        _waterView.loadMoreDelegate   = self;
        _waterView.scrollView         = self;
        
      self.testActivityIndicator  = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//        _testActivityIndicator.center = CGPointMake(100.0f, 100.0f);//只能设置中心，不能设置大小
//        [testActivityIndicator setFrame:CGRectMack(100, 100, 100, 100)];//不建议这样设置，因为UIActivityIndicatorView是不能改变大小只能改变位置，这样设置得到的结果是控件的中心在（100，100）上，而不是和其他控件的frame一样左上角在（100， 100）长为100，宽为100.
        [self addSubview:_testActivityIndicator];
        _testActivityIndicator.color = [UIColor redColor]; // 改变圈圈的颜色为红色； iOS5引入
        self.sectionHeaderHeight = 0.001;
        [_testActivityIndicator setHidesWhenStopped:YES]; //当旋转结束时隐藏
        self.scrollsToTop = YES;
        _testActivityIndicator.center = self.center;
    }
    
    return self;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(void)setHastNext:(BOOL)hastNext
{
    _hastNext = hastNext;
    
    if (!hastNext)
    {
        [_waterView banFunctionOfStartLoadMore:YES remind:@"没有更多内容了哦,亲!"];
    }else
    {
        [_waterView banFunctionOfStartLoadMore:NO remind:nil];
    }
    
    if (_waterView.isLoadingMore)
    {
        [_waterView endLoadingMoreWithRemind:@"加载成功!"];
    }
    else
    {
        [_waterView endRefreshWithRemindsWords:@"刷新成功!" remindImage:nil];
    }
    [_testActivityIndicator stopAnimating]; // 结束旋转

    [self reloadData];
}




#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _cellHeight;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // TODO: Allow multiple sections
    
    return self.completionBlock();
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // according to the numberOfRows block code
    
    return self.numberOfRows(section);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // according to the cells block code
    return self.cells(self, indexPath);
}
#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.selectionBlock != nil){
        self.selectionBlock(indexPath);
    }
}

#pragma mark - Actions

-(void)configureSelectionBlock:(MLTableAlertRowSelectionBlock)selBlock{
    self.selectionBlock = selBlock;
}
#pragma mark ---WaterDelete---
// 水滴下拉刷新的代理方法
- (void)slimeRefreshStartRefresh:(WaterRefreshLoadMoreView*)refreshView
{
    _iPage = 1;
    _hastNext = 1;
    [self.dataDelagate requestDataFromNet:_iPage];
}

- (void)slimeRefreshEndRefresh:(WaterRefreshLoadMoreView *)refreshView
{
    
}

- (void)loadMoreViewStartLoad:(WaterRefreshLoadMoreView *)refreshView
{
    _iPage++;
    [self.dataDelagate requestDataFromNet:_iPage];
}

- (void)loadMoreViewEndLoad:(WaterRefreshLoadMoreView *)refreshView
{
    
}
@end
