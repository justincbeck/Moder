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
@synthesize sliderValueLabel = _sliderValueLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _sliderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 120.0f, 40.0f)];
        _sliderLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        _sliderLabel.textColor = [UIColor blackColor];
        _sliderLabel.text = @"Percent Deviation:";
        [self addSubview:_sliderLabel];
        
        _deviationSlider = [[UISlider alloc] initWithFrame:CGRectMake(130.0f, 0.0f, 140.0f, 40.0f)];
        _deviationSlider.minimumValue = 20;
        _deviationSlider.maximumValue = 80;
        [_deviationSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_deviationSlider];
        
        _sliderValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(290.0f, 0.0f, 40.0f, 40.0f)];
        _sliderValueLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        _sliderValueLabel.textColor = [UIColor blackColor];
        [self addSubview:_sliderValueLabel];
    }
    return self;
}

- (void)sliderValueChanged:(id)sender
{
    _sliderValueLabel.text = [NSString stringWithFormat:@"%i", [[NSNumber numberWithFloat:_deviationSlider.value] intValue]];
}

@end
