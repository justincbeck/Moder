//
//  ModerMainView.m
//  Moder
//
//  Created by Justin Beck on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ModerMainView.h"
#import "TouchableView.h"

@implementation ModerMainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITextField *currentLetter = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 380.0f)];
        currentLetter.backgroundColor = [UIColor redColor];
        [self addSubview:currentLetter];
        
        UITextView *currentText = [[UITextView alloc] initWithFrame:CGRectMake(0.0f, 380.0f, 320.0f, 100.0f)];
        currentText.backgroundColor = [UIColor blueColor];
        [self addSubview:currentText];
        
        TouchableView *touchView = [[TouchableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)];
        touchView.backgroundColor = [UIColor purpleColor];
        touchView.alpha = 0.5f;
        [self addSubview:touchView];
    }
    return self;
}

@end
