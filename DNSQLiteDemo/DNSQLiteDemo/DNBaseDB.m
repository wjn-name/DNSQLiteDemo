//
//  DNBaseDB.m
//  DNSQLiteDemo
//
//  Created by mainone on 16/9/8.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DNBaseDB.h"

@implementation DNBaseDB

/*
 *  获取沙盒目录
 *  name:追加的目录
 *
 */
- (NSString*)DataBaseName:(NSString *)name {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [path stringByAppendingPathComponent:name];
    return fileName;
}

- (void)createTable:(NSString *)sql dataBaseName:(NSString *)dataName {
    sqlite3 *sqlite = nil;
    NSString *fileName = [self DataBaseName:dataName];
    //打开数据库
    int reslut = sqlite3_open(fileName.UTF8String, &sqlite);
    if (reslut != SQLITE_OK) {
        NSLog(@"db open failure");
    } else {
        const char *sqlCh = sql.UTF8String;
        char *error;
        int result = sqlite3_exec(sqlite, sqlCh, NULL, NULL, &error);
        if (result != SQLITE_OK) {
            NSLog(@"db create failure error : %s", error);
        } else {
            NSLog(@"db create success");
        }
        sqlite3_close(sqlite);
    }
}

- (BOOL)execSql:(NSString *)sql params:(NSArray *)params dataBaseName:(NSString *)dataName {
    sqlite3 *sqlite = nil;
    sqlite3_stmt *stmt = nil;
    // 打开数据库
    NSString *fileName = [self DataBaseName:dataName];
    int result = sqlite3_open(fileName.UTF8String, &sqlite);
    if (result != SQLITE_OK) { return NO; }
    const char *sqlCh = sql.UTF8String;
    // 编译sql语句
    sqlite3_prepare_v2(sqlite, sqlCh, -1, &stmt, NULL);
    // 绑定参数
    for (int i = 0; i < params.count; i++) {
        NSString *parm=[params objectAtIndex:i];
        sqlite3_bind_text(stmt, i+1, parm.UTF8String, -1, NULL);
    }
    // 执行sql
    result = sqlite3_step(stmt);
    // 当数据库出现异状时
    if (result == SQLITE_ERROR || result == SQLITE_MISUSE) {
        NSLog(@"exec sql failure");
        sqlite3_close(sqlite);
        return NO;
    }
    // 关闭数据库句柄
    sqlite3_finalize(stmt);
    // 关闭数据库
    sqlite3_close(sqlite);
    NSLog(@"exec sql success");
    return YES;
    
}

- (NSMutableArray *)selectSql:(NSString *)sql params:(NSArray *)params dataBaseName:(NSString *)dataName {
    sqlite3 *sqlite = nil;
    sqlite3_stmt *stmt = nil;
    //打开数据库
    NSString *fileName=[self DataBaseName:dataName];
    
    int result = sqlite3_open(fileName.UTF8String, &sqlite);
    if (result != SQLITE_OK) {
        NSLog(@"db open failure");
        return nil;
    }
    const char* sqlCh=sql.UTF8String;
    // 编译SQL语句
    sqlite3_prepare_v2(sqlite, sqlCh, -1, &stmt, NULL);
    // 绑定参数
    for (int i = 0; i < params.count; i++) {
        NSString *param=[params objectAtIndex:i];
        sqlite3_bind_text(stmt, i+1, param.UTF8String, -1, NULL);
    }
    // 执行查询语句
    result=sqlite3_step(stmt);
    
    NSMutableArray *resultData=[NSMutableArray array];
    // 遍历结果
    while (result==SQLITE_ROW) {
        NSMutableDictionary *resultRow=[NSMutableDictionary dictionary];
        // 获取字段个数
        int col_count = sqlite3_column_count(stmt);
        for (int i = 0; i < col_count; i++) {
            // 获取字段名称
            const char*columName=sqlite3_column_name(stmt,i);
            // 获取字段值
            char* columValue=(char *) sqlite3_column_text(stmt, i);
            NSString  *columkeyStr = [NSString stringWithCString:columName encoding:NSUTF8StringEncoding];
            NSString *columValueStr = [NSString stringWithCString:columValue encoding:NSUTF8StringEncoding];
            [resultRow setObject:columValueStr forKey:columkeyStr];
        }
        [resultData addObject:resultRow];
        result=sqlite3_step(stmt);
    }
    // 关闭数据库句柄
    sqlite3_finalize(stmt);
    // 关闭数据库
    sqlite3_close(sqlite);
    NSLog(@"select finished");
    return  resultData;
}

@end
