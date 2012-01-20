//
//  Signal.m
//  Moder
//
//  Created by Justin Beck on 1/15/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import "Signal.h"

@implementation Signal

@synthesize length = _length;

- (id)initWithSignalLength:(int)millis
{
    if (self = [super init])
    {
        _length = millis;
    }
    
    return self;
}

- (NSString *)toString
{
    return [NSString stringWithFormat:@"Length: %i", _length];
}

@end
