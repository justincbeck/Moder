//
//  SettingsView.m
//  Moder
//
//  Created by Justin Beck on 1/24/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import "SettingsView.h"

@implementation SettingsView

@synthesize sliderLabel = _sliderLabel;
@synthesize deviationSlider = _deviationSlider;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _sliderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 120.0f, 40.0f)];
        _sliderLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        _sliderLabel.textColor = [UIColor blackColor];
        _sliderLabel.text = @"Percent Deviation:";
        [self addSubview:_sliderLabel];
        
        _deviationSlider = [[UISlider alloc] initWithFrame:CGRectMake(130.0f, 0.0f, 180.0f, 40.0f)];
        [self addSubview:_deviationSlider];
    }
    return self;
}

@end
