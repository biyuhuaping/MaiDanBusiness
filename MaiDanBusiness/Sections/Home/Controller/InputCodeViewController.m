//
//  InputCodeViewController.m
//  DaJiaZhuanBiz
//
//  Created by Bibo on 15/1/24.
//  Copyright (c) 2015年 su. All rights reserved.
//
//2015-11-2 #001 delete liu
//2015-11-2 #002 resive liu
//2015-11-2#004 resive  liu
#import "InputCodeViewController.h"
#import "OrderTableViewCell.h"
#import "Orderlist.h"
#import "SHTableView.h"
#import "WaterRefreshLoadMoreView.h"
@interface InputCodeViewController ()<DataParseDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITextField *_txt;
    UISegmentedControl *sementC;
    BOOL _hasNext;

}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SHTableView *tableView;
@property (nonatomic, strong) UILabel *lines;

@end

@implementation InputCodeViewController


- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"chengse64"] forBarMetrics:UIBarMetricsDefault];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"全部订单";
    _hasNext = YES;
    [self initUI];
}

- (void)initUI
{
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(-1,64, G_SCREEN_WIDTH+2, 44)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(G_SCREEN_WIDTH/3, 8, 1, 24)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [topView addSubview:lineView];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(G_SCREEN_WIDTH * 2/3, 8, 1, 24)];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [topView addSubview:lineView1];
    
    sementC = [[UISegmentedControl alloc] initWithItems:@[@"全部订单",@"已确认",@"待确认"]];
    sementC.frame = CGRectMake(0, 0,self.view.bounds.size.width, 44);

    [sementC setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30]} forState:UIControlStateNormal];
    sementC.selectedSegmentIndex = 0;
   
    //设置未选中的字体颜色为白色
    [sementC setTintColor:[UIColor clearColor]];
    [sementC setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBCOLOR(237, 87, 49)} forState:UIControlStateSelected];
    
    [sementC setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState:UIControlStateNormal];
    [sementC addTarget:self action:@selector(changeContentOffset:) forControlEvents:UIControlEventValueChanged];
    //列表
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 108, G_SCREEN_WIDTH, G_SCREEN_HEIGHT-108)];
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, 0);
    _scrollView.backgroundColor = RGBCOLOR(251, 250, 248);
    _scrollView.scrollEnabled = NO;
    [topView addSubview:sementC];
    //默认位置
    self.lines = [[UILabel alloc] initWithFrame:CGRectMake(0,40, self.view.bounds.size.width/3 - 3, 3)];
    self.lines.backgroundColor = RGBCOLOR(237, 87, 49);
    [topView addSubview:_lines];
    [self.view addSubview:_scrollView];
    [self addTableview];
   
    
}



- (void)addTableview{
    
    for (int i = 0; i < 3; i++) {
        _tableView = [SHTableView tableAlertWithTitle:CGRectMake(self.view.bounds.size.width *i, 0, self.view.bounds.size.width, G_SCREEN_HEIGHT - 100) andCompletionBlock:^NSInteger{
            if ( _tableView.dataArray.count > 0) {
                return 1;
            }
            return 0;
        } numberOfRows:^NSInteger(NSInteger section) {
            if ( _tableView.dataArray.count > 0) {
                return _tableView.dataArray.count;
            }
            return 0;
        } andCells:^UITableViewCell *(SHTableView *tableView, NSIndexPath *indexPath) {
            static NSString *cellIndextifier = @"OrderTableViewCell";

            OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndextifier];
            if (cell == nil) {
                cell = [[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndextifier];
            }
            if (_tableView.dataArray.count >= indexPath.row) {
                self.orderList = _tableView.dataArray[indexPath.row];
            }else{
                return nil;
            }
            cell.orderno.text = [NSString stringWithFormat:@"%@",_orderList.orderNo];
            cell.userName.text = _orderList.userName;
            if ([_orderList.payType intValue] == 1) {
//                cell.payType.text = @"现金支付";
                cell.payImageV.image = [UIImage imageNamed:@"dingdan_xj"];
            }
            else if ([_orderList.payType intValue] == 2) {
//                cell.payType.text = @"分享币支付";
                cell.payImageV.image = [UIImage imageNamed:@"dingdan_fxb"];

            }
            else if ([_orderList.payType intValue] == 3) {
//                cell.payType.text = @"支付宝支付";
                cell.payImageV.image = [UIImage imageNamed:@"dingdan_zfb"];

            }
            else if ([_orderList.payType intValue] ==4) {
//                cell.payType.text = @"微信支付";
                cell.payImageV.image = [UIImage imageNamed:@"dingdan_wx"];

            }
           else if ([_orderList.payType intValue]== 5){
//                cell.payType.text = @"赠送积分";
               cell.payImageV.image = [UIImage imageNamed:@"dingdan_jf"];

            }
            if ([_orderList.orderStatus intValue] == 0) {
                cell.confirmState.image = [UIImage imageNamed:@"dingdan_wqr"];
                cell.creatLable.text = _orderList.createTime;
            }else{
                cell.creatLable.text = _orderList.confirmTime;
                cell.confirmState.image = [UIImage imageNamed:@"dingdan_yqr"];

            }
            cell.feerat.text = [NSString stringWithFormat:@"%.0f%%",[_orderList.discount floatValue] *100];
            
            
            NSString *price;
            NSMutableAttributedString *mAtrrString;
            price =[NSString stringWithFormat:@"¥ %@",_orderList.totalFee];
            NSDictionary *consumDic1 =  @{NSFontAttributeName :[UIFont fontWithName:@"HelveticaNeue-Bold" size:22],NSForegroundColorAttributeName:RGBCOLOR(237, 87, 49)};
            NSDictionary *consumDic2 = @{NSFontAttributeName :[UIFont fontWithName:@"HelveticaNeue-Bold" size:13],NSForegroundColorAttributeName:RGBCOLOR(237, 87, 49)};
            mAtrrString= [[NSMutableAttributedString alloc] initWithString:price attributes:consumDic1];
            [mAtrrString  addAttributes:consumDic2 range:NSMakeRange(0,2)];
            cell.totalfee.attributedText = mAtrrString;
            
            //#004 start
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //end
            
            return cell;
            

        }];
        [self.tableView configureSelectionBlock:^(NSIndexPath *selectedIndex) {
            
        }];
        _tableView.sectionHeaderHeight = 10;
        _tableView.backgroundColor=RGBCOLOR(245, 245, 245);
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] init];;
        _tableView.dataDelagate = self;
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.scrollEnabled = NO;
        _tableView.tag = 2001 + i;
        _tableView.cellHeight = 160;
        [_scrollView addSubview:_tableView];
    }
  
    self.tableView = (SHTableView *)[_scrollView viewWithTag:2001];
    _tableView.scrollEnabled = YES;
    [self requestDataFromNet:1];


}
#pragma mark - 数据请求
/**
 *  获取后台数据
 */
- (void)requestDataFromNet:(int)pag{
    
    __weak InputCodeViewController *weakSelf = self;
    self.marrAttendList = [NSMutableArray array];

   
    
    if (sementC.selectedSegmentIndex == 0) {
        [[API shareAPI] getAPI1:API_ALLOrderlist pag:pag completion:^(id responseData) {
            _hasNext = [responseData[@"json_val"][@"hasNext"] boolValue];
            
            if ([responseData[@"json_res"] isEqualToString:@"json_ok"]) {
                
                for (NSDictionary *dic in responseData[@"json_val"][@"datas"]) {
                    weakSelf.orderList = [[Orderlist alloc] init];
                    [weakSelf.orderList setValuesForKeysWithDictionary:dic];
                    [weakSelf.marrAttendList addObject:_orderList];
                }
            }
            
            if (pag == 1) {
                self.tableView.dataArray = nil;
                self.tableView.dataArray = _marrAttendList;
            }else{
                [self.tableView.dataArray addObjectsFromArray:_marrAttendList];
            }
            
            weakSelf.tableView.hastNext = _hasNext;
        }];
    }
    else if(sementC.selectedSegmentIndex == 1){
        [[API shareAPI] getAPI1:API_confirmOrder pag:pag completion:^(id responseData) {
            _hasNext = [responseData[@"json_val"][@"hasNext"] boolValue];
            
            if ([responseData[@"json_res"] isEqualToString:@"json_ok"]) {
                
                
                for (NSDictionary *dic in responseData[@"json_val"][@"datas"]) {
                    weakSelf.orderList = [[Orderlist alloc] init];
                    [weakSelf.orderList setValuesForKeysWithDictionary:dic];
                    [weakSelf.marrAttendList addObject:_orderList];
                }
            }
            
            if (pag == 1) {
                self.tableView.dataArray = nil;
                self.tableView.dataArray = _marrAttendList;
            }else{
                [self.tableView.dataArray addObjectsFromArray:_marrAttendList];
            }
            
            weakSelf.tableView.hastNext = _hasNext;
        }];
    }else{
        [[API shareAPI] getAPI1:API_NewOrderList pag:pag completion:^(id responseData) {
            _hasNext = [responseData[@"json_val"][@"hasNext"] boolValue];
            
            if ([responseData[@"json_res"] isEqualToString:@"json_ok"]) {
                
                
                for (NSDictionary *dic in responseData[@"json_val"][@"datas"]) {
                    weakSelf.orderList = [[Orderlist alloc] init];
                    [weakSelf.orderList setValuesForKeysWithDictionary:dic];
                    [weakSelf.marrAttendList addObject:_orderList];
                }
            }
            
            if (pag == 1) {
                self.tableView.dataArray = nil;
                self.tableView.dataArray = _marrAttendList;
            }else{
                [self.tableView.dataArray addObjectsFromArray:_marrAttendList];
            }
            
            weakSelf.tableView.hastNext = _hasNext;
        }];
    }
    if (pag == 1) {
        [weakSelf.tableView.testActivityIndicator startAnimating]; // 开始旋转
    }

}

#pragma mark - 滚动视图
- (void)changeContentOffset:(UISegmentedControl *)segmeted{
    
    _scrollView.contentOffset = CGPointMake([[UIScreen mainScreen] bounds].size.width * segmeted.selectedSegmentIndex, 0);
    
    self.lines.frame = CGRectMake(segmeted.selectedSegmentIndex *self.view.bounds.size.width/3,40, self.view.bounds.size.width/3 - 3, 3);
    [UIView commitAnimations];
    
    SHTableView *tails= (SHTableView *)[_scrollView viewWithTag:segmeted.selectedSegmentIndex  + 2001];
    _hasNext  =YES ;
    _tableView.scrollEnabled = NO;
    _tableView = nil;
    _tableView = tails;
    _tableView.scrollEnabled = YES;
    _tableView.dataArray = nil;
    //消费用户请求数据
    [self requestDataFromNet:1];
}

#pragma mark  - TableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableView.cellHeight;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        _orderList= [_tableView.dataArray objectAtIndex:indexPath.row];
        
        [self NetW_DelAddress:_orderList.orderid];
        
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
 return NO;
        
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // TODO: Allow multiple sections
        return self.tableView.completionBlock();
  
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // according to the numberOfRows block code
    
    return self.tableView.numberOfRows(section);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // according to the cells block code
    return self.tableView.cells(_tableView, indexPath);
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.tableView.selectionBlock != nil){
        self.tableView.selectionBlock(indexPath);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

#pragma mark - Actions
- (void)configureSelectionBlock:(MLTableAlertRowSelectionBlock)selBlock{
    self.tableView.selectionBlock = selBlock;
}

- (void)NetW_DelAddress:(NSString *)strID
{
  
    [[API shareAPI] deleteTheOrder:strID completion:^(id responseData) {
        if ([responseData[@"status"]  isEqualToString:@"0"]) //通讯成功
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            
            [self requestDataFromNet:1];
            //            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD showErrorWithStatus:responseData[@"result"]];
        }
    }];
    
}

// any offset chan
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
