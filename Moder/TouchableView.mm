//
//  TouchableView.m
//  Moder
//
//  Created by Justin Beck on 1/12/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import "TouchableView.h"
#import <AudioToolbox/AudioToolbox.h>

#import "Toner.hpp"

@implementation TouchableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    Toner *toner = [[Toner alloc] init];
    [toner playSound];
    
    for (UITouch *touch in touches)
    {
        NSLog(@"%d", touch.tapCount);
        NSLog(@"%g", touch.timestamp);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        NSLog(@"%d", touch.tapCount);
        NSLog(@"%g", touch.timestamp);
    }
}

@end
