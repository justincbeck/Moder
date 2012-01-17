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
        _currentWord = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) addSignalWithSignalLength:(double) signalLength
{
    int signalLengthInMillis = [self timeInMillis:signalLength];
    Signal *signal = [[Signal alloc] initWithSignalLength:signalLengthInMillis];
    [_currentWord addObject:signal];
    
    [self recalculateUnitLength];
}

- (void) addPauseWithPauseLength:(double) pauseLength
{
    int pauseLengthInMillis = [self timeInMillis:pauseLength];
    if (pauseLengthInMillis > 1000)
    {
        [_data addObject:_currentWord];
        _currentWord = nil;
        _currentWord = [[NSMutableArray alloc] init];
    }
    else
    {
        Signal *pause = [[Signal alloc] initWithPauseLength:pauseLengthInMillis];
        [_currentWord addObject:pause];
    }
}

- (int) timeInMillis:(double) time
{
    int millis = time * 1000;
    return millis;
}

- (void) recalculateUnitLength
{
    int sum = 0;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tone = YES"];
    NSArray *filteredArray = [_data filteredArrayUsingPredicate:predicate];
    
    Signal *lastSignal = [filteredArray lastObject];
    
    for (Signal *signal in filteredArray)
    {
        int minLength = lastSignal.length / 2;
        int maxLength = lastSignal.length * 1.5f;
        
        if (signal.length > minLength && signal.length < maxLength)
        {
            sum += signal.length;
            lastSignal = signal;
        }
    }
    
    unitLengthInMillis = sum / 10;
}

@end
