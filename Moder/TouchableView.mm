//
//  TouchableView.mm
//  Moder
//
//  Created by Justin Beck on 1/12/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import "TouchableView.hpp"
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/QuartzCore.h>

double touchLength;
double touchStartTime;

@implementation TouchableView

- (id)initWithFrame:(CGRect)frame
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator setHidesWhenStopped:YES];
    [indicator startAnimating];

    self = [super initWithFrame:frame];
    if (self)
    {
        _toner = [[Toner alloc] init];
        [_toner generateTone];
    }
    
    [indicator stopAnimating];
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    touchStartTime = CACurrentMediaTime();
    [_toner startPlaying];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_toner stopPlaying];
    
    double stopTouchTime = CACurrentMediaTime();
    touchLength = stopTouchTime - touchStartTime;
    
    NSLog(@"%g", touchLength);
    
    [_toner generateTone];
}

@end
