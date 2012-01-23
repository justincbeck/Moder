//
//  ModerMainView.m
//  Moder
//
//  Created by Justin Beck on 1/12/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import "ModerMainView.hpp"
#import "TouchableView.hpp"

@implementation ModerMainView

@synthesize debugView = _debugView;

@synthesize currentLetterLabel = _currentLetterLabel;
@synthesize currentTextTextView = _currentTextTextView;
@synthesize touchView = _touchView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _currentLetterLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 380.0f)];
        _currentLetterLabel.font = [UIFont fontWithName:@"Arial" size:300.0f];
        _currentLetterLabel.adjustsFontSizeToFitWidth = YES;
        _currentLetterLabel.textAlignment = UITextAlignmentCenter;
        _currentLetterLabel.numberOfLines = 0;
        _currentLetterLabel.lineBreakMode = UILineBreakModeWordWrap;
        [self addSubview:_currentLetterLabel];
        
        _debugView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 40.0f)];
        _debugView.backgroundColor = [UIColor clearColor];
        _debugView.font = [UIFont fontWithName:@"Arial" size:12.0f];
        _debugView.adjustsFontSizeToFitWidth = YES;
        _debugView.textAlignment = UITextAlignmentCenter;
        _debugView.numberOfLines = 0;
        _debugView.lineBreakMode = UILineBreakModeWordWrap;
        [self addSubview:_debugView];
        
        _currentTextTextView = [[UITextView alloc] initWithFrame:CGRectMake(0.0f, 380.0f, 320.0f, 100.0f)];
        [self addSubview:_currentTextTextView];
        
        _touchView = [[TouchableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)];
        _touchView.alpha = 0.5f;

        [self addSubview:_touchView];
    }
    return self;
}

@end
