//
//  RecordViewController.m
//  MaiDanSH
//
//  Created by lin on 16/10/20.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "RecordViewController.h"
#import "SHTableView.h"
#import "MyAccountDetailTableViewCell.h"

@interface RecordViewController () <DataParseDelegate>

/** 页码 */
@property (nonatomic, assign) int page;
@property (nonatomic, weak) SHTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation RecordViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"chengse64"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.page = 1;
    
    [self initUI];
    
    if (self.type == MyAccountDetailTypeRecharge) {
        [self requestRechargeRecord];
    } else {
        [self requestWithdrawRecord];
    }
}

- (void)requestRechargeRecord {
    
    [[API shareAPI] getRechargeRecordWithPage:self.page completion:^(id responseData) {
        NSLog(@"requestRechargeRecord = %@",responseData);
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
        }
        [self.dataArray addObjectsFromArray:responseData[@"json_val"][@"list"]];
        [self.tableView reloadData];
        self.tableView.hastNext = [responseData[@"json_val"][@"hasNext"] boolValue];
    }];
    
}

- (void)requestWithdrawRecord {
    [[API shareAPI] getWithdrawRecordWithPage:self.page completion:^(id responseData) {
        NSLog(@"requestWithdrawRecord = %@",responseData);
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
        }
        [self.dataArray addObjectsFromArray:responseData[@"json_val"][@"list"]];
        [self.tableView reloadData];
        self.tableView.hastNext = [responseData[@"json_val"][@"hasNext"] boolValue];
    }];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)initUI {
    
    if (self.type == MyAccountDetailTypeRecharge) {
        self.title = @"充值记录";
    } else {
        self.title = @"提现记录";
    }
    
    
    [self setupTableView];
}

- (void)setupTableView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    SHTableView *tableView = [[SHTableView alloc] initWithFrame:CGRectMake(0, 64, G_SCREEN_WIDTH, G_SCREEN_HEIGHT-64) andCompletionBlock:^NSInteger{
        return 1;
    } numberOfRows:^NSInteger(NSInteger section) {
        return self.dataArray.count;
    } andCells:^UITableViewCell *(SHTableView *tableView, NSIndexPath *indexPath) {
        
        tableView.cellHeight = 74.0f;
        NSDictionary *dict = self.dataArray[indexPath.row];
        static NSString *kMyAccountDetail = @"kMyAccountDetail";
        MyAccountDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMyAccountDetail];
        if (cell == nil) {
            cell = [[MyAccountDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMyAccountDetail];
        }
        [cell configCellWithDict:dict type:self.type];
        return cell;
    }];
    tableView.dataDelagate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;

}

- (void)requestDataFromNet:(int)pag {
    
    self.page = pag;
    if (self.type == MyAccountDetailTypeRecharge) {
        [self requestRechargeRecord];
    } else {
        [self requestWithdrawRecord];
    }
}

@end
