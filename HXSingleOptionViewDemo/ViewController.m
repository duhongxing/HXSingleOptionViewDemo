//
//  ViewController.m
//  HXSingleOptionViewDemo
//
//  Created by MacOS on 17/7/21.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import "ViewController.h"
#import "TestSelfViewController.h"

#import "HXHttpTool.h"

@interface ViewController ()<UIAlertViewDelegate>

@end

@implementation ViewController

#pragma mark ================= life cycle 生命周期 ===================

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.tintColor =[UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor =[UIColor blueColor];

    self.title = @"单项选择";

    [self showAlert];

}

- (IBAction)clickButton:(id)sender {

    [self showAlert];

}


- (void)showAlert{
    UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:nil message:@"亲爱的同学:\n89天后考试，您共查看过 3 段视频， 2 套试题！对于学习是不是有些盲目，我们开始评测一下吧!" delegate:self cancelButtonTitle:@"算了" otherButtonTitles:@"开始", nil];

    [alertView show];
}


#pragma mark ===================== delegate 视图代理方法 =================

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        TestSelfViewController *testVC =[[TestSelfViewController alloc]init];
        [self.navigationController pushViewController:testVC animated:YES];
    }
}

#pragma mark =========== test method =======

- (void)testFunc{
    //登录请求
    [HXHttpTool loginWithUserName:@"183xxxx1905" Password:@"111111" success:^(id response) {

        NSLog(@"%@",response);

    } failure:^(NSError *error) {

        NSLog(@"%@",error);
        
    }];
}


@end
