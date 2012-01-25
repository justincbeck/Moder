//
//  SettingsView.h
//  Moder
//
//  Created by Justin Beck on 1/24/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsView : UIView
{
    UILabel *_sliderLabel;
    UISlider *_deviationSlider;
}

@property (nonatomic, retain) UILabel *sliderLabel;
@property (nonatomic, retain) UISlider *deviationSlider;

@end
