//
//  SelectView.m
//  StudyDrive
//
//  Created by Aico on 7/21/17.
//  Copyright © 2017 lee. All rights reserved.
//

#import "SelectView.h"

@implementation SelectView {
    UIButton *mainButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)initWithFrame:(CGRect)frame andBtn:(UIButton *)btn{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        self.alpha = 0;
        mainButton = btn;
        [self carTypeButtons];
    }
    
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self alphaAnimationWithValue:0];
}

- (void)setAlphaToZero {
    [self alphaAnimationWithValue:0.7];
}

- (void)carTypeButtons {
    
    CGFloat gap = (self.frame.size.width - 60 * 4) / 5;
    
    for(int i=0; i<4; i++) {
        CGFloat marginLeft = i * (60 + gap) + gap;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", i+1]] forState:UIControlStateNormal];
        [self addSubview:button];
        
        [button addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:60]];
        [button addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:marginLeft]];
        
        
    }
}

- (void)buttonClicked:(UIButton *)button {
    [mainButton setImage:[button imageForState:UIControlStateNormal] forState:UIControlStateNormal];
    [self alphaAnimationWithValue:0];
}

- (void)alphaAnimationWithValue:(CGFloat)value {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = value;
    }];
}

@end
