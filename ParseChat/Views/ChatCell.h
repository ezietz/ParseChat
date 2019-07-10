//
//  ChatCell.h
//  ParseChat
//
//  Created by ezietz on 7/10/19.
//  Copyright © 2019 ezietz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *user;

@end

NS_ASSUME_NONNULL_END
