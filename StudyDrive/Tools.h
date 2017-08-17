//
//  Tools.h
//  StudyDrive
//
//  Created by Aico on 8/15/17.
//  Copyright © 2017 lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tools : NSObject

+ (NSArray *)getAnswerWithString:(NSString *)str;
+ (CGSize)getSizeWithString:(NSString *)str WithFont:(UIFont *)font WithSize:(CGSize)size;

@end
