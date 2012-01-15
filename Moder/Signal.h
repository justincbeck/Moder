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
    int _length;
}

@property (nonatomic, readwrite) BOOL tone;
@property (nonatomic, readwrite) int length;

- (id)initWithSignalLength:(int)millis;
- (id)initWithPauseLength:(int)millis;
- (NSString *)toString;

@end
