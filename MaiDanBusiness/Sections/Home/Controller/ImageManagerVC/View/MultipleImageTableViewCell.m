//
//  MultipleImageTableViewCell.m
//  MaiDanSH
//
//  Created by lin on 16/10/12.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "MultipleImageTableViewCell.h"
#import "UIButton+WebCache.h"

@implementation MultipleImageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 店铺图片
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 20)];
    titleLabel.text = @"店铺图片";
    titleLabel.textColor = kTextColor2;
    titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:titleLabel];
    
    // 图片列表
    for (NSInteger i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15 + (60 + 15) * i, titleLabel.bottom + 15, 60, 60)];
        imageView.image = [UIImage imageNamed:@"add_image"];
        imageView.tag = 100 + i;
        imageView.userInteractionEnabled = YES;
        
        // 添加轻击手势
        [imageView bk_whenTapped:^{
            !self.tapBlock ? : self.tapBlock(imageView);
        }];
        
        // 添加长按手势
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            // 防止手势重复执行
            if (state == UIGestureRecognizerStateBegan) {
                !self.longPressBlock ? : self.longPressBlock(imageView);
            }
        }];
        [imageView addGestureRecognizer:longPress];
        [self.contentView addSubview:imageView];
    }
    
    // 小提示
    UILabel *tips = [[UILabel alloc] initWithFrame:CGRectMake(15, titleLabel.bottom + 15 + 60 + 10, G_SCREEN_WIDTH - 30, 30)];
    tips.text = @"小提示：店铺图片长按可以删除哦，上传图片后记得保存！";
    tips.textColor = kTextColor3;
    tips.font = FONT_WITH_SIZE(12);
    tips.numberOfLines = 0;
    [self.contentView addSubview:tips];
}

- (void)updateCellLayoutWithImages:(NSArray *)images {
    
    for (NSInteger i = 0; i < 4; i++) {
        UIImageView *imageView = (UIImageView *)[self viewWithTag:100 + i];
        
        
        if (i < images.count) {
            imageView.hidden = NO;
            NSString *imageName = [images[i] allValues].firstObject;
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"add_image"]];
        } else if (images.count == i) {
            imageView.hidden = NO;
            imageView.image = [UIImage imageNamed:@"add_image"];
        } else {
            imageView.hidden = YES;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
