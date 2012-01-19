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
