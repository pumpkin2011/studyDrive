//
//  AnswerViewController.h
//  StudyDrive
//
//  Created by Aico on 8/14/17.
//  Copyright © 2017 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AnswerViewControllerDelegate <NSObject>

- (void)refreshMainTableData;

@end

@interface AnswerViewController : UIViewController

@property (nonatomic, assign)NSInteger number;

@property (nonatomic, assign)id delegate;

@end
