//
//  UserMethod.m
//  DNSQLiteDemo
//
//  Created by mainone on 16/9/8.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "UserMethod.h"
// 8 ~ 14
@implementation UserMethod

+ (UserMethod *)shareUserMethod {
    static dispatch_once_t pred;
    static UserMethod *_shareUserMethod=nil;
    dispatch_once(&pred,^{
        _shareUserMethod =[[UserMethod alloc] init];
    });
    return _shareUserMethod;
}

- (void)createTableWithDataBaseName:(NSString *)dbName {
    NSString *sql = @"create table user (nickName text, userID text, age text, vip text)";
    [self createTable:sql dataBaseName:dbName];
}

- (BOOL)addUser:(UserModel *)userModel dbName:(NSString *)dbName {

    // 如果表中存在该用户就直接更新数据
    UserModel *usersM = [self findUserInfoWithUserID:userModel.userID dbName:dbName];
    if (usersM) {
        BOOL upSuccess = [self updateUser:userModel dbName:dbName];
        return upSuccess;
    }
    
    NSString *sql = @"insert into user (nickName, userID, age, vip) values (?, ?, ?, ?)";
    NSArray *params = @[userModel.nickName, userModel.userID, userModel.age, userModel.vip];
    return  [self execSql:sql params:params dataBaseName:dbName];
}

- (BOOL)updateUser:(UserModel *)userModel dbName:(NSString *)dbName {
    NSString *sql=@"update user set nickName = ?, userID = , age = ?, vip = ? where userID = ?";
    NSArray *params=@[userModel.nickName, userModel.userID, userModel.age, userModel.vip, userModel.userID];
    return [self execSql:sql params:params dataBaseName:dbName];
}

- (NSArray *)findAllUser:(NSString *)dbName {
    NSString *sql = @"select nickName, userID, age, vip from user";
    NSArray *result = [self selectSql:sql params:nil dataBaseName:dbName];
    NSMutableArray *users = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in result) {
        UserModel *user = [[UserModel alloc] init];
        user.nickName   = [dict objectForKey:@"nickName"];
        user.userID     = [dict objectForKey:@"userID"];
        user.age        = [dict objectForKey:@"age"];
        user.vip        = [dict objectForKey:@"vip"];
        [users addObject:user];
    }
    return users;
}

- (UserModel *)findUserInfoWithUserID:(NSString *)userID dbName:(NSString *)dbName{
    NSString *sql = @"select * from user where userID = ?";
    NSArray *params = @[userID];
    NSArray *result = [self selectSql:sql params:params dataBaseName:dbName];
    if (result.count == 0) {
        return nil;
    }
    NSDictionary *dict = result[0];
    UserModel *user = [[UserModel alloc] init];
    user.nickName   = [dict objectForKey:@"nickName"];
    user.userID     = [dict objectForKey:@"userID"];
    user.age        = [dict objectForKey:@"age"];
    user.vip        = [dict objectForKey:@"vip"];
    return user;
}

- (BOOL)deleteUserInfoWithUserID:(NSString *)userID dbName:(NSString *)dbName {
    NSString *sql = @"delete from user where userID = ?";
    NSArray *params = @[userID];
    return [self execSql:sql params:params dataBaseName:dbName];
}

@end
