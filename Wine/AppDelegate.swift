//
//  AppDelegate.swift
//  SwaplNFC
//
//  Created by Apple on 26/02/21.
//

import UIKit
import CoreData
import GoogleSignIn
import Firebase
import Stripe
@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var isBack = false
    var strSelectedType = ""
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        StripeAPI.defaultPublishableKey = "pk_test_51JS7Q8LrOr9KQcpTd3kYfxRsEmvpv20FfIte7JXIHvwdQfe8Yuy0AMWNXCae3XcHaK4LGuj5lZxG4zr84i192HFb00k4zYzGYm"
      
        Thread.sleep(forTimeInterval: 3.0)
        
        if UserDefaults.standard.string(forKey: "isWelcome") == "YES"{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootViewController: KYDrawerController? = storyboard.instantiateViewController(withIdentifier: "KYDrawerController") as? KYDrawerController
            let nav = UINavigationController(rootViewController: rootViewController!)
            nav.isNavigationBarHidden = true
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
        } else{


        }
        // Override point for customization after application launch.
        return true
    }

    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        
        

    }


    func application(
      _ app: UIApplication,
      open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
      var handled: Bool

      handled = GIDSignIn.sharedInstance.handle(url)
      if handled {
        return true
      }

      // Handle other custom URL types.

      // If not handled by this app, return false.
      return false
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
    
        let container = NSPersistentContainer(name: "OTGA")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
 
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support


    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
        
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

