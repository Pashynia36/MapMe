//
//  MapViewController.swift
//  MapMe
//
//  Created by Pavlo Novak on 9/21/19.
//  Copyright © 2019 Pavlo Novak. All rights reserved.
//

import UIKit
import GoogleMaps

/// Represents main map screen
final class MapViewController: UIViewController {

	private let locationManager = CLLocationManager()

	/// GoogleMap view
	private lazy var mapView: GMSMapView = {
		let mapView: GMSMapView = GMSMapView()
		mapView.translatesAutoresizingMaskIntoConstraints = false
		return mapView
	}()

	/// Search bar
	private lazy var searchBar: UISearchBar = {
		let searchBar: UISearchBar = UISearchBar()
		searchBar.translatesAutoresizingMaskIntoConstraints = false
		searchBar.setBackgroundImage(UIImage(),
									 for: .any,
									 barMetrics: .default)
		return searchBar
	}()

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .default
	}

	// MARK: - ViewController

    override func viewDidLoad() {
        super.viewDidLoad()

		setupUI()

		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
    }

	private func setupUI() {

		view.addSubview(mapView)
		NSLayoutConstraint.activate([
			mapView.topAnchor.constraint(equalTo: view.topAnchor),
			mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
			mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
			mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])

		view.addSubview(searchBar)
		NSLayoutConstraint.activate([
			searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
			searchBar.rightAnchor.constraint(equalTo: view.rightAnchor),
			searchBar.heightAnchor.constraint(equalToConstant: 44)
		])
	}
}

// MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager,
						 didChangeAuthorization status: CLAuthorizationStatus) {
		guard status == .authorizedWhenInUse else { return }

		locationManager.startUpdatingLocation()

		mapView.isMyLocationEnabled = true
		mapView.settings.myLocationButton = true
	}

	func locationManager(_ manager: CLLocationManager,
						 didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.last else { return }

		mapView.camera = GMSCameraPosition(target: location.coordinate,
										   zoom: 15,
										   bearing: 0,
										   viewingAngle: 0)

		locationManager.stopUpdatingLocation()

	}
}
