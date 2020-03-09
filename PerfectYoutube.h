#import <Cephei/HBPreferences.h>

HBPreferences *_Nullable pref;

BOOL backgroundPlayback;
BOOL disableAds;
BOOL hideDownloadButton;
BOOL hideCastButton;
BOOL hideVoiceSearchButton;
BOOL disableHints;
BOOL hideInboxTab;

@interface YTQTMButton: UIButton
@end

@interface YTPivotBarItemView: UIView
@property(retain, nonatomic) YTQTMButton *_Nullable navigationButton;
@end

@interface YTPivotBarView: UIView
@property(retain, nonatomic) YTPivotBarItemView *_Nullable itemView4;
@end
