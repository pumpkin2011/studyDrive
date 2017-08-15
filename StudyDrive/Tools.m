//
//  Tools.m
//  StudyDrive
//
//  Created by Aico on 8/15/17.
//  Copyright © 2017 lee. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+ (NSArray *)getAnswerWithString:(NSString *)str {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *arr = [str componentsSeparatedByString:@"<BR>"];
    [array addObject:arr[0]];
    for (int i=0; i<4; i++) {
        [array addObject:[arr[i+1] substringFromIndex:2]];
    }
    return array;
}

@end
