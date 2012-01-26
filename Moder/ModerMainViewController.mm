//
//  ModerMainViewController.m
//  Moder
//
//  Created by Justin Beck on 1/12/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import "ModerMainViewController.hpp"
#import "SettingsViewController.h"
#import "ModerMainView.hpp"
#import "NSNumber+Helpers.h"

int unitLength;
int letterSeparator;
int wordSeparator;
int percentDeviation;

@implementation ModerMainViewController

@synthesize mainView = _mainView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(settingsButtonPressed)];
        self.navigationItem.rightBarButtonItem = settingsButton;

        _signalLengths = [[NSMutableArray alloc] init];

        unitLength = kModerDefaultUnitLength;
        letterSeparator = kModerDefaultLetterSeperator;
        wordSeparator = kModerDefaultWordSeperator;
        percentDeviation = kModerDefaultPercentageDeviation;
    }
    return self;
}

#pragma mark - View lifecycle

- (void)loadView
{
    _mainView = [[ModerMainView alloc] init];
    NSString *debugString = [NSString stringWithFormat:@"Unit Length: %ims\nLetter Separator: %ims\nWord Separator: %ims\nPercent Deviation: %i%%",
                             unitLength,
                             letterSeparator,
                             wordSeparator,
                             percentDeviation];
    _mainView.debugView.text = debugString;
    _mainView.touchView.coder.delegate = self;
    
    [self setView:_mainView];
}

# pragma mark ModerCoderDelegate methods

- (void)displayLetter:(NSString *)letter
{
    _mainView.currentLetterLabel.text = letter;

    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
        CGAffineTransform scaleUp = CGAffineTransformMakeScale(1.1f, 1.1f);
        _mainView.currentLetterLabel.transform = scaleUp;
    } completion:^(BOOL){
        [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
            CGAffineTransform scaleDown = CGAffineTransformMakeScale(0.9f, 0.9f);
            _mainView.currentLetterLabel.transform = scaleDown;
        } completion:^(BOOL) {
            [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
                _mainView.currentLetterLabel.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                // Nothing to see here
            }];
        }];
    }];
}

- (void)startNewWord:(NSString *)letter {
    if (letter)
    {
        [self appendToCurrentWord:letter];
        
        NSMutableString *currentText = [NSMutableString stringWithString:_mainView.currentTextTextView.text];
        
        if (currentText.length > 0)
            [currentText appendString:@" "];
        
        _mainView.currentTextTextView.text = currentText;
    }
}

- (void)appendToCurrentWord:(NSString *)letter
{
    NSMutableString *currentText = [NSMutableString stringWithString:_mainView.currentTextTextView.text];
    [currentText appendString:letter];
    _mainView.currentTextTextView.text = currentText;
}

- (void)recalculateUnitLengthWithNewSignalLength:(NSNumber *)signalLength
{
    [_signalLengths addObject:signalLength];
    
    int total = 0;
    
    for (NSNumber *length in _signalLengths)
    {
        if ([length isWithinPercentage:[NSNumber numberWithInt:50] ofNumber:[NSNumber numberWithInt:unitLength]])
        {
            total += [length intValue];
        }
        else
        {
            total += [length intValue] / 3;
        }
    }
    
    if (_signalLengths.count > 0)
    {
        unitLength = total / _signalLengths.count;
        letterSeparator = unitLength * 3;
        wordSeparator = unitLength * 7;
    }
    
    NSString *debugString = [NSString stringWithFormat:@"Unit Length: %ims\nLetter Separator: %ims\nWord Separator: %ims\nPercent Deviation: %i%%",
                             unitLength,
                             letterSeparator,
                             wordSeparator,
                             percentDeviation];
    
    _mainView.debugView.text = debugString;
    
    NSLog(@"Unit Length: %i", unitLength);
    NSLog(@"Letter Seperator: %i", letterSeparator);
    NSLog(@"Word Seperator: %i", wordSeparator);
    NSLog(@"Percent Deviation: %i", percentDeviation);
    NSLog(@"*******************************");
}

# pragma mark Non-lifecycle methods

- (void)settingsButtonPressed
{
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:settingsViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSString *debugString = [NSString stringWithFormat:@"Unit Length: %ims\nLetter Separator: %ims\nWord Separator: %ims\nPercent Deviation: %i%%",
                             unitLength,
                             letterSeparator,
                             wordSeparator,
                             percentDeviation];
    
    _mainView.debugView.text = debugString;
}

# pragma mark other standard methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
