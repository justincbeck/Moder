//
//  ModerPracticeView.h
//  Moder
//
//  Created by Justin Beck on 1/12/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchableView.hpp"

@interface ModerPracticeView : UIView
{
    UILabel *_debugView;
    
    UILabel *_currentLetterLabel;
    UITextView *_currentTextTextView;
    TouchableView *_touchView;
}

@property (nonatomic, retain) UILabel *debugView;

@property (nonatomic, retain) UILabel *currentLetterLabel;
@property (nonatomic, retain) UITextView *currentTextTextView;
@property (nonatomic, retain) TouchableView *touchView;

@end
