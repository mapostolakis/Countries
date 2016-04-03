//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAImageCell.h"
#import "UIImageView+MGAImageFetcher.h"

@interface MGAImageCell ()

@property (nonatomic, weak) UIImageView *backgroundImageView;

@end

@implementation MGAImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Subviews

- (UIImageView *)backgroundImageView
{
    if (_backgroundImageView == nil) {
        UIImageView *view = [[UIImageView alloc] init];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:view];
        _backgroundImageView = view;
    }
    return _backgroundImageView;
}

#pragma mark - Setup

- (void)setup
{
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self setupConstraints];
}

- (void)setupConstraints
{
    UIView *backgroundView = self.backgroundImageView;
    NSDictionary *views = NSDictionaryOfVariableBindings(backgroundView);

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[backgroundView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backgroundView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
}

#pragma mark - Public API

- (void)setImageForURL:(NSURL *)url
{
    [self.backgroundImageView setImageForURL:url];
}

@end