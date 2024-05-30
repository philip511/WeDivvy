//
//  LiveChatViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 6/18/21.
//

#import "MasterLiveChatViewController.h"
#import "AppDelegate.h"
#import "MasterLiveChatCell.h"

#import "GetDataObject.h"
#import "PushObject.h"

@interface MasterLiveChatViewController () {
    
    NSMutableArray *chatArray;
    NSArray *keyArray;
    
}

@end

@implementation MasterLiveChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self InitMethod];
    
    [[[GetDataObject alloc] init] GetDataMasterLiveChats:self->chatArray completionHandler:^(BOOL finished, NSMutableArray * _Nonnull chatArray) {
        
        self->chatArray = [chatArray mutableCopy];
        [self.customTableView reloadData];

    }];
    
}

-(void)viewDidLayoutSubviews {
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    _customTableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + 10000);
    
}

#pragma mark - Init Method

-(void)InitMethod {
    
    [self SetUpTableView];
    
}

#pragma mark - Setup Methods

-(void)SetUpTableView {
    
    _customTableView.delegate = self;
    _customTableView.dataSource = self;
    _customTableView.estimatedRowHeight = 44.0;
    _customTableView.rowHeight = UITableViewAutomaticDimension;
    
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

    MasterLiveChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MasterLiveChatCell"];

    cell.userIDLabel.text = self->chatArray[indexPath.row];
    
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self->chatArray count];

}

- (void)tableView:(UITableView *)tableView
willDisplayCell:(MasterLiveChatCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *userID = chatArray && [chatArray count] > indexPath.row ? chatArray[indexPath.row] : @"";
    
    [[[PushObject alloc] init] PushToLiveChatViewControllerFromMasterLiveChat:userID currentViewController:self];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return UITableViewAutomaticDimension;
    
}

@end
