//
//  AudioUnitTestAppDelegate.m
//  AudioUnitTest
//
//  Created by Marc Vaillant on 11/25/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//
//  Toner.mm
//  Moder
//
//  Renamed and modified by Justin C. Beck on 1/14/12.
//  Copyright Beckproduct 2012. All rights reserved.

#include "Toner.hpp"
#include <AudioUnit/AudioUnit.h>
#include <vector>
#include <iostream>

#define kOutputBus 0
#define kInputBus 1
#define SAMPLE_RATE 44100

vector<int> _pcm;
int _index;

OSStatus status;
AudioComponentInstance audioUnit;

@implementation Toner

-(id)init
{
    if (self = [super init])
    {
        // Nothing to see here.
    }
    
    return self;
}

- (void) generateTone
{
    generate(_pcm, 800, 3000, SAMPLE_RATE, 5, 0.8);
}

void generate(
                  vector<int> &pcm, 
                  int freq, 
                  double lengthMS, 
                  int sampleRate, 
                  double riseTimeMS, 
                  double gain)
{
    int numSamples = ((double) sampleRate) * lengthMS / 1000.;
    int riseTimeSamples = ((double) sampleRate) * riseTimeMS / 1000.;

    if(gain > 1.)
        gain = 1.;
    if(gain < 0.)
        gain = 0.;

    pcm.resize(numSamples);

    for(int i = 0; i < numSamples; ++i)
    {
        double value = sin(2. * M_PI * freq * i / sampleRate);
        
        if(i < riseTimeSamples)
            value *= sin(i * M_PI / (2.0 * riseTimeSamples));
        if(i > numSamples - riseTimeSamples - 1)
            value *= sin(2. * M_PI * (i - (numSamples - riseTimeSamples) + riseTimeSamples)/ (4. * riseTimeSamples));

        pcm[i] = (int) (value * 32500.0 * gain);
        pcm[i] += (pcm[i]<<16);
    }
    
    playSound();
}

static OSStatus playbackCallback(void *inRefCon, 
                                 AudioUnitRenderActionFlags *ioActionFlags, 
                                 const AudioTimeStamp *inTimeStamp, 
                                 UInt32 inBusNumber, 
                                 UInt32 inNumberFrames, 
                                 AudioBufferList *ioData) 
{
    int totalNumberOfSamples = _pcm.size();
    for (UInt32 i = 0; i < ioData->mNumberBuffers; ++i)
    {
        int samplesLeft = totalNumberOfSamples - _index;
        int numSamples = ioData->mBuffers[i].mDataByteSize / 4;
        
        if (samplesLeft > 0)
        {
            if (samplesLeft < numSamples)
            {
                memcpy(ioData->mBuffers[i].mData, &_pcm[_index], samplesLeft * 4);
                _index += samplesLeft;
                memset((char*) ioData->mBuffers[i].mData + samplesLeft * 4, 0, (numSamples - samplesLeft) * 4) ;
            }
            else
            {
                memcpy(ioData->mBuffers[i].mData, &_pcm[_index], numSamples * 4);
                _index += numSamples;
            }
        }
        else
            memset(ioData->mBuffers[i].mData, 0, ioData->mBuffers[i].mDataByteSize);
	}
    
    return noErr;
}

void playSound()
{    
    _index = 0;
    
    // Describe audio component
    AudioComponentDescription desc;
    desc.componentType = kAudioUnitType_Output;
    desc.componentSubType = kAudioUnitSubType_RemoteIO;
    desc.componentFlags = 0;
    desc.componentFlagsMask = 0;
    desc.componentManufacturer = kAudioUnitManufacturer_Apple;
    
    // Get component
    AudioComponent inputComponent = AudioComponentFindNext(NULL, &desc);
    
    // Get audio units
    status = AudioComponentInstanceNew(inputComponent, &audioUnit);
    
    UInt32 flag = 1;

    // Enable IO for playback
    status = AudioUnitSetProperty(audioUnit, 
                                  kAudioOutputUnitProperty_EnableIO, 
                                  kAudioUnitScope_Output, 
                                  kOutputBus,
                                  &flag, 
                                  sizeof(flag));

    // Describe format
    AudioStreamBasicDescription audioFormat;
    audioFormat.mSampleRate = SAMPLE_RATE;
    audioFormat.mFormatID = kAudioFormatLinearPCM;
    audioFormat.mFormatFlags = kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
    audioFormat.mFramesPerPacket = 1;
    audioFormat.mChannelsPerFrame = 2;
    audioFormat.mBitsPerChannel = 16;
    audioFormat.mBytesPerPacket = 4;
    audioFormat.mBytesPerFrame = 4;
    
    // Apply format
    status = AudioUnitSetProperty(audioUnit, 
                                  kAudioUnitProperty_StreamFormat, 
                                  kAudioUnitScope_Input, 
                                  kOutputBus, 
                                  &audioFormat, 
                                  sizeof(audioFormat));

    // Set output callback
    AURenderCallbackStruct callbackStruct;
    callbackStruct.inputProc = playbackCallback;

    status = AudioUnitSetProperty(audioUnit, 
                                  kAudioUnitProperty_SetRenderCallback, 
                                  kAudioUnitScope_Global, 
                                  kOutputBus,
                                  &callbackStruct, 
                                  sizeof(callbackStruct));

    // Initialize
    status = AudioUnitInitialize(audioUnit);

}

- (void) startPlaying
{
    status = AudioOutputUnitStart(audioUnit);
}

- (void) stopPlaying
{
    status = AudioOutputUnitStop(audioUnit);
}

@end