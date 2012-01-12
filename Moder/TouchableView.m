//
//  TouchableView.m
//  Moder
//
//  Created by Justin Beck on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TouchableView.h"

@implementation TouchableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Someone is touching me!");
    for (UITouch *touch in touches)
    {
        NSLog(@"%d", touch.tapCount);
        NSLog(@"%g", touch.timestamp);
        NSLog(@"%g", touch.phase);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Someone stopped touching me!");
    for (UITouch *touch in touches)
    {
        NSLog(@"%d", touch.tapCount);
        NSLog(@"%g", touch.timestamp);
        NSLog(@"%g", touch.phase);
    }
}

@end
