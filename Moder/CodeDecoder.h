//
//  CodeDecoder.h
//  Moder
//
//  Created by Justin Beck on 1/19/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodeDecoder : NSObject
{
    NSMutableDictionary *_map;
}

@property (nonatomic, readonly) NSMutableDictionary *map;

@end
