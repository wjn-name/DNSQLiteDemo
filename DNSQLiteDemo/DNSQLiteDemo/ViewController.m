//
//  ViewController.m
//  DNSQLiteDemo
//
//  Created by mainone on 16/9/8.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "ViewController.h"
#import "UserMethod.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self saveUserInfo];
    [self loadUserInfo];
    
    UserModel *userModel = [[UserMethod shareUserMethod] findUserInfoWithUserID:@"1001" dbName:@"userinfo.sqlite"];
    NSLog(@"%@ == %@",userModel.nickName, userModel.userID);
}

- (void)saveUserInfo {
    [[UserMethod shareUserMethod] createTableWithDataBaseName:@"userinfo.sqlite"];
    UserModel *userModel = [[UserModel alloc] init];
    userModel.nickName = @"张三";
    userModel.userID = @"1001";
    userModel.age = @"18";
    userModel.vip = @"1";
    [[UserMethod shareUserMethod] addUser:userModel dbName:@"userinfo.sqlite"];
}


- (void)loadUserInfo {
    NSArray *usersArray = [[UserMethod shareUserMethod] findAllUser:@"userinfo.sqlite"];
    NSLog(@"%@", usersArray);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
