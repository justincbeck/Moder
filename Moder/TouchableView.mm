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

double signalLength;
double notTouchLength;
double touchStartTime;
double touchEndTime;

@implementation TouchableView

- (id)initWithFrame:(CGRect)frame
{
    // This is not quite right... - JCB
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator setHidesWhenStopped:YES];
    [indicator startAnimating];

    self = [super initWithFrame:frame];
    if (self)
    {
        _coder = [[Coder alloc] init];
        
        _toner = [[Toner alloc] init];
        [_toner generateTone];
    }
    
    [indicator stopAnimating];
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_toner startPlaying];

    touchStartTime = CACurrentMediaTime();
    if (touchEndTime > 0.0f)
    {
        notTouchLength = touchStartTime - touchEndTime;
        [_coder addPauseWithPauseLength:notTouchLength];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_toner stopPlaying];
    [_toner generateTone];
    
    touchEndTime = CACurrentMediaTime();
    signalLength = touchEndTime - touchStartTime;
    
    [_coder addSignalWithSignalLength:signalLength];
}

@end
