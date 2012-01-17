//
//  Coder.m
//  Moder
//
//  Created by Justin Beck on 1/15/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import "Coder.h"
#import "Signal.h"

#import <QuartzCore/QuartzCore.h>

@implementation Coder

double signalLength;
double notTouchLength;
double touchStartTime;
double touchEndTime;

- (id)init
{
    if (self = [super init])
    {
        _data = [[NSMutableArray alloc] init];
        _currentWord = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) addSignal
{
    touchEndTime = CACurrentMediaTime();
    signalLength = touchEndTime - touchStartTime;
    
    int signalLengthInMillis = [self timeInMillis:signalLength];
    
    Signal *signal = [[Signal alloc] initWithSignalLength:signalLengthInMillis];
    [_currentWord addObject:signal];
    
    [self recalculateUnitLength];
}

- (void) addPause
{
    touchStartTime = CACurrentMediaTime();
    notTouchLength = touchStartTime - touchEndTime;
    
    if (touchEndTime > 0.0f)
    {
        int pauseLengthInMillis = [self timeInMillis:notTouchLength];
        
        if (pauseLengthInMillis > 1000)
        {
            [_data addObject:_currentWord];
            [_currentWord removeAllObjects];
        }
        else
        {
            Signal *pause = [[Signal alloc] initWithPauseLength:pauseLengthInMillis];
            [_currentWord addObject:pause];
        }
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
