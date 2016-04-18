#include "Tweak.h"

@implementation BeSureBeforeClass
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  if (!buttonIndex) {
    besureBeforeConfirmed = NO;
  } else {
    besureBeforeConfirmed = YES;
  }
  [self release];
}
@end

%group FBMessanger
%hook FBMAudioRecorder
- (void)audioRecorderDidFinishRecording:(id)arg1 successfully:(BOOL)arg2 {
	if (fbmASKBOOL) {
		if (!besureBeforeConfirmed) {
			if (soundAlertBOOL) {
				NSData *unlockData = [NSData dataWithContentsOfFile:@"/Library/Application Support/BeSureBefore/Sounds/besurebefore.caf"];
			    AVAudioPlayer *AVPlayer = [[AVAudioPlayer alloc] initWithData:unlockData error:nil];
			    [AVPlayer setNumberOfLoops:0];
			    [AVPlayer play];
			}
			if (vibraAlertBOOL) {
				AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
			}
			UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"BeSureBefore"
                                                 message:@"Are you sure to proceed this audio record operation ?"
                                                delegate:[[BeSureBeforeClass alloc] init]
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:@"YES", nil];
		    [av show];
		    [av release];
		} else {
			%orig;
			besureBeforeConfirmed = NO;
		}

	} else {
		%orig;
	}
}
%end
%end

%group TweetBot
%hook PTHTweetbotStatusActionDrawerView
- (void)toggleFavorite {
	if (twtbotASKBOOL) {
		if (!besureBeforeConfirmed) {
			if (soundAlertBOOL) {
				NSData *unlockData = [NSData dataWithContentsOfFile:@"/Library/Application Support/BeSureBefore/Sounds/besurebefore.caf"];
			    AVAudioPlayer *AVPlayer = [[AVAudioPlayer alloc] initWithData:unlockData error:nil];
			    [AVPlayer setNumberOfLoops:0];
			    [AVPlayer play];
			}
			if (vibraAlertBOOL) {
				AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
			}
			UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"BeSureBefore"
                                                 message:@"Are you sure to proceed this favorite operation ?"
                                                delegate:[[BeSureBeforeClass alloc] init]
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:@"YES", nil];
		    [av show];
		    [av release];
		} else {
			%orig;
			besureBeforeConfirmed = NO;
		}

	} else {
		%orig;
	}
}
%end
%end

%group WhatsApp
%hook ChatViewController
- (void)callContact {
	if (whatsASKBOOL) {
		if (!besureBeforeConfirmed) {
			if (soundAlertBOOL) {
				NSData *unlockData = [NSData dataWithContentsOfFile:@"/Library/Application Support/BeSureBefore/Sounds/besurebefore.caf"];
			    AVAudioPlayer *AVPlayer = [[AVAudioPlayer alloc] initWithData:unlockData error:nil];
			    [AVPlayer setNumberOfLoops:0];
			    [AVPlayer play];
			}
			if (vibraAlertBOOL) {
				AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
			}
			UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"BeSureBefore"
                                                 message:@"Are you sure to proceed this call operation ?"
                                                delegate:[[BeSureBeforeClass alloc] init]
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:@"YES", nil];
		    [av show];
		    [av release];
		} else {
			%orig;
			besureBeforeConfirmed = NO;
		}

	} else {
		%orig;
	}
}
%end
%end

%group Viber
%hook ConversationDetailVC
- (void)callButtonDidTouch:(id)arg1 {
	if (viberASKBOOL) {
		if (!besureBeforeConfirmed) {
			if (soundAlertBOOL) {
				NSData *unlockData = [NSData dataWithContentsOfFile:@"/Library/Application Support/BeSureBefore/Sounds/besurebefore.caf"];
			    AVAudioPlayer *AVPlayer = [[AVAudioPlayer alloc] initWithData:unlockData error:nil];
			    [AVPlayer setNumberOfLoops:0];
			    [AVPlayer play];
			}
			if (vibraAlertBOOL) {
				AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
			}
			UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"BeSureBefore"
                                                 message:@"Are you sure to proceed this call operation ?"
                                                delegate:[[BeSureBeforeClass alloc] init]
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:@"YES", nil];
		    [av show];
		    [av release];
		} else {
			%orig;
			besureBeforeConfirmed = NO;
		}

	} else {
		%orig;
	}
}
%end
%end

%group SMS
%hook CKTranscriptController
- (void)send:(id)arg1 {
	if (smsASKBOOL) {
		if (!besureBeforeConfirmed) {
			if (soundAlertBOOL) {
				NSData *unlockData = [NSData dataWithContentsOfFile:@"/Library/Application Support/BeSureBefore/Sounds/besurebefore.caf"];
			    AVAudioPlayer *AVPlayer = [[AVAudioPlayer alloc] initWithData:unlockData error:nil];
			    [AVPlayer setNumberOfLoops:0];
			    [AVPlayer play];
			}
			if (vibraAlertBOOL) {
				AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
			}
			UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"BeSureBefore"
                                                 message:@"Are you sure to proceed this send operation ?"
                                                delegate:[[BeSureBeforeClass alloc] init]
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:@"YES", nil];
		    [av show];
		    [av release];
		} else {
			%orig;
			besureBeforeConfirmed = NO;
		}

	} else {
		%orig;
	}
}
%end
%end

%group Mail
%hook MFMailComposeController
- (void)send:(id)arg1 {
	if (mailASKBOOL) {
		if (!besureBeforeConfirmed) {
			if (soundAlertBOOL) {
				NSData *unlockData = [NSData dataWithContentsOfFile:@"/Library/Application Support/BeSureBefore/Sounds/besurebefore.caf"];
			    AVAudioPlayer *AVPlayer = [[AVAudioPlayer alloc] initWithData:unlockData error:nil];
			    [AVPlayer setNumberOfLoops:0];
			    [AVPlayer play];
			}
			if (vibraAlertBOOL) {
				AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
			}
			UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"BeSureBefore"
                                                 message:@"Are you sure to proceed this send operation ?"
                                                delegate:[[BeSureBeforeClass alloc] init]
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:@"YES", nil];
		    [av show];
		    [av release];
		} else {
			%orig;
			besureBeforeConfirmed = NO;
		}

	} else {
		%orig;
	}
}
%end
%end

%group Phone 
%hook DialerController
- (void)_callButtonPressed:(id)arg1 {
	if (phoneASKBOOL) {
		if (!besureBeforeConfirmed) {
			if (soundAlertBOOL) {
				NSData *unlockData = [NSData dataWithContentsOfFile:@"/Library/Application Support/BeSureBefore/Sounds/besurebefore.caf"];
			    AVAudioPlayer *AVPlayer = [[AVAudioPlayer alloc] initWithData:unlockData error:nil];
			    [AVPlayer setNumberOfLoops:0];
			    [AVPlayer play];
			}
			if (vibraAlertBOOL) {
				AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
			}
			UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"BeSureBefore"
                                                 message:@"Are you sure to proceed this call operation ?"
                                                delegate:[[BeSureBeforeClass alloc] init]
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:@"YES", nil];
		    [av show];
		    [av release];
		} else {
			%orig;
			besureBeforeConfirmed = NO;
		}

	} else {
		%orig;
	}
}
%end
%end

%group FaceTime 
%hook PHRecentsManager
- (void)dialRecentCall:(id)arg1 {
	if (ftASKBOOL) {
		if (!besureBeforeConfirmed) {
			if (soundAlertBOOL) {
				NSData *unlockData = [NSData dataWithContentsOfFile:@"/Library/Application Support/BeSureBefore/Sounds/besurebefore.caf"];
			    AVAudioPlayer *AVPlayer = [[AVAudioPlayer alloc] initWithData:unlockData error:nil];
			    [AVPlayer setNumberOfLoops:0];
			    [AVPlayer play];
			}
			if (vibraAlertBOOL) {
				AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
			}
			UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"BeSureBefore"
                                                 message:@"Are you sure to proceed this call operation ?"
                                                delegate:[[BeSureBeforeClass alloc] init]
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:@"YES", nil];
		    [av show];
		    [av release];
		} else {
			%orig;
			besureBeforeConfirmed = NO;
		}

	} else {
		%orig;
	}
}
%end
%hook PHFavoritesManager
- (void)dialFavoriteEntry:(id)arg1 {
	if (ftASKBOOL) {
		if (!besureBeforeConfirmed) {
			if (soundAlertBOOL) {
				NSData *unlockData = [NSData dataWithContentsOfFile:@"/Library/Application Support/BeSureBefore/Sounds/besurebefore.caf"];
			    AVAudioPlayer *AVPlayer = [[AVAudioPlayer alloc] initWithData:unlockData error:nil];
			    [AVPlayer setNumberOfLoops:0];
			    [AVPlayer play];
			}
			if (vibraAlertBOOL) {
				AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
			}
			UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"BeSureBefore"
                                                 message:@"Are you sure to proceed this call operation ?"
                                                delegate:[[BeSureBeforeClass alloc] init]
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:@"YES", nil];
		    [av show];
		    [av release];
		} else {
			%orig;
			besureBeforeConfirmed = NO;
		}

	} else {
		%orig;
	}
}
%end
%end

%group Instagram
%hook IGFeedItemActionCell
- (void)onLikeButtonPressed:(id)arg1 {
	if (instaASKBOOL) {
		if (!besureBeforeConfirmed) {
			if (soundAlertBOOL) {
				NSData *unlockData = [NSData dataWithContentsOfFile:@"/Library/Application Support/BeSureBefore/Sounds/besurebefore.caf"];
			    AVAudioPlayer *AVPlayer = [[AVAudioPlayer alloc] initWithData:unlockData error:nil];
			    [AVPlayer setNumberOfLoops:0];
			    [AVPlayer play];
			}
			if (vibraAlertBOOL) {
				AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
			}
			UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"BeSureBefore"
                                                 message:@"Are you sure to proceed this like operation ?"
                                                delegate:[[BeSureBeforeClass alloc] init]
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:@"YES", nil];
		    [av show];
		    [av release];
		} else {
			%orig;
			besureBeforeConfirmed = NO;
		}

	} else {
		%orig;
	}
}
%end

%hook IGFeedItemPhotoView
- (void)onDoubleTap:(id)arg1 {
	if (instaASKBOOL) {
		if (!besureBeforeConfirmed) {
			if (soundAlertBOOL) {
				NSData *unlockData = [NSData dataWithContentsOfFile:@"/Library/Application Support/BeSureBefore/Sounds/besurebefore.caf"];
			    AVAudioPlayer *AVPlayer = [[AVAudioPlayer alloc] initWithData:unlockData error:nil];
			    [AVPlayer setNumberOfLoops:0];
			    [AVPlayer play];
			}
			if (vibraAlertBOOL) {
				AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
			}
			UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"BeSureBefore"
                                                 message:@"Are you sure to proceed this like operation ?"
                                                delegate:[[BeSureBeforeClass alloc] init]
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:@"YES", nil];
		    [av show];
		    [av release];
		} else {
			%orig;
			besureBeforeConfirmed = NO;
		}

	} else {
		%orig;
	}
}
%end

%hook IGFeedItemVideoView
- (void)onDoubleTap:(id)arg1 {
	if (instaASKBOOL) {
		if (!besureBeforeConfirmed) {
			if (soundAlertBOOL) {
				NSData *unlockData = [NSData dataWithContentsOfFile:@"/Library/Application Support/BeSureBefore/Sounds/besurebefore.caf"];
			    AVAudioPlayer *AVPlayer = [[AVAudioPlayer alloc] initWithData:unlockData error:nil];
			    [AVPlayer setNumberOfLoops:0];
			    [AVPlayer play];
			}
			if (vibraAlertBOOL) {
				AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
			}
			UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"BeSureBefore"
                                                 message:@"Are you sure to proceed this like operation ?"
                                                delegate:[[BeSureBeforeClass alloc] init]
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:@"YES", nil];
		    [av show];
		    [av release];
		} else {
			%orig;
			besureBeforeConfirmed = NO;
		}

	} else {
		%orig;
	}
}
%end
%end

%group BBM
%hook BBMConversationViewController
- (void)callIconTapped {
	if (bbmASKBOOL) {
		if (!besureBeforeConfirmed) {
			if (soundAlertBOOL) {
				NSData *unlockData = [NSData dataWithContentsOfFile:@"/Library/Application Support/BeSureBefore/Sounds/besurebefore.caf"];
			    AVAudioPlayer *AVPlayer = [[AVAudioPlayer alloc] initWithData:unlockData error:nil];
			    [AVPlayer setNumberOfLoops:0];
			    [AVPlayer play];
			}
			if (vibraAlertBOOL) {
				AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
			}
			UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"BeSureBefore"
                                                 message:@"Are you sure to proceed this call operation ?"
                                                delegate:[[BeSureBeforeClass alloc] init]
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:@"YES", nil];
		    [av show];
		    [av release];
		} else {
			%orig;
			besureBeforeConfirmed = NO;
		}

	} else {
		%orig;
	}
}
%end
%end

%group Skype
%hook SKPDialpadViewController
- (void)callPressed {
	if (skypeASKBOOL) {
		if (!besureBeforeConfirmed) {
			if (soundAlertBOOL) {
				NSData *unlockData = [NSData dataWithContentsOfFile:@"/Library/Application Support/BeSureBefore/Sounds/besurebefore.caf"];
			    AVAudioPlayer *AVPlayer = [[AVAudioPlayer alloc] initWithData:unlockData error:nil];
			    [AVPlayer setNumberOfLoops:0];
			    [AVPlayer play];
			}
			if (vibraAlertBOOL) {
				AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
			}
			UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"BeSureBefore"
                                                 message:@"Are you sure to proceed this call operation ?"
                                                delegate:[[BeSureBeforeClass alloc] init]
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:@"YES", nil];
		    [av show];
		    [av release];
		} else {
			%orig;
			besureBeforeConfirmed = NO;
		}

	} else {
		%orig;
	}
}
%end
%end

#pragma mark - First run
%group FirstRun
%hook SBLockScreenManager

// WORKS FINE WITH IOS8
- (void)_finishUIUnlockFromSource:(NSInteger)source withOptions:(NSDictionary *)options {
	%orig;
	if (isFirstRun) {
		isFirstRun = NO;
		NSURL *url;
		if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/PreferenceOrganizer2.dylib"]) {
			// this is broken... https://github.com/angelXwind/PreferenceOrganizer2/issues/3
			url = [NSURL URLWithString:@"prefs:root=Tweaks&path=BeSureBefore"];
		} else {
			url = [NSURL URLWithString:@"prefs:root=BeSureBefore"];
		}
		[[UIApplication sharedApplication] openURL:url];
	}
}

%end
%end
#pragma mark - Preferences

void ASKLoadPrefs() {

	NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:ASKPREFSPATH];
	soundAlertBOOL = GET_BOOL(SOUNDASKKEY, NO);
	vibraAlertBOOL = GET_BOOL(VIBASKKEY, NO);
	smsASKBOOL = GET_BOOL(SMSASKKEY, NO);
	whatsASKBOOL = GET_BOOL(WHATSASKKEY, NO);
	ftASKBOOL = GET_BOOL(FTASKKEY, NO);
	phoneASKBOOL = GET_BOOL(PHONEASKKEY, NO);
	bbmASKBOOL = GET_BOOL(BBMASKKEY, NO);
	skypeASKBOOL = GET_BOOL(SKYASKKEY, NO);
	instaASKBOOL = GET_BOOL(INSTASKKEY, NO);
	mailASKBOOL = GET_BOOL(MAILASKKEY, NO);
	twtbotASKBOOL = GET_BOOL(TWTBOTASKKEY, NO);
	fbmASKBOOL = GET_BOOL(FBMASKKEY, NO);
	viberASKBOOL = GET_BOOL(VIBRASKKEY, NO);

	if (!prefs) {
		isFirstRun = YES;
		%init(FirstRun);

		[@{} writeToFile:ASKPREFSPATH atomically:YES];
	}
}
%ctor {
	%init;
	ASKLoadPrefs();
	 if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:WHATSAPP_ID]) {
	 	%init(WhatsApp);
	 }
	 else if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:APSMS_ID]) {
	 	%init(SMS);
	 }
	 else if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:FTIME_ID]) {
	 	%init(FaceTime);
	 }
	 else if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:MPHONE_ID]) {
	 	%init(Phone);
	 }
	 else if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:VIBER_ID]) {
	 	%init(Viber);
	 }
	 else if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:FBM_ID]) {
	 	%init(FBMessanger);
	 }
	 else if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:MMAIL_ID]) {
	 	%init(Mail);
	 }
	 else if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:SKYPE_ID]) {
	 	%init(Skype);
	 }
	 else if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:INSTAGRAM_ID]) {
	 	%init(Instagram);
	 }
	 else if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:TWTBOT_ID]) {
	 	%init(TweetBot);
	 }
	 else if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:BBM_ID]) {
	 	%init(BBM);
	 }
	 CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)ASKLoadPrefs, CFSTR("com.imokhles.besurebeforeprefs/ReloadPrefs"), NULL, kNilOptions);
}
