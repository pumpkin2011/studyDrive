//
//  SheetView.h
//  StudyDrive
//
//  Created by Aico on 8/31/17.
//  Copyright © 2017 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SheetViewDelegate <NSObject>

- (void)sheetViewClick:(int)index;

@end

@interface SheetView : UIView {
    @public
    UIView *_backView;
}

@property (nonatomic, assign) id<SheetViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame WithSuperView:(UIView *)superView AndQuestionsCount:(int)num;

@end
