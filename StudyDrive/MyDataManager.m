//
//  MyDataManager.m
//  StudyDrive
//
//  Created by Aico on 7/31/17.
//  Copyright © 2017 lee. All rights reserved.
//

#import "MyDataManager.h"
#import "FMDatabase.h"
#import "TestSelectModel.h"

@implementation MyDataManager

+ (NSArray *)getData:(DataType)type {
    static FMDatabase *dataBase;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if (dataBase == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"sqlite"]; // 先获取路径
        dataBase = [[FMDatabase alloc] initWithPath:path];
    }
    if ([dataBase open]) {
        NSLog(@"open success!");
    } else {
        return array;
    }
    
    switch (type) {
        case chapter:
        {
            NSString *sql = @"select pid,pname,pcount FROM firstlevel";
            FMResultSet *rs = [dataBase executeQuery:sql];
            while ([rs next]) {
                TestSelectModel *model = [[TestSelectModel alloc] init];
                model.pid = [NSString stringWithFormat:@"%d", [rs intForColumn:@"pid"]];
                model.pname = [rs stringForColumn:@"pname"];
                model.pcount = [NSString stringWithFormat:@"%d", [rs intForColumn:@"pcount"]];
                [array addObject:model];
            }
        }
            break;
            
        default:
            break;
    }
    return array;
}

@end
