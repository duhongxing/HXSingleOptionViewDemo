//
//  BTTestSelfView.h
//  UnitTestDemoTests
//
//  Created by MacOS on 17/7/21.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTTestQuestionsItem.h"

@interface BTTestSelfView : UIView

@property (nonatomic,strong)BTTestQuestionsItem *question;

//选择结果
@property (nonatomic,copy)void(^selectBlock)(BTTestSelfView *, NSString *);

@end
