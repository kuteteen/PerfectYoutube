#import "PerfectYoutube.h"

// ENABLE BACKGROUND PLAYBACK

%group backgroundPlaybackGroup

	%hook YTSingleVideo

	- (BOOL)isPlayableInBackground
	{
		return YES;
	}

	%end

	%hook YTPlaybackData

	- (BOOL)isPlayableInBackground
	{
		return YES;
	}

	%end

	%hook YTPlaybackBackgroundTaskController

	- (BOOL)isContentPlayableInBackground
	{
		return YES;
	}

	%end

	%hook YTIPlayerResponse

	- (BOOL)isPlayableInBackground
	{
		return YES;
	}

	%end

	%hook YTIPlayabilityStatus

	- (BOOL)isPlayableInBackground
	{
		return YES;
	}

	%end

	%hook YTPlaybackBackgroundTaskController

	- (void)setContentPlayableInBackground: (BOOL)arg
	{
		%orig(YES);
	}

	%end

%end

// DISABLE ADS

%group disableAdsGroup

	%hook YTIPlayerResponse

	- (BOOL)isMonetized
	{
		return NO;
	}

	%end

%end

// HIDE DOWNLOAD BUTTON

%group hideDownloadButtonGroup

	%hook YTTransferButton

	- (void)setVisible: (_Bool)arg1 dimmed: (_Bool)arg2
	{
		%orig(NO, NO);
	}

	%end

%end

// HIDE CAST BUTTON

%group hideCastButtonGroup

	%hook YTSettings

	- (void)setDisableMDXDeviceDiscovery:(_Bool)arg1
	{
		%orig(YES);
	}

	%end

	%hook MDXPlaybackRouteButtonController

	- (_Bool)isPersistentCastIconEnabled
	{
		return NO;
	}

	- (void)updateButton:(id)arg1
	{

	}

	%end

%end

// HIDE VOICE SEARCH BUTTON

%group hideVoiceSearchButtonGroup

	%hook YTSearchTextField

	- (void)setVoiceSearchEnabled:(_Bool)arg1
	{
		%orig(NO);
	}

	%end

%end	

// DISABLE HINTS

%group disableHintsGroup

	%hook YTSettings

	- (_Bool)areHintsDisabled
	{
		return YES;
	}

	- (void)setHintsDisabled:(_Bool)arg1
	{
		%orig(YES);
	}

	%end

	%hook YTUserDefaults

	- (_Bool)areHintsDisabled
	{
		return YES;
	}

	- (void)setHintsDisabled:(_Bool)arg1
	{
		%orig(YES);
	}

	%end

%end	

// HIDE INBOX TAB

%group hideInboxTabGroup

	%hook YTPivotBarView

	- (void)layoutSubviews
	{
		%orig;

		YTPivotBarItemView *item = MSHookIvar<YTPivotBarItemView*> (self, "_itemView4");
		item.hidden = YES;
	}

	- (YTPivotBarItemView*)itemView4
	{
		return 0;
	}

	%end

%end

%ctor
{
	@autoreleasepool
	{
		pref = [[HBPreferences alloc] initWithIdentifier: @"com.johnzaro.perfectyoutubeprefs"];

		[pref registerBool: &backgroundPlayback default: YES forKey: @"backgroundPlayback"];
		[pref registerBool: &disableAds default: YES forKey: @"disableAds"];
		[pref registerBool: &hideDownloadButton default: YES forKey: @"hideDownloadButton"];
		[pref registerBool: &hideCastButton default: YES forKey: @"hideCastButton"];
		[pref registerBool: &hideVoiceSearchButton default: YES forKey: @"hideVoiceSearchButton"];
		[pref registerBool: &disableHints default: YES forKey: @"disableHints"];
		[pref registerBool: &hideInboxTab default: YES forKey: @"hideInboxTab"];

        if(backgroundPlayback) %init(backgroundPlaybackGroup);
        if(disableAds) %init(disableAdsGroup);
        if(hideDownloadButton) %init(hideDownloadButtonGroup);
        if(hideCastButton) %init(hideCastButtonGroup);
        if(hideVoiceSearchButton) %init(hideVoiceSearchButtonGroup);
        if(disableHints) %init(disableHintsGroup);
        if(hideInboxTab) %init(hideInboxTabGroup);
    }
}
