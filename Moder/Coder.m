//
//  Coder.m
//  Moder
//
//  Created by Justin Beck on 1/15/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import "Coder.h"
#import "Signal.h"

@implementation Coder

- (id)init
{
    if (self = [super init])
    {
        _data = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) addSignalWithSignalLength:(double) signalLength
{
    Signal *signal = [[Signal alloc] initWithSignalLength:signalLength];
    [_data addObject:signal];
    
    [self analyzeData];
}

- (void) addPauseWithPauseLength:(double) pauseLength
{
    Signal *signal = [[Signal alloc] initWithPauseLength:pauseLength];
    [_data addObject:signal];

    [self analyzeData];
}

- (void) analyzeData
{
    Signal *signal = [_data lastObject];
    
    NSLog(@"Tone: %@", signal.tone ? @"YES" : @"NO");
    NSLog(@"Length: %g", signal.length);
}

@end
