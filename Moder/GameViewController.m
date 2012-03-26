//
//  GameViewController.m
//  Moder
//
//  Created by Justin Beck on 3/25/12.
//  Copyright (c) 2012 Intalgent. All rights reserved.
//

#import "GameViewController.h"

#import "GameView.h"

@interface GameViewController ()
{
    NSArray *_letters;
}

@end

@implementation GameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _letters = [NSArray arrayWithObjects:@"a", @"b", "c", "d",
                    "e", "f", "g", "h", "i", "j", "k",
                    "l", "m", "n", "o", "p", "q", "r",
                    "s", "t", "u", "v", "w", "x", "y", "z", nil];
        
        self.title = @"Game";
    }
    return self;
}

- (void)loadView
{
    GameView *gameView = [[GameView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)];
    self.view = gameView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
