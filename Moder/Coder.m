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

@synthesize delegate = _delegate;

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
}

- (void) addPause
{
    touchStartTime = CACurrentMediaTime();
    notTouchLength = touchStartTime - touchEndTime;
    
    if (touchEndTime > 0.0f)
    {
        int pauseLengthInMillis = [self timeInMillis:notTouchLength];

        if (pauseLengthInMillis > kModerDefaultLetterSeperator)
        {
            [_currentWord addObject:_currentLetter];
            [self.delegate displayLetter:[self decodeLetter:_currentLetter]];
            [_currentLetter removeAllObjects];
        }
        else
        {
            Signal *pause = [[Signal alloc] initWithPauseLength:pauseLengthInMillis];
            [_currentLetter addObject:pause];
        }
    }
}

- (NSString *) decodeLetter:(NSArray *)letter
{
    CodeDecoder *decoder = [[CodeDecoder alloc] init];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tone = YES"];
    NSArray *tones = [_currentLetter filteredArrayUsingPredicate:predicate];
    
    NSString *decoded = [NSString string];
    
    for (Signal *signal in tones)
    {
        NSNumber *signalLength = [NSNumber numberWithInt:signal.length];
        
        if ([signalLength isWithinPercentage:[NSNumber numberWithInt:kModerDefaultPercentageDeviation] ofNumber:[NSNumber numberWithInt:kModerDefaultUnitLength]])
        {
            decoded = [decoded stringByAppendingString:@"."];
        }
        else
        {
            decoded = [decoded stringByAppendingString:@"-"];
        }
    }
    
    NSLog(@"%@", decoded);
    
    return [decoder.map objectForKey:decoded];
}

- (int) timeInMillis:(double) time
{
    int millis = time * 1000;
    return millis;
}

@end
