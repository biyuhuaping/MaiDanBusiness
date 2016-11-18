
//
//  FeedBackViewController.m
//  MaiDanSH
//
//  Created by lin on 16/10/22.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "FeedBackViewController.h"
#import "PlaceholderTextView.h"

@interface FeedBackViewController ()

@property (weak, nonatomic) IBOutlet PlaceholderTextView *feedbackView;
@end

@implementation FeedBackViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"chengse64"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"意见反馈";
    self.view.backgroundColor = kBackgroundColor;
    self.feedbackView.placeholder = @"您的意见是我们进步的动力，我们携手共创大业，让天下没有难赚的钱！";
}

- (IBAction)submitBtnClick {
    
    if (!self.feedbackView.text.length) {
        [SVProgressHUD showErrorWithStatus:@"说点什么再提交吧！"];
        return;
    }
    
    [[API shareAPI] feedBackWithMessage:self.feedbackView.text completion:^(id responseData) {
        if ([responseData[@"json_code"] isEqualToString:@"1000"]) {
            BOOL success = [responseData[@"json_val"] boolValue];
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"提交成功，感谢您的反馈！"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            } else {
                [SVProgressHUD showErrorWithStatus:@"提交失败，请稍后重试！"];
            }
        } else {
            [SVProgressHUD showErrorWithStatus:responseData[@"json_error"]];
        }
    }];
}


@end
