//
//  AnswerScrollView.h
//  StudyDrive
//
//  Created by Aico on 8/12/17.
//  Copyright © 2017 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerScrollView : UIView

- (instancetype)initWithFrame:(CGRect)frame WithDataArray:(NSArray *)array;

@property (nonatomic, assign, readonly)int currentPage;

@end
