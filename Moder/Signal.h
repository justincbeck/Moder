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
    int _length;
}

@property (nonatomic, readwrite) int length;

- (id)initWithSignalLength:(int)millis;

- (NSString *)toString;

@end
