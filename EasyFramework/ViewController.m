//
//  ViewController.m
//  EasyFramework
//
//  Created by 习聚 on 16/8/18.
//
//

#import "ViewController.h"
#import "ESHTTPSessionManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // [self testESHTTPSessionManagerDemo];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)testESHTTPSessionManagerDemo{
    [[ESHTTPSessionManager manager] sendRequest:@"http://ip.taobao.com/service/getIpInfo.php?ip=218.108.191.113" httpMethod:@"GET" parameters:nil requestDataType:0 progress:^(NSProgress *uploadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"success:%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure:%@", [error description]);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
