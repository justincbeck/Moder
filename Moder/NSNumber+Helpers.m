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
    int deviation = ([number intValue] * [percent intValue]) / 100;
    int minLength = [number intValue] - deviation;
    int maxLength = [number intValue] + deviation;
    
    if ([self intValue] > minLength && [self intValue] < maxLength)
    {
        return YES;
    }
    else
    {   
        return NO;
    }
}

@end
