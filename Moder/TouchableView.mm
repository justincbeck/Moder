//
//  TouchableView.mm
//  Moder
//
//  Created by Justin Beck on 1/12/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import "TouchableView.hpp"
#import <AudioToolbox/AudioToolbox.h>

#import "Toner.hpp"

Toner *_toner;

@implementation TouchableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _toner = [[Toner alloc] init];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_toner generateTone];
    [_toner startPlaying];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_toner stopPlaying];
}

@end
