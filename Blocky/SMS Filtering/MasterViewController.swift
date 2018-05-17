//
//  MasterViewController.swift
//  Blocky
//
//  Created by Nayem on 4/19/18.
//  Copyright © 2018 Mufakkharul Islam Nayem. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    @IBOutlet private weak var segmentedControl: UISegmentedControl!

    var stateController: StateController!

    private lazy var filterWordsViewController: FilterWordsViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "FilterWordsViewController") as! FilterWordsViewController
        viewController.stateController = stateController
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        return viewController
    }()

    private lazy var filterNumbersViewController: FilterNumbersViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "FilterNumbersViewController") as! FilterNumbersViewController
        viewController.stateController = stateController
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        setupSegmentedControl()
        // When setup of segmented controls done, need to update view
        updateView()
    }

    private func setupSegmentedControl() {
        // Configure Segmented Control
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Keywords", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Numbers", at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)

        // Select First Segment
        segmentedControl.selectedSegmentIndex = 0
    }

    @objc func selectionDidChange(_ sender: UISegmentedControl) {
        updateView()
    }

    private func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: filterNumbersViewController)
            add(asChildViewController: filterWordsViewController)
        } else {
            remove(asChildViewController: filterWordsViewController)
            add(asChildViewController: filterNumbersViewController)
        }
    }

    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)

        // Add Child View as Subview
        view.addSubview(viewController.view)

        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }

    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)

        // Remove Child View From Superview
        viewController.view.removeFromSuperview()

        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
