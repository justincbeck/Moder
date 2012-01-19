//
//  CodeDecoder.m
//  Moder
//
//  Created by Justin Beck on 1/19/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import "CodeDecoder.h"

@implementation CodeDecoder

@synthesize map = _map;

- (id) init
{
    if (self = [super init])
    {
        NSMutableDictionary *map = [[NSMutableDictionary alloc] init];
        [map setObject:@"A" forKey:@".-"];
        [map setObject:@"B" forKey:@"-..."];
        [map setObject:@"C" forKey:@"-.-."];
        [map setObject:@"D" forKey:@"-.."];
        [map setObject:@"E" forKey:@"."];
        [map setObject:@"F" forKey:@"..-."];
        [map setObject:@"G" forKey:@"--."];
        [map setObject:@"H" forKey:@"...."];
        [map setObject:@"I" forKey:@".."];
        [map setObject:@"J" forKey:@".---"];
        [map setObject:@"K" forKey:@"-.-"];
        [map setObject:@"L" forKey:@".-.."];
        [map setObject:@"M" forKey:@"--"];
        [map setObject:@"N" forKey:@"-."];
        [map setObject:@"O" forKey:@"---"];
        [map setObject:@"P" forKey:@".--."];
        [map setObject:@"Q" forKey:@"--.-"];
        [map setObject:@"R" forKey:@".-."];
        [map setObject:@"S" forKey:@"..."];
        [map setObject:@"T" forKey:@"-"];
        [map setObject:@"U" forKey:@"..-"];
        [map setObject:@"V" forKey:@"...-"];
        [map setObject:@"W" forKey:@".--"];
        [map setObject:@"X" forKey:@"-..-"];
        [map setObject:@"Y" forKey:@"-.--"];
        [map setObject:@"Z" forKey:@"--.."];
        
        _map = map;
    }
    
    return self;
}

@end
