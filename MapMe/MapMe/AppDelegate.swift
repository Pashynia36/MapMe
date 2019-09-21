//
//  AppDelegate.swift
//  MapMe
//
//  Created by Pavlo Novak on 9/21/19.
//  Copyright © 2019 Pavlo Novak. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	private let apiKey = "AIzaSyCQWNd7jU1gjsKcbeip1wg8_usvQ42nifs"

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		// Google maps service
		GMSServices.provideAPIKey(apiKey)

		window = UIWindow(frame: UIScreen.main.bounds)
		let mapViewController = MapViewController()
		self.window?.rootViewController = mapViewController
		self.window?.makeKeyAndVisible()

		return true
	}
}

