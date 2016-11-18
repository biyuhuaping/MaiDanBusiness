//
//  MDRegionViewController.m
//  MaiDan
//
//  Created by lin on 16/9/29.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "MDRegionViewController.h"

@interface MDRegionViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MDRegionViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"chengse64"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择区域";
    self.dataArray = [NSMutableArray array];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, G_SCREEN_WIDTH, G_SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self requestAllRegionByCityId];
    
}


- (void)requestAllRegionByCityId {
    
    [[API shareAPI] getAllRegionWithCityId:self.cityId completion:^(id responseData) {
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
    
    NSDictionary *regionDict = self.dataArray[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kSelectAddress" object:self userInfo:@{@"province" : self.provinceName,@"city" : self.cityName, @"region" : regionDict[@"regionName"]}];
    NSArray *viewControllers = self.navigationController.viewControllers;
    [self.navigationController popToViewController:[viewControllers objectAtIndex:viewControllers.count - 4] animated:YES];
    
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
    NSDictionary *regionDict = self.dataArray[indexPath.row];
    cell.textLabel.text = regionDict[@"regionName"];
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
