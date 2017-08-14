//
//  AnswerTableViewCell.h
//  StudyDrive
//
//  Created by Aico on 8/13/17.
//  Copyright © 2017 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *numberImage;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

@end
