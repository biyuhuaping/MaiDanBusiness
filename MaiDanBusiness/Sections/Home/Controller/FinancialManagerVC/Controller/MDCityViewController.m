//
//  MDCityViewController.m
//  MaiDan
//
//  Created by lin on 16/9/29.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "MDCityViewController.h"
#import "MDRegionViewController.h"

@interface MDCityViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation MDCityViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"chengse64"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择城市";
    self.dataArray = [NSMutableArray array];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, G_SCREEN_WIDTH, G_SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self requestAllCityByProvinceId];
    
}

- (void)requestAllCityByProvinceId {
    
    [[API shareAPI] getAllCityWithProvinceId:self.provinceId completion:^(id responseData) {
        if ([responseData[@"json_code"] isEqualToString:@"1000"]) {
            [self.dataArray addObjectsFromArray:responseData[@"json_val"]];
            [self.tableView reloadData];
        } else {
            [SVProgressHUD showErrorWithStatus:responseData[@"json_error"]];
        }
    }];
}

#pragma mark - TableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *cityDict = self.dataArray[indexPath.row];
    
    MDRegionViewController *regionVC = [MDRegionViewController new];
    regionVC.provinceName = self.provinceName;
    regionVC.cityId = cityDict[@"id"];
    regionVC.cityName = cityDict[@"cityName"];
    [self.navigationController pushViewController:regionVC animated:YES];
}

#pragma mark - TableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *kCellReuseIdentify = @"kCellReuseIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellReuseIdentify];
        cell.textLabel.font = FONT_WITH_SIZE(14);
        cell.textLabel.textColor = kTextColor1;
    }
    NSDictionary *cityDict = self.dataArray[indexPath.row];
    cell.textLabel.text = cityDict[@"cityName"];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
