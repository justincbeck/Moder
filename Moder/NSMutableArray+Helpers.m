//
//  NSArray+Helpers.m
//  Moder
//
//  Created by Justin Beck on 1/15/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import "NSMutableArray+Helpers.h"

@implementation NSMutableArray (Helpers)

- (NSArray *) getObjectsInRange:(NSRange) indexRange
{
    int length = indexRange.length - indexRange.location;
    
    if (length >= [self count])
    {
        return self;
    }
    else
    {
        return [self subarrayWithRange:indexRange];
    }
}

@end
