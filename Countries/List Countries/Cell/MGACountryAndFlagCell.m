//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryAndFlagCell.h"
#import "UIImageView+MGAImageFetcher.h"

@interface MGACountryAndFlagCell ()

@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIImageView *flagView;

@end

@implementation MGACountryAndFlagCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Subviews

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UIImageView *)flagView
{
    if (_flagView == nil) {
        UIImageView *view = [[UIImageView alloc] init];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        view.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:view];
        _flagView = view;
    }
    return _flagView;
}

#pragma mark - Setup

- (void)setup
{
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self setupConstraints];
}

- (void)setupConstraints
{
    UIView *nameLabel = self.nameLabel;
    UIView *flagView = self.flagView;

    NSDictionary *views = NSDictionaryOfVariableBindings(nameLabel, flagView);

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[flagView(40)]-[nameLabel]-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[flagView]-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[nameLabel]-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
}

#pragma mark - Public API

- (void)setName:(NSString *)name
{
    self.nameLabel.text = name;
}

- (void)setFlagURL:(NSURL *)url
{
    [self.flagView setImageForURL:url];
}

@end