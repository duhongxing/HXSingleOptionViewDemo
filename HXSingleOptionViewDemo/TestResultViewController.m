//
//  TestResultViewController.m
//  UnitTestDemoTests
//
//  Created by MacOS on 17/7/20.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import "TestResultViewController.h"


@interface TestResultViewController ()

//重测
@property (nonatomic,strong)UIButton *reTest;
//反馈
@property (nonatomic,strong)UIButton *feedBack;

//自测结果
@property (nonatomic,strong)UIView *resultView;
//建议
@property (nonatomic,strong)UILabel *aviceLab;

//连线老师
@property (nonatomic,strong)UIButton *callButton;
//免费测评
@property (nonatomic,strong)UIButton *freeTest;

@end

@implementation TestResultViewController


#pragma mark -==========life cycle =======

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"测评结果";
    [self setupUI];

}

#pragma mark -=========== event response ======

- (void)btnClickAction:(UIButton *)sender{

    NSLog(@"%@",sender.titleLabel.text);

}

#pragma mark -======== 界面布局 ====

- (void)setupUI{

    [self.view addSubview:self.reTest];

    [self.view addSubview:self.feedBack];

    [self.view addSubview:self.resultView];

    [self.view addSubview:self.aviceLab];

    [self.view addSubview:self.callButton];

    [self.view addSubview:self.freeTest];
}

#pragma mark -======= getter 属性 =====

- (UIButton *)reTest{
    if (_reTest == nil) {
        _reTest =[[UIButton alloc]initWithFrame:CGRectMake(10, 30, 80, 40)];
        [_reTest setTitle:@"再测一次" forState:UIControlStateNormal];
        [_reTest setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_reTest.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_reTest addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reTest;
}

- (UIButton *)feedBack{
    if (_feedBack == nil) {
        _feedBack =[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds) - 90, 30, 80, 40)];
        [_feedBack setTitle:@"反馈" forState:UIControlStateNormal];
        [_feedBack setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_feedBack.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_feedBack addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _feedBack;
}


- (UIView *)resultView{
    if (!_resultView) {
        _resultView =[[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.reTest.frame) + 10,CGRectGetWidth(self.view.bounds) - 40, 100)];
        UILabel *resultLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, _resultView.bounds.size.width - 20, _resultView.bounds.size.height - 20)];
        resultLab.text = @"刚接触考试，比较有信心，有时间学习，可以尝试自学";
        resultLab.font = [UIFont systemFontOfSize:20];
        resultLab.textColor =[UIColor blackColor];
        resultLab.numberOfLines = 0;
        _resultView.layer.borderWidth = 1;
        _resultView.layer.borderColor =[UIColor darkGrayColor].CGColor;
        [_resultView addSubview:resultLab];
    }
    return _resultView;
}

- (UILabel *)aviceLab{
    if (!_aviceLab) {
        _aviceLab =[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.resultView.frame) + 10,CGRectGetWidth(self.view.bounds) - 40, 100)];
        _aviceLab.text = @"官方建议:\n  刚接触考试，比较有信心，有时间学习，可以尝试自学";
        _aviceLab.font = [UIFont systemFontOfSize:20];
        _aviceLab.textColor =[UIColor blackColor];
        _aviceLab.numberOfLines = 0;
    }
    return _aviceLab;
}

- (UIButton *)callButton{
    if (_callButton == nil) {
        _callButton =[[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetHeight(self.view.bounds) - 70 -64, 80, 40)];
        [_callButton setTitle:@"连线老师" forState:UIControlStateNormal];
        [_callButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_callButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_callButton.layer setBorderWidth:1];
        [_callButton.layer setBorderColor:[UIColor darkGrayColor].CGColor];
        [_callButton addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _callButton;
}

- (UIButton *)freeTest{
    if (_freeTest == nil) {
        _freeTest =[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds) - 90, CGRectGetHeight(self.view.bounds) - 70 -64, 80, 40)];
        [_freeTest setTitle:@"免费评测" forState:UIControlStateNormal];
        [_freeTest setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_freeTest.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_freeTest.layer setBorderWidth:1];
        [_freeTest.layer setBorderColor:[UIColor darkGrayColor].CGColor];
        [_freeTest addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _freeTest;
}



@end
