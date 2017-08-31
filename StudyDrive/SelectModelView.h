//
//  SelectModelView.h
//  StudyDrive
//
//  Created by Aico on 8/30/17.
//  Copyright © 2017 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum SelectModel {
    testModel,
    lookingModel
}SelectModel;

typedef void (^SelectTouch)(SelectModel model);

@interface SelectModelView : UIView

@property (nonatomic, assign)SelectModel model;

- (SelectModelView *)initWithFrame:(CGRect)frame addTouch:(SelectTouch)touch;

@end
