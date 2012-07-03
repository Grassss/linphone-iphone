/* UIMainBar.m
 *
 * Copyright (C) 2012  Belledonne Comunications, Grenoble, France
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or   
 *  (at your option) any later version.                                 
 *                                                                      
 *  This program is distributed in the hope that it will be useful,     
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of      
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       
 *  GNU Library General Public License for more details.                
 *                                                                      
 *  You should have received a copy of the GNU General Public License   
 *  along with this program; if not, write to the Free Software         
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

#import "UIMainBar.h"
#import "PhoneMainView.h"

@implementation UIMainBar

@synthesize historyButton;
@synthesize contactsButton;
@synthesize dialerButton;
@synthesize settingsButton;
@synthesize chatButton;


#pragma mark - Lifecycle Functions

- (id)init {
    return [super initWithNibName:@"UIMainBar" bundle:[NSBundle mainBundle]];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}


#pragma mark - ViewController Functions

- (void)viewDidLoad {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeView:) name:@"LinphoneMainViewChange" object:nil];
    [self update:[[LinphoneManager instance] currentView]];
}

- (void)viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [historyButton release];
    [contactsButton release];
    [dialerButton release];
    [settingsButton release];
    [chatButton release];
}

#pragma mark - 

- (void)changeView: (NSNotification*) notif {  
    NSNumber *viewNumber = [notif.userInfo objectForKey: @"view"];
    if(viewNumber != nil)
        [self update:[viewNumber intValue]];
}

- (void)update:(PhoneView) view {
    if(view == PhoneView_History) {
        historyButton.selected = TRUE;
    } else {
        historyButton.selected = FALSE;
    }
    if(view == PhoneView_Contacts) {
        contactsButton.selected = TRUE;
    } else {
        contactsButton.selected = FALSE;
    }
    if(view == PhoneView_Dialer) {
        dialerButton.selected = TRUE;
    } else {
        dialerButton.selected = FALSE;
    }
    if(view == PhoneView_Settings) {
        settingsButton.selected = TRUE;
    } else {
        settingsButton.selected = FALSE;
    }
    if(view == PhoneView_Chat) {
        chatButton.selected = TRUE;
    } else {
        chatButton.selected = FALSE;
    }
}


#pragma mark - Action Functions

- (IBAction)onHistoryClick: (id) sender {
    [[LinphoneManager instance] changeView:PhoneView_History];
}

- (IBAction)onContactsClick: (id) event {
    [[LinphoneManager instance] changeView:PhoneView_Contacts];
}

- (IBAction)onDialerClick: (id) event {
    [[LinphoneManager instance] changeView:PhoneView_Dialer];
}

- (IBAction)onSettingsClick: (id) event {
    [[LinphoneManager instance] changeView:PhoneView_Settings];
}

- (IBAction)onChatClick: (id) event {
    [[LinphoneManager instance] changeView:PhoneView_Chat];
}


@end