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
@property (nonatomic ,strong)RHSocketChannel *channel;
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
//    RHSocketConnectParam *params = [[RHSocketConnectParam alloc]init];
//    params.host = @"192.168.0.103";
//    params.port = 8888;
//    params.heartbeatInterval = 5;
//
//    _channel = [[RHSocketChannel alloc]initWithConnectParam:params];
//    [_channel openConnection];
//
//    @"https://juejin.im/post/5a77cb456fb9a0634e6c6c14"
}



//- (void)didRead:(id<RHSocketConnectionDelegate>)con withData:(NSData *)data tag:(long)tag{
//    NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
//
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.view endEditing:YES];
//     [_channel writeData:[@"11111" dataUsingEncoding:NSUTF8StringEncoding] timeout:5 tag:1];
//}

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
