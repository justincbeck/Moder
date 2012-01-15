//
//  Toner.hpp
//  Moder
//
//  Created by Justin Beck on 1/12/12.
//  Copyright (c) 2012 Beckproduct. All rights reserved.
//

#import <vector>

using namespace std;

@interface Toner : NSObject

void generate(
                  std::vector<int>& pcm, 
                  int freq, 
                  double lengthMS, 
                  int sampleRate, 
                  double riseTimeMS, 
                  double gain);

void playSound();

- (void) startPlaying;
- (void) stopPlaying;
- (void) generateTone;

@end
