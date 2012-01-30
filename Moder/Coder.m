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

extern int unitLength;
extern int letterSeparator;
extern int wordSeparator;
extern int percentDeviation;

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

    [self.delegate recalculateUnitLengthWithNewSignalLength:[NSNumber numberWithInt:signalLengthInMillis]];
    
    Signal *signal = [[Signal alloc] initWithSignalLength:signalLengthInMillis];
    [_currentLetter addObject:signal];
}

- (void) pause
{
    touchStartTime = CACurrentMediaTime();
    notTouchLength = touchStartTime - touchEndTime;
    
    if (touchEndTime > 0.0f)
    {
        int pauseLengthInMillis = [self timeInMillis:notTouchLength];
        
        if (pauseLengthInMillis > wordSeparator)
        {
            [_text addObject:_currentWord];
            
            NSString *letter = [self decodeLetter:_currentLetter];
            if (letter)
            {
                [self.delegate displayLetter:letter];
                [self.delegate startNewWord:letter];
            }

            [_currentLetter removeAllObjects];
        }
        else if (pauseLengthInMillis > letterSeparator)
        {
            [_currentWord addObject:_currentLetter];
            
            NSString *letter = [self decodeLetter:_currentLetter];
            if (letter)
            {
                [self.delegate displayLetter:letter];
                [self.delegate appendToCurrentWord:letter];
            }

            [_currentLetter removeAllObjects];
        }
    }
}

- (NSString *) decodeLetter:(NSArray *)letter
{
    CodeDecoder *decoder = [[CodeDecoder alloc] init];
    NSString *decoded = [NSString string];
    
    for (Signal *signal in _currentLetter)
    {
        NSNumber *signalLength = [NSNumber numberWithInt:signal.length];
        
        if ([signalLength isWithinPercentage:[NSNumber numberWithInt:percentDeviation] ofNumber:[NSNumber numberWithInt:unitLength]])
        {
            decoded = [decoded stringByAppendingString:@"."];
        }
        else
        {
            decoded = [decoded stringByAppendingString:@"-"];
        }
    }
    
    NSString *decodedString = [decoder.map objectForKey:decoded];
    return decodedString ?: @"";
}

- (int) timeInMillis:(double) time
{
    int millis = time * 1000;
    return millis;
}

@end
