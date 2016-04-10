//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryCoordinateDetailsCell.h"

@interface MGACountryCoordinateDetailsCell ()

@property (nonatomic, weak) UILabel *latitudeLabel;
@property (nonatomic, weak) UILabel *longitudeLabel;

@end

@implementation MGACountryCoordinateDetailsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Subviews

- (UILabel *)latitudeLabel
{
    if (_latitudeLabel == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:label];
        _latitudeLabel = label;
    }
    return _latitudeLabel;
}

- (UILabel *)longitudeLabel
{
    if (_longitudeLabel == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:label];
        _longitudeLabel = label;
    }
    return _longitudeLabel;
}

#pragma mark - Setup

- (void)setup
{
    [self setupConstraints];
}

- (void)setupConstraints
{
    UIView *latitudeLabel = self.latitudeLabel;
    UIView *longitudeLabel = self.longitudeLabel;

    NSDictionary *views = NSDictionaryOfVariableBindings(latitudeLabel, longitudeLabel);

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[latitudeLabel]-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[longitudeLabel]-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[latitudeLabel]-[longitudeLabel]-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
}

#pragma mark - Public API

- (void)setLatitude:(NSString *)latitude
{
    self.latitudeLabel.text = latitude;
}

- (void)setLongitude:(NSString *)longitude
{
    self.longitudeLabel.text = longitude;
}

@end