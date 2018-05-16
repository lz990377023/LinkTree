//
//  MOCALoginVC.m
//  LinkTree
//
//  Created by 李沾 on 2018/5/1.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import "MOCALoginVC.h"
#import <RHSocketKit/RHSocketConnectParam.h>
#import <RHSocketKit/RHSocketChannel.h>
@interface MOCALoginVC ()<RHSocketConnectionDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *backgView;

@end

@implementation MOCALoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _backgView.layer.cornerRadius = 8;
    _backgView.layer.masksToBounds = YES;
    [self connetScoket];
    // Do any additional setup after loading the view from its nib.
}


- (void)connetScoket{
    RHSocketConnectParam *params = [[RHSocketConnectParam alloc]init];
    params.host = @"127.0.0.1";
    params.port = 20162;
    params.heartbeatInterval = 5;
    
    RHSocketChannel *channel = [[RHSocketChannel alloc]initWithConnectParam:params];
    [channel openConnection];
    
}

- (void)writeData:(NSData *)data timeout:(NSTimeInterval)timeout tag:(long)tag{
    NSLog(@"%@",data);
}





- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
