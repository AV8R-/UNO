//
//  AppDelegate.swift
//  UNO
//
//  Created by Богдан Маншилин on 09/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static let container = Container()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        ServicesAssembley.register(container: AppDelegate.container)
        UIView.insetsInit()

        return true
    }
}

