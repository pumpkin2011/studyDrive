//
//  AnswerTableViewCell.m
//  StudyDrive
//
//  Created by Aico on 8/13/17.
//  Copyright © 2017 lee. All rights reserved.
//

#import "AnswerTableViewCell.h"

@implementation AnswerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.numberLabel.clipsToBounds = YES;
    self.numberLabel.layer.cornerRadius = 10;
}

@end
