//
//  SheetView.m
//  StudyDrive
//
//  Created by Aico on 8/31/17.
//  Copyright © 2017 lee. All rights reserved.
//

#import "SheetView.h"

@interface SheetView(){
    UIView *_backView;
    UIView *_superView;
    BOOL _startMoving;
    float _height;
    float _width;
    float _y;
}
@end

@implementation SheetView

- (instancetype)initWithFrame:(CGRect)frame WithSuperView:(UIView *)superView {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _height = frame.size.height;
        _width = frame.size.width;
        _y = frame.origin.y;
        _superView = superView;
        [self createView];
    }
    return self;
}

- (void)createView {
    _backView = [[UIView alloc] initWithFrame:_superView.frame];
    _backView.backgroundColor = [UIColor greenColor];
    _backView.alpha = 0;
    [_superView addSubview:_backView];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:[touch view]];
    if (point.y < 25) {
        _startMoving = YES;
    }
    if (_startMoving && self.frame.origin.y >= _y-_height) {
        CGPoint point2 = [self convertPoint:point toView:_superView];
        self.frame = CGRectMake(0, point2.y, _width, _height);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _startMoving = NO;
    void(^action)();
    if (self.frame.origin.y > _y-_height/2) {
        action = ^{
            self.frame = CGRectMake(0, _y, _width, _height);
        };
    } else {
        action = ^{
            self.frame = CGRectMake(0, _y-_height, _width, _height);
        };
    }
    [UIView animateWithDuration:0.3 animations:^{
        action();
    }];
}

@end
