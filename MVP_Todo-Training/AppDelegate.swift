//
//  AppDelegate.swift
//  MVP_Todo-Training
//
//  Created by 城野 on 2021/03/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! TodoListViewController
        let model = TodoModel()
        
        let presenter = TodoListPresenter(view: view, model: model)
        
        view.inject(presenter: presenter)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = view
        window?.makeKeyAndVisible()
        
        return true
    }
}

