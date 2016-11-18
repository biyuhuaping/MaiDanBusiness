//
//  HomeMessage.m
//  DaJiaZhuanSH
//
//  Created by feng on 15/10/9.
//  Copyright © 2015年 feng. All rights reserved.
//

#import "HomeMessage.h"

@implementation HomeMessage
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        self.workerid = value;
    }
    
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _shopName];
}

@end
