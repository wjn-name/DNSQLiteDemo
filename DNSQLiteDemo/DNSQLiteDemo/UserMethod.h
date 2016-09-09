//
//  UserMethod.h
//  DNSQLiteDemo
//
//  Created by mainone on 16/9/8.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DNBaseDB.h"
#import "UserModel.h"

@interface UserMethod : DNBaseDB

// 单利
+ (UserMethod *)shareUserMethod;

/**
 *  创建数据库
 *
 *  @param dbName 数据库名称
 */
- (void)createTableWithDataBaseName:(NSString *)dbName;

/**
 *  添加用户信息
 *
 *  @param userModel 用户信息Model
 *  @param dbName    数据库名称
 *
 *  @return 是否添加成功
 */
- (BOOL)addUser:(UserModel *)userModel dbName:(NSString *)dbName;

/**
 *  更新数据库
 *
 *  @param userModel 用户信息Model
 *  @param dbName    数据库名称
 *
 *  @return 是否更新成功
 */
- (BOOL)updateUser:(UserModel *)userModel dbName:(NSString*)dbName;

/**
 *  查找用户信息
 *
 *  @param dbName 数据库名称
 *
 *  @return 用户数组
 */
- (NSArray *)findAllUser:(NSString *)dbName;

/**
 *  查找userID对应的用户信息
 *
 *  @param userID 用户ID
 *
 *  @param dbName 数据库名称
 *
 *  @return 该用户ID对应的用户信息
 */
- (UserModel *)findUserInfoWithUserID:(NSString *)userID dbName:(NSString *)dbName;

/**
 *  删除用户信息
 *
 *  @param userModel 用户信息Model (通过model中的userID删除指定用户)
 *  @param dbName    数据库名称
 *
 *  @return 是否产出成功
 */
- (BOOL)deleteUserInfoWithUserID:(NSString *)userID dbName:(NSString *)dbName;



@end
