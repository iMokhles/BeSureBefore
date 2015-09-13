#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#include <sys/cdefs.h>
#include <substrate.h>
#include <notify.h>
#import <AudioToolbox/AudioToolbox.h>

// Apllications IDS
#define BBM_ID @"com.blackberry.bbm1"
#define INSTAGRAM_ID @"com.burbn.instagram"
#define FBM_ID @"com.facebook.Messenger"
#define VIBER_ID @"com.viber"
#define APSMS_ID @"com.apple.MobileSMS"
#define TWTBOT_ID @"com.tapbots.Tweetbot3"
#define FTIME_ID @"com.apple.facetime"
#define MMAIL_ID @"com.apple.mobilemail"
#define SKYPE_ID @"com.skype.skype"
#define MPHONE_ID @"com.apple.mobilephone"
#define WHATSAPP_ID @"net.whatsapp.WhatsApp"

// Settings
#define GET_BOOL(key, default) (prefs[key] ? ((NSNumber *)prefs[key]).boolValue : default)
#define GET_FLOAT(key, default) (prefs[key] ? ((NSNumber *)prefs[key]).floatValue : default)
#define GET_INT(key, default) (prefs[key] ? ((NSNumber *)prefs[key]).intValue : default)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

static NSString *const kASKPrefsPath = @"/var/mobile/Library/Preferences/com.imokhles.besurebeforeprefs.plist";
// Settings Keys
static NSString *const kSMSAskKey = @"smsASK";
static NSString *const kBBMAskKey = @"bbmASK";
static NSString *const kFTAskKey = @"ftASK";
static NSString *const kINSTAskKey = @"instaASK";
static NSString *const kFBMAskKey = @"fbmASK";
static NSString *const kVIBRAskKey = @"viberASK";
static NSString *const kTWTBOTAskKey = @"twtbotASK";
static NSString *const kMAILAskKey = @"mailASK";
static NSString *const kSKYAskKey = @"skypeASK";
static NSString *const kPHONEAskKey = @"phoneASK";
static NSString *const kWHATSAskKey = @"whatsASK";

// Advanced Settings Keys
static NSString *const kSoundAskKey = @"soundASK";
static NSString *const kVIBAskKey = @"vibASK";

// Advanced Options
static BOOL soundAlertBOOL = NO;
static BOOL vibraAlertBOOL = NO;

// SMS Options
static BOOL smsASKBOOL = NO;

// FaceTime Options
static BOOL ftASKBOOL = NO;

// WhatsApp Options
static BOOL whatsASKBOOL = NO;

// Phone Options
static BOOL phoneASKBOOL = NO;

// Viber Options
static BOOL viberASKBOOL = NO;

// FBMessanger Options
static BOOL fbmASKBOOL = NO;

// Mail Options
static BOOL mailASKBOOL = NO;

// Skype Options
static BOOL skypeASKBOOL = NO;

// Instagram Options
static BOOL instaASKBOOL = NO;

// TweetBot Options
static BOOL twtbotASKBOOL = NO;

// BBM Options
static BOOL bbmASKBOOL = NO;

// MY BOOL
static BOOL besureBeforeConfirmed = NO;

static BOOL isFirstRun;

@interface AVAudioPlayer : NSObject
{}
@property int numberOfLoops;
@property float volume;
- (BOOL)play;
- (id)initWithData:(id)arg1 error:(id *)arg2;
@end

@interface BeSureBeforeClass : NSObject <UIAlertViewDelegate>
@end

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
	// testing

	// system ("killall Messanger");
	// system ("killall WhatsApp");
	// //system ("killall FaceTime");
	// //system ("killall MobilePhone");
	// system ("killall Skype");
	// system ("killall BBM");
	// system ("killall Viber");
	// system ("killall Tweetbot");
	// system ("killall Instagram");
	// system ("killall Mail");
	// system ("killall MobileSMS");

	NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:kASKPrefsPath];
	soundAlertBOOL = 	  GET_BOOL(kSoundAskKey, NO);
	vibraAlertBOOL = 	  GET_BOOL(kVIBAskKey, NO);
	smsASKBOOL = GET_BOOL(kSMSAskKey, NO);
	whatsASKBOOL = GET_BOOL(kWHATSAskKey, NO);
	ftASKBOOL = GET_BOOL(kFTAskKey, NO);
	phoneASKBOOL = GET_BOOL(kPHONEAskKey, NO);
	bbmASKBOOL = GET_BOOL(kBBMAskKey, NO);
	skypeASKBOOL = GET_BOOL(kSKYAskKey, NO);
	instaASKBOOL = GET_BOOL(kINSTAskKey, NO);
	mailASKBOOL = GET_BOOL(kMAILAskKey, NO);
	twtbotASKBOOL = GET_BOOL(kTWTBOTAskKey, NO);
	fbmASKBOOL = GET_BOOL(kFBMAskKey, NO);
	viberASKBOOL = GET_BOOL(kVIBRAskKey, NO);

	if (!prefs) {
		isFirstRun = YES;
		%init(FirstRun);

		[@{} writeToFile:kASKPrefsPath atomically:YES];
	}
}
%ctor {
	%init;
	ASKLoadPrefs();
	// NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
	 if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:WHATSAPP_ID]) {
	 	%init(WhatsApp);
	 }
	 if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:APSMS_ID]) {
	 	%init(SMS);
	 }
	 if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:FTIME_ID]) {
	 	%init(FaceTime);
	 }
	 if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:MPHONE_ID]) {
	 	%init(Phone);
	 }
	 if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:VIBER_ID]) {
	 	%init(Viber);
	 }
	 if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:FBM_ID]) {
	 	%init(FBMessanger);
	 }
	 if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:MMAIL_ID]) {
	 	%init(Mail);
	 }
	 if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:SKYPE_ID]) {
	 	%init(Skype);
	 }
	 if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:INSTAGRAM_ID]) {
	 	%init(Instagram);
	 }
	 if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:TWTBOT_ID]) {
	 	%init(TweetBot);
	 }
	 if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:BBM_ID]) {
	 	%init(BBM);
	 }
	 CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)ASKLoadPrefs, CFSTR("com.imokhles.besurebeforeprefs/ReloadPrefs"), NULL, kNilOptions);
}



