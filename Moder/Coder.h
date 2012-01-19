//
//  Coder.h
//  Moder
//
//  Created by Justin Beck on 1/15/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coder : NSObject
{
    NSMutableArray *_currentLetter;
    NSMutableArray *_currentWord;
    NSMutableArray *_text;
    
    int unitLengthInMillis;
}

- (void) addSignal;
- (void) addPause;

- (int) timeInMillis:(double)time;
- (void) recalculateUnitLength;

- (void) displayLetter:(NSArray *)letter;

@end
