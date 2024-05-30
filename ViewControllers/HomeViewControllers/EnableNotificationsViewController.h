//
//  EnableNotificationsViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 11/10/21.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EnableNotificationsViewController : UIViewController <SKProductsRequestDelegate>

@property (assign, nonatomic) BOOL comingFromCreateHome;
@property (assign, nonatomic) BOOL clickedUnclaimedUser;

@property (strong, nonatomic) NSString *homeIDLinkedToKey;
@property (strong, nonatomic) NSString *homeKey;

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *enableNotificationsButton;
@property (weak, nonatomic) IBOutlet UIButton *maybeLabelButton;

@end

NS_ASSUME_NONNULL_END
