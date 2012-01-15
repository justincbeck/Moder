//
//  Signal.h
//  Moder
//
//  Created by Justin Beck on 1/15/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Signal : NSObject
{
    BOOL _tone;
    double _length;
}

@property (nonatomic, readwrite) BOOL tone;
@property (nonatomic, readwrite) double length;

- (id)initWithSignalLength:(double)millis;
- (id)initWithPauseLength:(double)millis;

@end
