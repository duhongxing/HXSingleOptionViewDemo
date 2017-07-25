//
//  TestSelfViewController.m
//  UnitTestDemoTests
//
//  Created by MacOS on 17/7/20.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import "TestSelfViewController.h"

//自测结果
#import "TestResultViewController.h"

//自测视图
#import "BTTestSelfView.h"

#import "BTOptionItem.h"

#define SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)

#define SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)

@interface TestSelfViewController ()

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)BTTestSelfView *testSelfView;

@property (nonatomic,strong)UILabel *alertLab;

@end

@implementation TestSelfViewController
{
    int indexQuestion;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];

    indexQuestion = 0;

    self.title = @"自身测评";
    [self getDataArrayWithIndex:indexQuestion];

    [self.view addSubview:self.testSelfView];
    [self.view addSubview:self.alertLab];

    self.testSelfView.question = self.dataArray[0];


    __weak typeof(self) weakSelf = self;

    __block int wkIndex = indexQuestion;

    self.testSelfView.selectBlock = ^(BTTestSelfView *currentView,NSString *result){

        wkIndex++;

        if (wkIndex > 4) {

            NSLog(@"%d",wkIndex);

            TestResultViewController *resultVC =[[TestResultViewController alloc]init];
            [weakSelf.navigationController pushViewController:resultVC animated:YES];

        }else{
            [weakSelf getDataArrayWithIndex:wkIndex];
            weakSelf.testSelfView.question = [weakSelf.dataArray lastObject];
        }

        NSLog(@"选择的结果: --> %@",result);

        NSLog(@"%d",wkIndex);
    };

}




#pragma mark ======== 获取数据 ============

- (void)getDataArrayWithIndex:(int)index{

    NSMutableArray *randomArr =[NSMutableArray array];

    for (int i =0 ; i < 5; i++) {

        BTTestQuestionsItem *questionItem =[[BTTestQuestionsItem alloc]init];
        NSMutableArray *array =[NSMutableArray array];

        for (int i = 0; i < 4 ; i++) {

            NSString *option = nil;
            switch (i) {
                case 0:
                    option = @"A";
                    break;
                case 1:
                    option = @"B";
                    break;
                case 2:
                    option = @"C";
                    break;
                case 3:
                    option = @"D";
                    break;

                default:
                    break;
            }

            BTOptionItem *item = [[BTOptionItem alloc]init];
            item.option = option;
            item.optionContent = @[@"刚刚毕业或将要毕业",@"工作有一阵子了",@"都记不清楚",@"认真选择刚刚毕业或将要毕业"][i];
            [array addObject:item];
        }
        
        questionItem.questionTitle = @[@"1.今天学习了吗?",@"2.今天学习了!",@"3.今天不学习了!",@"4.今天还学习了!",@"5.今天要学习了!"][i];
        questionItem.optionsArr = array;

        [randomArr addObject:questionItem];
    }


    if (self.dataArray.count) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObject:randomArr[index]];
    }else{
        [self.dataArray addObject:randomArr[index]];
    }


}

#pragma mark ======= getter 属性 ===========

- (BTTestSelfView *)testSelfView{
    if (_testSelfView == nil) {
        _testSelfView =[[BTTestSelfView alloc]initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH - 20, SCREEN_HEIGHT - 40 - 64 - 50)];
    }
    return _testSelfView;
}

- (UILabel *)alertLab{
    if (!_alertLab) {
        _alertLab =[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.testSelfView.bounds) - 50,CGRectGetWidth(self.testSelfView.bounds), 30)];
        _alertLab.text = @"请认真选择答案,测评会更加准确";
        _alertLab.textColor =[UIColor redColor];
        _alertLab.textAlignment = NSTextAlignmentCenter;
        _alertLab.font = [UIFont systemFontOfSize:14];
    }
    return _alertLab;
}


- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
