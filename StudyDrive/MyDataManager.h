//
//  MyDataManager.h
//  StudyDrive
//
//  Created by Aico on 7/31/17.
//  Copyright © 2017 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    chapter, //章节练习数据
    answer   // 答案
} DataType;

@interface MyDataManager : NSObject

+ (NSArray *)getData:(DataType)type;


@end
