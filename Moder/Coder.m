//
//  Coder.m
//  Moder
//
//  Created by Justin Beck on 1/15/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import "Coder.h"
#import "Signal.h"
#import "CodeDecoder.h"
#import "NSNumber+Helpers.h"

#import <QuartzCore/QuartzCore.h>

#define kModerDefaultPercentageDeviation 50

#define kModerDefaultUnitLength 200
#define kModerDefaultLetterSeperator 600
#define kModerDefaultWordSeperator 1400

@implementation Coder

double signalLength;
double notTouchLength;
double touchStartTime;
double touchEndTime;

- (id)init
{
    if (self = [super init])
    {
        _currentLetter = [[NSMutableArray alloc] init];
        _currentWord = [[NSMutableArray alloc] init];
        _text = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) addSignal
{
    touchEndTime = CACurrentMediaTime();
    signalLength = touchEndTime - touchStartTime;
    
    int signalLengthInMillis = [self timeInMillis:signalLength];
    
    Signal *signal = [[Signal alloc] initWithSignalLength:signalLengthInMillis];
    [_currentLetter addObject:signal];
    
//    [self recalculateUnitLength];
}

- (void) addPause
{
    touchStartTime = CACurrentMediaTime();
    notTouchLength = touchStartTime - touchEndTime;
    
    if (touchEndTime > 0.0f)
    {
        int pauseLengthInMillis = [self timeInMillis:notTouchLength];
//        if (pauseLengthInMillis > kModerDefaultWordSeperator)
//        {
//            [_text addObject:_currentWord];
//            [_currentWord removeAllObjects];
//        }
        if (pauseLengthInMillis > kModerDefaultLetterSeperator)
        {
            [_currentWord addObject:_currentLetter];
            [self displayLetter:_currentLetter];
            [_currentLetter removeAllObjects];
        }
        else
        {
            Signal *pause = [[Signal alloc] initWithPauseLength:pauseLengthInMillis];
            [_currentLetter addObject:pause];
        }
    }
}

- (void) displayLetter:(NSArray *)letter
{
    CodeDecoder *decoder = [[CodeDecoder alloc] init];
    
    NSNumber *unitLength = [NSNumber numberWithInt:kModerDefaultUnitLength];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tone = YES"];
    NSArray *tones = [_currentLetter filteredArrayUsingPredicate:predicate];
    
    NSString *decoded = [NSString string];
    
    for (Signal *signal in tones)
    {
        NSNumber *signalLength = [NSNumber numberWithInt:signal.length];
        
        // TODO: A basic if/else will work for now
        if ([unitLength isWithinPercentage:[NSNumber numberWithInt:kModerDefaultPercentageDeviation] ofNumber:signalLength])
        {
            decoded = [decoded stringByAppendingString:@"."];
        }
        else
        {
            decoded = [decoded stringByAppendingString:@"-"];
        }
    }
    
    NSString *decodedLetter = [decoder.map objectForKey:decoded];
    NSLog(@"%@", decoded);
    NSLog(@"Letter: %@", decodedLetter);
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
    NSArray *filteredArray = [_text filteredArrayUsingPredicate:predicate];
    
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
