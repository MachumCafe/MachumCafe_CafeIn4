//
//  MainSideBarViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class MainSideBarViewController: UIViewController {
    @IBOutlet weak var sideBarView: UIView!
    @IBOutlet weak var sideBarLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userInfoLabel: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var myBookmarkButton: UIButton!
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        checkIsUser()
        UIApplication.shared.keyWindow?.windowLevel = (UIWindowLevelStatusBar + 1)
        sideBarLeadingConstraint.constant = -(self.sideBarView.frame.width+10)
        sideBarView.layer.shadowOpacity = 0.5
        sideBarView.layer.shadowColor = UIColor.black.cgColor
        sideBarView.layer.shadowRadius = 3
        userProfileImageView.layer.masksToBounds = true
        userProfileImageView.layer.cornerRadius = CGFloat(userProfileImageView.frame.height / 2)
        
        // 코드 정리 시 지울 것
        buttonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIsUser()
    }
    
    func checkIsUser() {
        switch User.sharedInstance.isUser {
        case false :
            userProfileImageView.image = #imageLiteral(resourceName: "profil_side")
            userInfoLabel.text = "로그인 후 이용하세요."
            logInButton.isHidden = false
        case true :
            userProfileImageView.image = #imageLiteral(resourceName: "profil_side")
            userInfoLabel.text = ("\(User.sharedInstance.user.getUser()["nickname"] as! String)님")
            logInButton.isHidden = true
        }
    }
    
    func buttonInit() {
        //Button Design
        logInButton.layer.borderWidth = 1
        logInButton.layer.borderColor = UIColor.gray.cgColor
        logInButton.layer.cornerRadius = self.logInButton.frame.height/CGFloat(2)
        logInButton.tintColor = UIColor.lightGray
        logInButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
        
        reportButton.tintColor = UIColor.black
        myBookmarkButton.tintColor = UIColor.black
        
        //Make Underline
        
        // Make Underline
        let attrs = [NSFontAttributeName : UIFont.systemFont(ofSize: 15),
                     NSForegroundColorAttributeName : UIColor.gray,
                     NSUnderlineStyleAttributeName : 1] as [String : Any]
        
        let buttonTitleString = NSMutableAttributedString(string: "설정", attributes:attrs)
        settingButton.setAttributedTitle(buttonTitleString, for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.sideBarLeadingConstraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func logInButtonAction(_ sender: Any) {
        let logInStoryboard = UIStoryboard(name: "LogIn&SignUpView", bundle: nil)
        let logInViewController = logInStoryboard.instantiateViewController(withIdentifier: "LogIn")
        present(logInViewController, animated: true, completion: nil)
    }
    
    @IBAction func bookmarkButtonAction(_ sender: Any) {
        let bookmarkStoryboard = UIStoryboard(name: "BookmarkView", bundle: nil)
        let bookmarkViewController = bookmarkStoryboard.instantiateViewController(withIdentifier: "Bookmark")
        //        let navigationVC = UINavigationController(rootViewController: bookmarkViewController)
        //        self.navigationController?.pushViewController(bookmarkViewController, animated: true)
        present(bookmarkViewController, animated: true, completion: nil)
    }
    
    @IBAction func reportButtonAction(_ sender: Any) {
    
    }
    
    @IBAction func settingButtonAction(_ sender: Any) {
        let settingStoryboard = UIStoryboard(name: "SettingView", bundle: nil)
        let settingViewController = settingStoryboard.instantiateViewController(withIdentifier: "SettingView")
        present(settingViewController, animated: true, completion: nil)
    }
    
    @IBAction func closeViewButtonAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.sideBarLeadingConstraint.constant = -(self.sideBarView.frame.width+10)
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
            self.view.layoutIfNeeded()
        }) { (bool) in
            UIApplication.shared.keyWindow?.windowLevel = (UIWindowLevelStatusBar - 1)
            self.dismiss(animated: false, completion: nil)
        }
    }
}