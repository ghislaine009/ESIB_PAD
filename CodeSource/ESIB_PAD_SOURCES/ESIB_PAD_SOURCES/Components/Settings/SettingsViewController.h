//
//  SettingsViewsController.h
//  ESIB@PAD
//
//  Created by Elias Medawar on 20.06.11.
//  Copyright 2011 HEFR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsDAO.h"
/**
 * Class that represent a view gernirc view Controller.
 * This class implement the UITextFieldDelegate so that we can change the textFieldShouldReturn value
 */
@interface SettingsViewController : UIViewController<UITextFieldDelegate> {
    /**
     The scroll viewer that contain all the visual element for the condifiguration
     */
    UIScrollView *mscrollview;
    /**
     The login textField
     */
    UITextField *login;
    /**
     The password textField
     */
    UITextField *pwd;
    /**
     The retain Switch(it's allow the user to chose if the system mut retain the  login information)
     */
    UISwitch *retenir;
    /**
        The url of the webservices textfield
     */
    UITextField *url;
    /**
     The UISegmentedControl for choosing the default map display option
     */
    UISegmentedControl *mapDisp;
    /**
     To now the position of the curently edited textfield.
     */
    UITextField *crntText;
    /**
        The data access object for get and saving the settings
     */
    SettingsDAO *sDao;
}
@property(nonatomic ,assign)IBOutlet UITextField *crntText;
@property(nonatomic ,assign)SettingsDAO * sDao;


@property(nonatomic ,assign)IBOutlet UIScrollView *mscrollview;
@property(nonatomic ,assign)IBOutlet UITextField *login;
@property(nonatomic ,assign)IBOutlet UITextField *pwd;
@property(nonatomic ,assign)IBOutlet UISwitch *retenir;
@property(nonatomic ,assign)IBOutlet UITextField *url;
@property(nonatomic ,assign)IBOutlet UISegmentedControl *mapDisp;

/*!
 @function registerNotifications
 @abstract Register the notification for each field of the view
 */
- (void) registerNotifications;
/**
 Refresh the values of the field from the DAO.
 */
- (void) refreshDisplay;
/*!
 * This listenter is caled when we click on a button, who fill the wole screen,
 * and then resignFirstResponder so the keyboard will be hided.
 */
- (IBAction)looseFocus:(id)sender;
/*!
 @function fieldChanged
 @abstract this methode respond to the Field changed Notificaiton event.
 @discussion This methode must read the value of the fields and set this values in the SettingsDAO 
 */
- (void) fieldChanged:(id) sender;
/*!
 @function resetSettings
 @abstract this methode reste the settings default values.
 */
- (IBAction)resetSettings:(id)sender;

@end
