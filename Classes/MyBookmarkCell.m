#import "MyBookmarkCell.h"
#import "MyBookmarkCellSelectedBackgroundView.h"
#import "TableCellDrawing.h"

@implementation MyBookmarkCell

@synthesize titleText;
@synthesize linkText;
@synthesize numberText;

static UIColor *blueColor = NULL;
static UIColor *darkGrayColor = NULL;

+ (void)initialize {
	blueColor = [[UIColor colorWithRed:0.0f green:0.2f blue:1.0f alpha:1.0f] retain];
	darkGrayColor = [[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f] retain];
}

- (void)setTitleText:(NSString *)text {
	if (titleText != text) {
		[titleText release];
		titleText = [text retain];
		[self setNeedsDisplay];
	}
}

- (void)setLinkText:(NSString *)text {
	if (linkText != text) {
		[linkText release];
		linkText = [text retain];
		[self setNeedsDisplay];
	}
}

- (void)setNumberText:(NSString *)text {
	if (numberText != text) {
		[numberText release];
		numberText = [text retain];
		[self setNeedsDisplay];
	}
}

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
		[self setOpaque:YES];
		
		MyBookmarkCellSelectedBackgroundView *selectedBackgroundView = [[MyBookmarkCellSelectedBackgroundView alloc] initWithFrame:[self frame]];
		[selectedBackgroundView setCell:self];
		[self setSelectedBackgroundView:selectedBackgroundView];
		[selectedBackgroundView release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
	[self setNeedsDisplay];
	[self.selectedBackgroundView setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	[blueColor set];
	[titleText drawInRect:CGRectMake(20.0f, 5.0f, 277.0f, 37.0f) withFont:[UIFont boldSystemFontOfSize:14.0f] lineBreakMode:UILineBreakModeTailTruncation];
	[darkGrayColor set];
	[linkText drawInRect:CGRectMake(20.0f, 40.0f, 277.0f, 28.0f) withFont:[UIFont systemFontOfSize:12.0f] lineBreakMode:UILineBreakModeTailTruncation];
	[[UIColor blackColor] set];
	[numberText drawInRect:CGRectMake(0.0f, 28.0f, 16.0f, 21.0f) withFont:[UIFont systemFontOfSize:9.0f] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentRight];
}

- (void)drawSelectedBackgroundRect:(CGRect)rect {
	CGGradientRef gradientForSelected = createTwoColorsGradient(5, 140, 245, 1, 93, 230);
	drawRoundedRectBackgroundGradient(rect, gradientForSelected, NO, NO, NO);
	CGGradientRelease(gradientForSelected);
	[[UIColor whiteColor] set];
	[titleText drawInRect:CGRectMake(20.0f, 5.0f, 277.0f, 37.0f) withFont:[UIFont boldSystemFontOfSize:14.0f] lineBreakMode:UILineBreakModeTailTruncation];
	[linkText drawInRect:CGRectMake(20.0f, 40.0f, 277.0f, 28.0f) withFont:[UIFont systemFontOfSize:12.0f] lineBreakMode:UILineBreakModeTailTruncation];
	[numberText drawInRect:CGRectMake(0.0f, 28.0f, 16.0f, 21.0f) withFont:[UIFont systemFontOfSize:9.0f] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentRight];
}

- (void)dealloc {
	[titleText release];
	[linkText release];
	[numberText release];
	[super dealloc];
}

@end
