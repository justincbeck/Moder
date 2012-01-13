#import <vector>

using namespace std;

@interface Toner : NSObject

void generateTone(
                  std::vector<int>& pcm, 
                  int freq, 
                  double lengthMS, 
                  int sampleRate, 
                  double riseTimeMS, 
                  double gain);

- (void)playSound;

@end
