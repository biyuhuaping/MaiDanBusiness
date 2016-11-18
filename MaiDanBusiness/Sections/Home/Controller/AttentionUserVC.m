//
//  AttentionUserVC.m
//  DaJiaZhuanBiz
//
//  Created by Bibo on 15/1/24.
//  Copyright (c) 2015年 Bibo. All rights reserved.
//

#import "AttentionUserVC.h" //我的关注
#import "AttendBean.h"
#import "SHTableView.h"
#define TAG_LABEL_COUNT 0x001

#define TAG_LABEL_CELL1 0x101
#define TAG_LABEL_CELL2 0x102
#define TAG_IMAGE_LOGO  0x103

#define TAG_BUTTON_1    0x201
#define TAG_BUTTON_2    0x202
@interface AttentionUserVC ()<DataParseDelegate>
{
    NSString *_strTotalCount;
    NSInteger _hasNext;      //分页：是否有下一页
    int _iPage; //当前页
    UISegmentedControl *sementC;

}

@property (nonatomic, strong) SHTableView *tableView;
@property (nonatomic, strong) NSMutableArray *marrAttendList;
@property (nonatomic, strong) UIScrollView *scrollView;


@end

@implementation AttentionUserVC
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"chengse64"] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.title = @"关注用户";
    _hasNext = YES;
    [self initUI];


    [self requestDataFromNet:1];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)initUI
{
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    
    
    [self addTableview];
    
}
- (void)addTableview{
    for (int i = 0; i < 2; i++) {
        _tableView = [SHTableView tableAlertWithTitle:CGRectMake(0, 64, self.view.bounds.size.width, G_SCREEN_HEIGHT-64) andCompletionBlock:^NSInteger{
            return 1;
        } numberOfRows:^NSInteger(NSInteger section) {
            if (_tableView.dataArray.count > 0) {
                return _tableView.dataArray.count + 1;

            }
            return 0;
        } andCells:^UITableViewCell *(SHTableView *tableView, NSIndexPath *indexPath) {
            static NSString *Identifier1 = @"Identifier1";
            static NSString *Identifier2 = @"Identifier2";
            UITableViewCell *cell = nil;
            
            if (indexPath.row == 0)
            {
                _tableView.cellHeight = 60;
            }
            else
            {
                _tableView.cellHeight = 80;
            }

            if (indexPath.row == 0)
            {
                cell = [tableView dequeueReusableCellWithIdentifier:Identifier1];
                
                if (cell == nil)
                {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier1];
                    
                    
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 18, 115, 25)];
                    lable.text =     @"当前关注人数:";
                    lable.textColor = RGBCOLOR(51, 51, 51);
                    [cell.contentView addSubview:lable];
                    UILabel *Number=[Factory createLabelWithframe:CGRectMake(lable.right, 18, 25, 25) tag:0 textColor:RGBCOLOR(237, 87, 49) backgroud:[UIColor whiteColor] fontSize:16 Title:@"5"];
                    Number.tag=TAG_LABEL_COUNT;
                    Number.font = [UIFont systemFontOfSize:18];
                    Number.layer.masksToBounds=YES;
                    Number.layer.cornerRadius=5;
                    Number.textAlignment=NSTextAlignmentCenter;
                    [cell.contentView addSubview:Number];
                }
                UILabel *lbl1 = (UILabel *)[cell viewWithTag:TAG_LABEL_COUNT];
                lbl1.text = [NSString stringWithFormat:@"%@",_shopCount];;
            }
            else
            {
                cell = [tableView dequeueReusableCellWithIdentifier:Identifier2];
                
                if (cell == nil)
                {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier2];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    UIImageView *imgViewLogo = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
                    imgViewLogo.tag = TAG_IMAGE_LOGO;
                    imgViewLogo.layer.borderWidth = 1.5;
                    imgViewLogo.layer.borderColor = RGBCOLOR(247, 247, 247).CGColor;
                    imgViewLogo.layer.masksToBounds=YES;
                    imgViewLogo.layer.cornerRadius=30;
                    [cell.contentView addSubview:imgViewLogo];
                    
                    UILabel *lbl1  = [[UILabel alloc] initWithFrame:CGRectMake(imgViewLogo.right+10, 30, G_SCREEN_WIDTH - 210, 20)];
                    lbl1.tag = TAG_LABEL_CELL1;
                    lbl1.text=@"姓名";
                    lbl1.textColor = RGBCOLOR(51, 51, 51);
                    lbl1.font      = [UIFont systemFontOfSize:16];
                    [cell.contentView addSubview:lbl1];
                    
                    UILabel *lbl2  = [[UILabel alloc] initWithFrame:CGRectMake(lbl1.right + 2, 30, 100, 20)];
                    lbl2.textAlignment = NSTextAlignmentRight;
                    lbl2.tag = TAG_LABEL_CELL2;
                    lbl2.textColor=RGBCOLOR(153, 153, 153);
                    lbl2.font      = [UIFont systemFontOfSize:15];
                    [cell.contentView addSubview:lbl2];
                    
                    UILabel *textlable = [[UILabel alloc] initWithFrame:CGRectMake(0, lbl2.bottom + 20, G_SCREEN_WIDTH + 100, 10)];
                    textlable.text = @".............................................................................................................................................................";
                    textlable.textColor = RGBCOLOR(197, 197, 197);
                    textlable.font = [UIFont systemFontOfSize:10];
                    [cell addSubview:textlable];
                }
                if (_tableView.dataArray.count + 1 >=  indexPath.row) {
                    _atendbean = _tableView.dataArray[indexPath.row -1];
                }
                UIImageView *imgViewLogo = (UIImageView *)[cell viewWithTag:TAG_IMAGE_LOGO];
                [imgViewLogo sd_setImageWithURL:[NSURL URLWithString:_atendbean.logo] placeholderImage:[UIImage imageNamed:@"icon80"]];
                

                //名称
                UILabel *lbl1 = (UILabel *)[cell viewWithTag:TAG_LABEL_CELL1];
                lbl1.text = _atendbean.nickName;
                
                //邀请数
                UILabel *lbl2 = (UILabel *)[cell viewWithTag:TAG_LABEL_CELL2];
                lbl2.text = [NSString stringWithFormat:@"%@",_atendbean.phone];
            }
            return  cell;
 
        }];
        
        [self.tableView configureSelectionBlock:^(NSIndexPath *selectedIndex) {
            
        }];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollsToTop = YES;
        _tableView.dataDelagate = self;
        _tableView.tag = 3001 + i;
        [self.view addSubview:_tableView];
    }
    
//    self.tableView = (SHTableView *)[_scrollView viewWithTag:3001];
//    _tableView.scrollEnabled = YES;
}



/**
 *  获取后台数据
 */
- (void)requestDataFromNet:(int)pag
{
    __weak AttentionUserVC *weakSelf = self;
    self.marrAttendList = [NSMutableArray arrayWithCapacity:0];
    
    
        if (sementC.selectedSegmentIndex == 0) {
            [[API shareAPI] getAPI:API_Focuson pag:pag completion:^(id responseData) {
                _hasNext = NO;
                _hasNext = [responseData[@"json_val"][@"hasNext"] boolValue];
                weakSelf.shopCount = responseData[@"json_val"][@"totalCount"];
                
                if ([responseData[@"json_res"] isEqualToString:@"json_ok"]) {
                    for (NSDictionary *dic in responseData[@"json_val"][@"list"]) {
                        weakSelf.atendbean = [[AttendBean alloc] init];
                        [weakSelf.atendbean setValuesForKeysWithDictionary:dic];
                        [weakSelf.marrAttendList addObject:_atendbean];
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
            [[API shareAPI] getAPI:API_CONSUPTION  pag:pag completion:^(id responseData) {
                _hasNext = NO;
                _hasNext = [responseData[@"json_val"][@"hasNext"] boolValue];
                weakSelf.shopCount = responseData[@"json_val"][@"totalCount"];
                
                if ([responseData[@"json_res"] isEqualToString:@"json_ok"]) {
                    for (NSDictionary *dic in responseData[@"json_val"][@"list"]) {
                        weakSelf.atendbean = [[AttendBean alloc] init];
                        [weakSelf.atendbean setValuesForKeysWithDictionary:dic];
                        [weakSelf.marrAttendList addObject:_atendbean];
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
   
}



@end
