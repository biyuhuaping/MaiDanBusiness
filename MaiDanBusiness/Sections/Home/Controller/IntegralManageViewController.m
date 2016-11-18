//
//  IntegralManageViewController.m
//  DaJiaZhuanBiz
//
//  Created by Bibo on 15/1/24.
//  Copyright (c) 2015年 Bibo. All rights reserved.
//

#import "IntegralManageViewController.h"
#import "FulfillCardVC.h"
#import "Integral.h"
#import "SHTableView.h"

#define TAG_LABEL_CELL1 1001
#define TAG_LABEL_CELL2 1002
#define TAG_LABEL_CELL3 1003
#define TAG_LABEL_CELL4 1004


#define TAG_LABEL_CELL5 010005
#define TAG_LABEL_CELL6 1006


#define TAG_IMAGE_CELL9 1009

@interface IntegralManageViewController ()<DataParseDelegate>


@property (nonatomic, strong) SHTableView *tableView;

@end

@implementation IntegralManageViewController
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"chengse64"] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"积分管理";
    
    self.marrList = [NSMutableArray arrayWithCapacity:0];
    [self initUI];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)initUI
{
    [self addTopView];
    [self addTableview];
    [self requestDataFromNet:1];

}

- (void)addTableview{
    
    //列表
    //TODO
    //添加字段
    _tableView = [SHTableView tableAlertWithTitle:CGRectMake(0, 64 + 50, G_SCREEN_WIDTH, G_SCREEN_HEIGHT - 114) andCompletionBlock:^NSInteger{
        return 1;
    } numberOfRows:^NSInteger(NSInteger section) {
        if (_tableView.dataArray > 0) {
            return _tableView.dataArray.count;
 
        }
        return 0;
    } andCells:^UITableViewCell *(SHTableView *tableView, NSIndexPath *indexPath) {
        static NSString *Identifier1 = @"Identifier1";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier1];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier1];
            
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];

            UIView *round=[Factory createViewWithBackgroundColor:RGBCOLOR(153, 136, 126) frame:CGRectMake(80, 35, 10, 10)];
            round.layer.masksToBounds=YES;
            round.layer.cornerRadius=5;
            [cell.contentView addSubview:round];
            
            UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(round.left + 3, 0, 4, 33)];
            lineView1.backgroundColor = RGBCOLOR(204, 187, 177);
            [cell.contentView addSubview:lineView1];
            
            UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(round.left + 3, 47, 4,143 -round.bottom-2)];
            lineView2.backgroundColor = RGBCOLOR(204, 187, 177);
            [cell.contentView addSubview:lineView2];
            //背景
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 10, G_SCREEN_WIDTH -  110, 133)];
            imgView.image = [UIImage imageNamed:@"jifenguanli_bg"];
            [cell.contentView addSubview:imgView];
            //时钟
            UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(33, 30, 20, 20)];
            imgView1.image = [UIImage imageNamed:@"icon_shijian"];
            [cell.contentView addSubview:imgView1];
            
          
            //时间
            UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView1.bottom + 5, 83, 40)];
            time.tag = TAG_LABEL_CELL5;
            time.numberOfLines= 2;
            time.textColor = RGBCOLOR(82, 61, 44);
            time.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
            
            time.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:time];
            
            UILabel *time1 = [[UILabel alloc] initWithFrame:CGRectMake(0, time.bottom +1, 83, 15)];
            time1.textColor = RGBCOLOR(153, 153, 153);
            time1.tag = TAG_LABEL_CELL6;
            time1.textAlignment = NSTextAlignmentCenter;
            time1.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:time1];
            
            NSArray *arry = @[@"积分:",@"单号:",@"动态:",@"来源:",@"支付方式:"];
            
            for (int i= 0;  i < 5 ;i++) {
               
                UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 6 + 25 * i, 40, 20)];
                lbl.textColor = RGBCOLOR(153, 153, 153);
                lbl.font = [UIFont systemFontOfSize:14];
                lbl.text = arry[i];
                if ( i == 4) {
                    lbl.frame =CGRectMake(20, 6 + 25 * i, 40 + 30, 20);
                    lbl.tag = 444;
                    UIImageView * imageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(lbl.right, 6 + 25 * i, 20, 20)];
                    imageV1.tag = TAG_IMAGE_CELL9;
                    [imgView  addSubview:lbl];
                    [imgView addSubview:imageV1];
                }else{
                    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(lbl.right , 6 + 25 * i, imgView.size.width - lbl.right - 10, 20)];
                    lbl1.tag = 1001 + i;
                    ;
                    lbl1.textColor = RGBCOLOR(51, 51, 51);
                    lbl1.font = [UIFont systemFontOfSize:13];
                    
                    if (i == 0){
                        lbl1.font = [UIFont systemFontOfSize:15];
                        lbl1.textColor = RGBCOLOR(235, 87, 49);
                    }
                    [imgView  addSubview:lbl];
                    [imgView addSubview:lbl1];
                }
               
                

            }
        }
        
        
        if (_tableView.dataArray.count >= indexPath.row) {
            _integral = [_tableView.dataArray objectAtIndex:indexPath.row];
        }else{
            return nil;
        }
        
        if (_integral.createtime.length) {
            
            NSArray *array = [_integral.createtime componentsSeparatedByString:@"-"]; //从字符A中分隔成2个元素的数组
            NSArray *array1 = [array[2] componentsSeparatedByString:@" "]; //从字符A中分隔成2个元素的数组
            
            UILabel *lbl5 = (UILabel *)[cell viewWithTag:TAG_LABEL_CELL5];
            lbl5.text = [NSString stringWithFormat:@"%@\n%@/%@", array[0],array[1],array1[0]] ;
            UILabel *lbl6 = (UILabel *)[cell viewWithTag:TAG_LABEL_CELL6];
            lbl6.text = [NSString stringWithFormat:@"%@", array1[1]];
        }
        
        UILabel *lbl1 = (UILabel *)[cell viewWithTag:TAG_LABEL_CELL1];
        lbl1.text = [NSString stringWithFormat:@"%@",_integral.score];
        
        UILabel *lbl2 = (UILabel *)[cell viewWithTag:TAG_LABEL_CELL2];
        lbl2.text = [NSString stringWithFormat:@"%@",_integral.recid];
        
        UILabel *lbl3 = (UILabel *)[cell viewWithTag:TAG_LABEL_CELL3];
        lbl3.text = [NSString stringWithFormat:@"%@", _integral.source];
        
        UILabel *lbl4 = (UILabel *)[cell viewWithTag:TAG_LABEL_CELL4];
        lbl4.text = [NSString stringWithFormat:@"%@",_integral.memo ];

        UILabel *lbl5 = (UILabel *)[cell viewWithTag:444];
        UIImageView *imageV = (UIImageView *)[cell viewWithTag:TAG_IMAGE_CELL9];
        
        if ([_integral.paytype intValue] == 1) {
            imageV.image = [UIImage imageNamed:@"dingdan_xj"];
            lbl5.hidden = NO;
        }
        else if ([_integral.paytype intValue] == 2) {
            imageV.image = [UIImage imageNamed:@"dingdan_fxb"];
            lbl5.hidden = NO;
            
        }
        else if ([_integral.paytype intValue] == 3) {
            imageV.image  = [UIImage imageNamed:@"dingdan_zfb"];
            lbl5.hidden = NO;
            
        }
        else if ([_integral.paytype intValue] ==4) {
            imageV.image  = [UIImage imageNamed:@"dingdan_wx"];
            lbl5.hidden = NO;
            
        }
        else if ([_integral.paytype intValue]== 5){
            imageV.image  = [UIImage imageNamed:@"dingdan_jf"];
            lbl5.hidden = NO;
            
        }else{
//            imageV.image = [UIImage imageNamed:@"dingdan_jf"];
            lbl5.hidden = YES;
        }



        return  cell;

    }];
   
    [_tableView configureSelectionBlock:^(NSIndexPath *selectedIndex) {
        
    }];
    
    _tableView.dataDelagate =self;
    _tableView.cellHeight = 143;
    
    _tableView.backgroundColor = RGBCOLOR(242, 242, 242);
    _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];

}
- (void)addTopView
{
    
    
    
    //账户信息视图
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, G_SCREEN_WIDTH, 50)];
    topView.backgroundColor = [UIColor whiteColor];
    [topView setUserInteractionEnabled:YES];
    [self.view addSubview:topView];
    
    for (int i = 0; i < 2; i ++) {
        UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake( i * G_SCREEN_WIDTH/2, 8, G_SCREEN_WIDTH/2 - 2, 20)];
        lb1.textAlignment = NSTextAlignmentCenter;
        lb1.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:19];
        UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake( i * G_SCREEN_WIDTH/2, lb1.bottom + 1 , G_SCREEN_WIDTH/2 - 2, 15)];
        lb2.textAlignment = NSTextAlignmentCenter;
        lb2.textColor = RGBCOLOR(153, 153, 153);
        lb2.font = [UIFont systemFontOfSize:12];
        
        NSString *price;
        NSMutableAttributedString *mAtrrString;
        
        NSDictionary *consumDic1 =  @{NSFontAttributeName :[UIFont fontWithName:@"HelveticaNeue-Bold" size:24],NSForegroundColorAttributeName:RGBCOLOR(82, 61, 44)};
        NSDictionary *consumDic2 = @{NSFontAttributeName :[UIFont fontWithName:@"HelveticaNeue-Bold" size:12],NSForegroundColorAttributeName:RGBCOLOR(82, 61, 44)};
        if ( i == 0) {
            price =[NSString stringWithFormat:@"%.2f",[self.operatingIncome floatValue]];
            NSRange range = [price rangeOfString:@"."];//匹配得到的下标
            mAtrrString= [[NSMutableAttributedString alloc] initWithString:price attributes:consumDic1];
            [mAtrrString  addAttributes:consumDic2 range:NSMakeRange(range.location + 1,2)];
            lb1.attributedText = mAtrrString;
            lb2.text = @"营业收入";
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(G_SCREEN_WIDTH/2-1, 8, 1, 35)];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [topView addSubview:lineView];
            //
        }else if (i== 1){
            price =[NSString stringWithFormat:@"%.2f",[self.benefitSharing floatValue]];
            NSRange range1 = [price rangeOfString:@"."];//匹配得到的下标
            mAtrrString = [[NSMutableAttributedString alloc] initWithString:price attributes:consumDic1];
            [mAtrrString  addAttributes:consumDic2 range:NSMakeRange(range1.location + 1,2)];
            lb1.attributedText = mAtrrString;
            
            lb2.text = @"分享收益";
        }
        [topView addSubview:lb1];
        [topView addSubview:lb2];
    }
  
    
}


- (void)fullFillCard
{
    FulfillCardVC *controller = [[FulfillCardVC alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

/**
 *  获取后台数据
 */
- (void)requestDataFromNet:(int)pag
{
    __weak IntegralManageViewController *weakSelf = self;
    self.marrList = [NSMutableArray array];
       
    [[API shareAPI] getAPI:API_ScoreList pag:pag completion:^(id responseData) {
        //判断是否有下一页
        NSString *strTemp = responseData[@"json_val"][@"hasNext"];
        
        if ([responseData[@"json_res"] isEqualToString:@"json_ok"]) {
            for (NSDictionary *dic in responseData[@"json_val"][@"list"]) {
                weakSelf.integral = [[Integral alloc] init];
                [weakSelf.integral setValuesForKeysWithDictionary:dic];
                [weakSelf.marrList addObject:_integral];
            }
        }
        
        if (pag == 1) {
            
            self.tableView.dataArray = nil;
            self.tableView.dataArray = _marrList;
        } else {
            [self.tableView.dataArray addObjectsFromArray:_marrList];
        }
        weakSelf.tableView.hastNext = [strTemp intValue];
    }];

}




@end
