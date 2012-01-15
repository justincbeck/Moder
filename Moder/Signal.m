//
//  Signal.m
//  Moder
//
//  Created by Justin Beck on 1/15/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import "Signal.h"

@implementation Signal

@synthesize tone = _tone;
@synthesize length = _length;

- (id)initWithSignalLength:(int)millis
{
    if (self = [super init])
    {
        _tone = YES;
        _length = millis;
    }
    
    return self;
}

- (id)initWithPauseLength:(int)millis
{
    if (self = [super init])
    {
        _tone = NO;
        _length = millis;
    }
    
    return self;
}

- (NSString *)toString
{
    NSString *toneString = _tone ? @"YES" : @"NO";
    return [NSString stringWithFormat:@"Tone: %@, Length: %i", toneString, _length];
}

@end
