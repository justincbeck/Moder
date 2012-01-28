//
//  ModerPracticeViewController.h
//  Moder
//
//  Created by Justin Beck on 1/12/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Coder.h"
#import "ModerPracticeView.hpp"

@interface ModerPracticeViewController : UIViewController <ModerCoderDelegate>
{
    ModerPracticeView *_mainView;
    NSMutableArray *_signalLengths;
}

@property (nonatomic, retain) ModerPracticeView *mainView;

@end
