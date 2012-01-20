//
//  ModerMainViewController.m
//  Moder
//
//  Created by Justin Beck on 1/12/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import "ModerMainViewController.hpp"
#import "ModerMainView.hpp"

@implementation ModerMainViewController

@synthesize mainView = _mainView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _mainView = [[ModerMainView alloc] init];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

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

#pragma mark - View lifecycle

- (void)loadView
{
    _mainView.touchView.coder.delegate = self;
    [self setView:_mainView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
