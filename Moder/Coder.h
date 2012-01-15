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
    NSMutableArray *_data;
}

- (void) addSignalWithSignalLength:(double) signalLength;
- (void) addPauseWithPauseLength:(double) pauseLength;

- (void) analyzeData;

@end
