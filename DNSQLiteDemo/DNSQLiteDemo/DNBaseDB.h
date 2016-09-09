//
//  DNBaseDB.h
//  DNSQLiteDemo
//
//  Created by mainone on 16/9/8.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface DNBaseDB : NSObject

/**
 *  创建表
 *
 *  @param sql      执行的sql语句
 *  @param dataName 数据库名称
 */
- (void)createTable:(NSString *)sql dataBaseName:(NSString *)dataName;

/**
 *  执行sql语句, 完成增加、删除、修改
 *
 *  @param sql      执行的sql语句
 *  @param params   sql语句中的参数
 *  @param dataName 数据库名称
 */
- (BOOL)execSql:(NSString *)sql params:(NSArray *)params dataBaseName:(NSString *)dataName;

/**
 *  数据库查询
 *
 *  @param sql      查询的sql语句
 *  @param params   查询sql语句中的参数
 *  @param dataName 查询数据库名称
 *
 *  @return 查询结果
 */
- (NSMutableArray *)selectSql:(NSString *)sql params:(NSArray *)params dataBaseName:(NSString *)dataName;
@end
