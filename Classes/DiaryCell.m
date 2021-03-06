//
//  DiaryCell.m
//  HatenaTouch
//
//  Created by Kishikawa Katsumi on 10/07/17.
//  Copyright 2010 Kishikawa Katsumi. All rights reserved.
//

#import "DiaryCell.h"

static UIColor *blueColor;
static UIColor *grayColor;
static UIColor *darkGrayColor;

static UIFont *titleFont;
static UIFont *dateFont;

@interface DiaryCellContentView : UIView {
    DiaryCell *cell;
    BOOL highlighted;
}

@end

@implementation DiaryCellContentView

+ (void)initialize {
    blueColor = [[UIColor colorWithRed:0.0f green:0.2f blue:1.0f alpha:1.0f] retain];
    grayColor = [[UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.0f] retain];
    darkGrayColor = [[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f] retain];
    
    titleFont = [[UIFont boldSystemFontOfSize:14.0f] retain];
    dateFont = [[UIFont systemFontOfSize:12.0f] retain];
}

- (id)initWithFrame:(CGRect)frame cell:(DiaryCell *)tableCell {
    if (self = [super initWithFrame:frame]) {
        cell = tableCell;
        self.opaque = YES;
        self.backgroundColor = cell.backgroundColor;
    }
    
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)drawRect:(CGRect)rect {
    highlighted ? [[UIColor whiteColor] set] : [blueColor set];
    [cell.title drawInRect:CGRectMake(14.0f, 4.0f, cell.frame.size.width - 44.0f, 36.0f) withFont:titleFont lineBreakMode:UILineBreakModeTailTruncation];

    highlighted ? [[UIColor whiteColor] set] : [darkGrayColor set];
    [cell.date drawInRect:CGRectMake(14.0f, 42.0f, cell.frame.size.width - 44.0f, 20.0f) withFont:dateFont lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentRight];
}

- (void)setHighlighted:(BOOL)b {
    highlighted = b;
    [self setNeedsDisplay];
}

- (BOOL)isHighlighted {
    return highlighted;
}

@end

@implementation DiaryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        cellContentView = [[DiaryCellContentView alloc] initWithFrame:CGRectInset(self.contentView.bounds, 0.0f, 1.0f) cell:self];
        cellContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        cellContentView.contentMode = UIViewContentModeRedraw;
        [self.contentView addSubview:cellContentView];
        [cellContentView release];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [UIView setAnimationsEnabled:NO];
    CGSize contentSize = cellContentView.bounds.size;
    cellContentView.contentStretch = CGRectMake(225.0f / contentSize.width, 0.0f, (contentSize.width - 260.0f) / contentSize.width, 1.0f);
    [UIView setAnimationsEnabled:YES];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    cellContentView.backgroundColor = backgroundColor;
}

- (void)setNeedsDisplay {
    [super setNeedsDisplay];
    [cellContentView setNeedsDisplay];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
}

- (void)dealloc {
    self.title = nil;
    self.date = nil;
    [super dealloc];
}

@end
