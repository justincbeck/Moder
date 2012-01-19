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

@implementation TouchableView

@synthesize coder = _coder;

- (id)initWithFrame:(CGRect)frame
{
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
    [_coder addPause];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_toner stopPlaying];
    [_toner generateTone];
    [_coder addSignal];
}

@end
