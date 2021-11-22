//
//  RaisedTabBarController.swift
//  SwiftRaisedTabDemo
//
//  Created by Kaynine on 9/23/2015.
//  Copyright (c) 2015 Kaynine. All rights reserved.
//

import UIKit

import Alamofire


open class CustomTabBarController: UITabBarController,UINavigationControllerDelegate {
    var controller1 : HomeViewController!
    var controller2 : CellarViewController!
    var controller3 : WizardViewController!
    var controller4 : KnowledgeViewController!
    var controller5 : ProfileViewController!
    var userDefaults = UserDefaults.standard
    open override func viewDidLoad() {
        super.viewDidLoad()
 
        

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller1 = (storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController)
        //controller1.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        controller1.tabBarItem = (self.tabBar.items?[0])! as UITabBarItem
        controller1.tabBarItem.image = UIImage(named: "Home")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        controller1.tabBarItem.selectedImage = UIImage(named: "Home")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        controller1.tabBarItem.title = "Home"
        controller1.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
        let nav1 = UINavigationController(rootViewController: controller1)
        nav1.navigationBar.isHidden = true
        
        UITabBar.appearance().clipsToBounds = false
    
        
        controller2 = (storyboard.instantiateViewController(withIdentifier: "CellarViewController") as! CellarViewController)
        //controller1.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        controller2.tabBarItem = (self.tabBar.items?[1])! as UITabBarItem
        controller2.tabBarItem.image = UIImage(named: "Seller")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        controller2.tabBarItem.selectedImage = UIImage(named: "Seller")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
      
        controller2.tabBarItem.title = "My Cellar"
       
        controller2.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let nav2 = UINavigationController(rootViewController: controller2)
        nav2.navigationBar.isHidden = true

        
        
        controller3 = (storyboard.instantiateViewController(withIdentifier: "WizardViewController") as! WizardViewController)
    controller3.tabBarItem = (self.tabBar.items?[2])! as UITabBarItem
      //  controller3.tabBarItem.image = UIImage(named: "wizardFull")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
       // controller3.tabBarItem.selectedImage = UIImage(named: "wizardFull")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        controller3.tabBarItem.title = ""
        controller3.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //controller3.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        let nav3 = UINavigationController(rootViewController: controller3)
        nav3.navigationBar.isHidden = true


        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 4
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
       
        
        controller4 = (storyboard.instantiateViewController(withIdentifier: "KnowledgeViewController") as! KnowledgeViewController)
        controller4.tabBarItem = (self.tabBar.items?[3])! as UITabBarItem
        controller4.tabBarItem.image = UIImage(named: "Knowledge")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        controller4.tabBarItem.selectedImage = UIImage(named: "Knowledge")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        controller4.tabBarItem.title = "Knowledge"
        controller4.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //controller3.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        let nav4 = UINavigationController(rootViewController: controller4)
        nav4.navigationBar.isHidden = true
        
        
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 4
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
        
        controller5 = (storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController)
        controller5.tabBarItem = (self.tabBar.items?[4])! as UITabBarItem
        controller5.tabBarItem.image = UIImage(named: "Suggestion")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        controller5.tabBarItem.selectedImage = UIImage(named: "Suggestion")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        controller5.tabBarItem.title = "Suggestion"
        controller5.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //controller3.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        let nav5 = UINavigationController(rootViewController: controller5)
        nav5.navigationBar.isHidden = true
        
        
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 4
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
        
        
        viewControllers = [nav1,nav2,nav3,nav4,nav5]
  
        if CurrentDevice.IS_IPHONE_X_OR_LOWER{
            self.tabBar.backgroundImage = UIImage()
            self.tabBar.shadowImage = UIImage()
            var tabBarView = UIImageView(image: UIImage(named: "Curvepava"))
            
            tabBarView.frame = CGRect(x: 0, y: 40 - 80, width: CurrentDevice.SCREEN_WIDTH , height: 80)
            tabBarView.scalesLargeContentImage = true
            self.tabBar.addSubview(tabBarView)
            self.tabBar.sendSubviewToBack(tabBarView)
        }else{
            self.tabBar.backgroundImage = UIImage()
            self.tabBar.shadowImage = UIImage()
            var tabBarView = UIImageView(image: UIImage(named: "Curvepava"))
            tabBarView.frame = CGRect(x: 0, y: 49 - 80, width: CurrentDevice.SCREEN_WIDTH , height: 80)
            tabBarView.scalesLargeContentImage = true
            self.tabBar.addSubview(tabBarView)
            self.tabBar.sendSubviewToBack(tabBarView)
        }

        self.tabBar.tintColor = #colorLiteral(red: 0.5568627451, green: 0.007843137255, blue: 0.1215686275, alpha: 1)
        
       // self.tabBar.barTintColor = #colorLiteral(red: 0.5555219054, green: 0.006600257009, blue: 0.1205148473, alpha: 1)
        

       setupMiddleButton()
    }
    
    open func setupMiddleButton() {
        
        var menuButton = UIButton()
        
        if CurrentDevice.IS_IPHONE_X_OR_LOWER{
            menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
            var menuButtonFrame = menuButton.frame
            menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 10
            menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
            menuButton.frame = menuButtonFrame
            
            menuButton.backgroundColor = UIColor.white
            menuButton.layer.shadowColor = #colorLiteral(red: 0.5568627451, green: 0.007843137255, blue: 0.1215686275, alpha: 1)
            menuButton.layer.shadowOpacity = 0.3
            menuButton.layer.shadowOffset = .zero
            menuButton.layer.shadowRadius = 5
            menuButton.layer.cornerRadius = menuButtonFrame.height/2
            menuButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5);
            view.addSubview(menuButton)
            
            menuButton.setImage(UIImage(named: "wizard"), for: .normal)
            
            menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
            
            view.layoutIfNeeded()

        }else{
            menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 80))

            var menuButtonFrame = menuButton.frame
            menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 25
            menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
            menuButton.frame = menuButtonFrame
            
            menuButton.backgroundColor = UIColor.white
            menuButton.layer.shadowColor = #colorLiteral(red: 0.5568627451, green: 0.006600257009, blue: 0.1205148473, alpha: 1)
            menuButton.layer.shadowOpacity = 0.3
            menuButton.layer.shadowOffset = .zero
            menuButton.layer.shadowRadius = 5
            menuButton.layer.cornerRadius = menuButtonFrame.height/2
            menuButton.imageEdgeInsets = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20);
            view.addSubview(menuButton)
            
            menuButton.setImage(UIImage(named: "wizardFull"), for: .normal)
            
           menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
            
            view.layoutIfNeeded()

        }
           }
    @objc private func menuButtonAction(sender: UIButton) {
        selectedIndex = 2
//        let nav3 = UINavigationController(rootViewController: controller3)
//        nav3.navigationBar.isHidden = true
//
//
//        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
//        tabBar.layer.shadowRadius = 4
//        tabBar.layer.shadowColor = UIColor.black.cgColor
//        tabBar.layer.shadowOpacity = 0.3
        
    }
    
    
    
    
}


