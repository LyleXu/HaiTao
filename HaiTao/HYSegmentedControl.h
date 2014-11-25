#import <UIKit/UIKit.h>

@protocol HYSegmentedControlDelegate <NSObject>

@required

- (void)hySegmentedControlSelectAtIndex:(NSInteger)index;

@end

@interface HYSegmentedControl : UIView

@property (assign, nonatomic) id<HYSegmentedControlDelegate>delegate;
- (id)initWithOriginY:(CGFloat)y width:(CGFloat)width Titles:(NSArray *)titles delegate:(id)delegate;
- (id)initWithOriginY:(CGFloat)y Titles:(NSArray *)titles delegate:(id)delegate;

- (void)changeSegmentedControlWithIndex:(NSInteger)index;

@end
