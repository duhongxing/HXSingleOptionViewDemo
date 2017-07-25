//
//  BTTestQuestionsItem.h
//  HXSingleOptionViewDemo
//
//  Created by MacOS on 17/7/24.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTOptionItem.h"

@interface BTTestQuestionsItem : NSObject

@property (nonatomic,copy)NSString *questionTitle;

@property (nonatomic,strong)NSArray<BTOptionItem *> *optionsArr;

@end
