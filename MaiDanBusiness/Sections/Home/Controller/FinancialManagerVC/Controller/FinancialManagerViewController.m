//
//  FinancialManagerViewController.m
//  MaiDanSH
//
//  Created by lin on 16/10/20.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "FinancialManagerViewController.h"
#import "ConViewController.h"
#import "FulfillCardVC.h"
#import "WithdrawViewController.h"
#import "RecordViewController.h"
#import "BindingCardViewController.h"

@interface FinancialManagerViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

/** 顶部视图 */
@property (nonatomic, weak) UIView *headerView;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 名称 */
@property (nonatomic, weak) UILabel *username;

@end

@implementation FinancialManagerViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"touming64"] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"chengse64"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"财务管理";
    
    [self setUpHeaderView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.bottom, G_SCREEN_WIDTH, G_SCREEN_HEIGHT - self.headerView.bottom) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}


- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[ @[@"收益转换"],
                        @[@"充值",@"充值记录"],
                        @[@"提现",@"提现记录"],
                        @[@"绑定银行卡"]];
    }
    return _dataArray;
}


- (void)setUpHeaderView {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, G_SCREEN_WIDTH, 265 *G_SCREEN_PROP)];
    [self.view addSubview:headerView];
    self.headerView = headerView;
    
    UIImageView *topView = [[UIImageView alloc] initWithFrame:headerView.bounds];
    topView.image = [UIImage imageNamed:@"wodeyaoqing_bg"];
    topView.userInteractionEnabled = YES;
    [headerView addSubview:topView];
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10 * G_SCREEN_HEIGHT/667 + 64, 85 *G_SCREEN_HEIGHT/667 , 85 * G_SCREEN_HEIGHT/667)];
    
    if (iPhone4) {
        iconView.top = 5 * G_SCREEN_HEIGHT/667;
    }
    
    iconView.centerX = headerView.centerX;
    iconView.layer.borderWidth = 3;
    iconView.layer.borderColor = [UIColor whiteColor].CGColor;
    iconView.layer.masksToBounds    = YES;
    iconView.layer.cornerRadius     = 42.5 * G_SCREEN_HEIGHT/667;
    [headerView addSubview:iconView];
    [iconView sd_setImageWithURL:[NSURL URLWithString:_homeMessage.logo] placeholderImage:[UIImage imageNamed:@"logo_zhuan"]];
    [[API shareAPI] saveLocalData:G_HeadUrl value:_homeMessage.logo];
    self.iconView = iconView;
    
    // 添加用户名
    UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(0, iconView.bottom + 10, G_SCREEN_WIDTH, 15)];
    
    if (iPhone4) {
        userName.frame = CGRectMake(0, iconView.bottom + 8, G_SCREEN_WIDTH, 20);
    }
    userName.textAlignment = NSTextAlignmentCenter;
    userName.textColor = [UIColor whiteColor];
    [headerView addSubview:userName];
    userName.text = self.homeMessage.workerName;
    if (self.homeMessage.workerName.length == 0) {
        userName.text = self.homeMessage.loginName;
    }

    self.username = userName;
    
//    if ([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[[API shareAPI] getLocalData:G_HeadUrl]
//         ]) {
//        iconView.image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[[API shareAPI] getLocalData:G_HeadUrl]];
//    }
//    else{
//        // by mayan  20160426   修改加载失败图
//        [iconView sd_setImageWithURL:[NSURL URLWithString:_homeMessage.logo] placeholderImage:[UIImage imageNamed:@"logo_zhuan"]];
//        [[API shareAPI] saveLocalData:G_HeadUrl value:_homeMessage.logo];
//    }
}

#pragma mark - TableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 0) { //收益转换
        ConViewController *conVC = [ConViewController new];
        conVC.business = self.businessScore;
        conVC.share = self.shareScore;
        [self.navigationController pushViewController:conVC animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 0) { // 充值
        FulfillCardVC *controller = [[FulfillCardVC alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 1) { // 充值记录
        RecordViewController *recordVC = [[RecordViewController alloc] init];
        recordVC.type = MyAccountDetailTypeRecharge;
        [self.navigationController pushViewController:recordVC animated:YES];
    } else if (indexPath.section == 2 && indexPath.row == 0) { // 提现
        WithdrawViewController *withdrawVC = [[WithdrawViewController alloc] init];
        [self.navigationController pushViewController:withdrawVC animated:YES];
    } else if (indexPath.section == 2 && indexPath.row == 1) { // 提现记录
        RecordViewController *recordVC = [[RecordViewController alloc] init];
        recordVC.type = MyAccountDetailTypeWithdraw;
        [self.navigationController pushViewController:recordVC animated:YES];
    } else if (indexPath.section == 3 && indexPath.row == 0) { // 绑定银行卡
        BindingCardViewController *bindingVC = [[BindingCardViewController alloc] init];
        [self.navigationController pushViewController:bindingVC animated:YES];
    }
}

#pragma mark - TableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *kCellReuseIdentify = @"kCellReuseIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellReuseIdentify];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = kTextColor1;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    return cell;
}

@end
