//
//  ProfileViewController.h
//  RoommateApp
//
//  Created by Philip Nagel on 5/20/21.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) NSString *otherUsersUserID;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@end

NS_ASSUME_NONNULL_END
