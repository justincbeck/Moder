//
//  TouchableView.hpp
//  Moder
//
//  Created by Justin Beck on 1/12/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Toner.hpp"

@interface TouchableView : UIView
{
    Toner *_toner;
    NSMutableArray *touches;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@end