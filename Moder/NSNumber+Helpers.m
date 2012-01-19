//
//  NSString+Helpers.m
//  Moder
//
//  Created by Justin Beck on 1/17/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import "NSNumber+Helpers.h"

@implementation NSNumber (Helpers)

- (BOOL) isWithinPercentage:(NSNumber *)percent ofNumber:(NSNumber *)number
{
    int deviation = ([self intValue] * [percent intValue]) / 100;
    int minLength = [self intValue] - deviation;
    int maxLength = [self intValue] + deviation;
    
    if ([number intValue] > minLength && [number intValue] < maxLength)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
