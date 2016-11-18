//
//  MDCommercialTypeViewController.m
//  MaiDan
//
//  Created by lin on 16/8/15.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "MDCommercialTypeViewController.h"

@interface MDCommercialTypeViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *subTableView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *subDataArray;

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation MDCommercialTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商户类别";
    
    self.dataArray = [NSMutableArray array];
    self.subDataArray = [NSMutableArray array];
    
    [self initUI];
    [self requestShopTypeWithParentId:@"0"];
    
}

- (void)requestShopTypeWithParentId:(NSString *)parentId {
    
    [[API shareAPI] getShopTypeWithParentId:parentId completion:^(id response) {
        NSLog(@"response = %@",response);
        if ([response[@"json_code"] isEqualToString:@"1000"]) {
            
            // 0表示一级列表
            if ([parentId isEqualToString:@"0"]) {
                
                [self.dataArray removeAllObjects];
                
                for (NSDictionary *dict in response[@"json_val"]) {
                    if ([dict[@"typeId"] integerValue] != 0) {
                        [self.dataArray addObject:dict];
                        NSDictionary *dict = self.dataArray[0];
                        [self requestShopTypeWithParentId:dict[@"typeId"]];
                    }
                }
            } else {
                
                [self.subDataArray removeAllObjects];
                [self.subDataArray addObjectsFromArray:response[@"json_val"]];
            }
        } else if ([response[@"json_code"] isEqualToString:@"1001"]) {
            if ([parentId isEqualToString:@"0"]) {
                
                [self.dataArray removeAllObjects];
            } else {
                
                [self.subDataArray removeAllObjects];
            }
        }
        
        [self.tableView reloadData];
        [self.subTableView reloadData];
    }];
    
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    [parameters setValue:parentId forKey:@"parentId"];
//    
//    XGHttpRequestInfo *info = [XGHttpRequestInfo new];
//    info.urlPath = pathGetShopType;
//    info.parameters = parameters;
//    [XG_HTTP_REQUEST_MANAGER requestWithRequestInfo:info success:^(id response) {
//        NSLog(@"response = %@",response);
//        if ([response[jcode] isEqualToString:@"1000"]) {
//            
//            // 0表示一级列表
//            if ([parentId isEqualToString:@"0"]) {
//                
//                [self.dataArray removeAllObjects];
//                [self.dataArray addObjectsFromArray:response[json_val]];
//                NSDictionary *dict = self.dataArray[0];
//                [self requestShopTypeWithParentId:dict[@"typeId"]];
//            } else {
//                
//                [self.subDataArray removeAllObjects];
//                [self.subDataArray addObjectsFromArray:response[json_val]];
//            }
//        } else if ([response[jcode] isEqualToString:@"1001"]) {
//            if ([parentId isEqualToString:@"0"]) {
//                
//                [self.dataArray removeAllObjects];
//            } else {
//                
//                [self.subDataArray removeAllObjects];
//            }
//        }
//        
//        [self.tableView reloadData];
//        [self.subTableView reloadData];
//        
//    }];
}


- (void)initUI {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 100, G_SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UITableView *subTableView = [[UITableView alloc] initWithFrame:CGRectMake(tableView.right, tableView.top, G_SCREEN_WIDTH - tableView.width, tableView.height) style:UITableViewStylePlain];
    subTableView.delegate = self;
    subTableView.dataSource = self;
    [self.view addSubview:subTableView];
    self.subTableView = subTableView;
}

#pragma mark - TableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _tableView) {
        self.currentIndex = indexPath.row;
        NSDictionary *dict = self.dataArray[indexPath.row];
        [self requestShopTypeWithParentId:dict[@"typeId"]];
    } else {
        NSDictionary *dict1 = self.dataArray[_currentIndex];
        NSDictionary *dict2 = self.subDataArray[indexPath.row];
        NSString *shopType = [NSString stringWithFormat:@"%@-%@",dict1[@"typeName"],dict2[@"typeName"]];
        !self.shopTypeBlock ? : self.shopTypeBlock(shopType,dict2[@"typeId"]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - TableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return self.dataArray.count;
    } else {
        return self.subDataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *kCellReuseIdentify = @"kCellReuseIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellReuseIdentify];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    
    NSDictionary *dict = nil;
    if (tableView == self.tableView) {
        dict = self.dataArray[indexPath.row];
        if (self.currentIndex == indexPath.row) {
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selected"]];
        } else {
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"uncheck"]];
        }
    } else {
        dict = self.subDataArray[indexPath.row];
    }
    cell.textLabel.text = dict[@"typeName"];
    
    
    return cell;
}


@end
