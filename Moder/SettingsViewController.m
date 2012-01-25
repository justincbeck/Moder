//
//  SettingsViewController.m
//  Moder
//
//  Created by Justin Beck on 1/24/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsView.h"

extern int percentDeviation;

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonPressed)];
        self.navigationItem.leftBarButtonItem = doneButton;
    }
    return self;
}

- (void)doneButtonPressed
{
    percentDeviation = _settingsView.deviationSlider.value;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)loadView
{
    _settingsView = [[SettingsView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 414.0f)];
    _settingsView.deviationSlider.value = percentDeviation;
    _settingsView.sliderValueLabel.text = [NSString stringWithFormat:@"%i", percentDeviation];

    self.view = _settingsView;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
