//
//  ViewController.swift
//  Sample
//
//  Created by Théophane Rupin on 3/27/18.
//  Copyright © 2018 Scribd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let dependencies: ViewControllerDependencyResolver
    
    // beaverdi: appDelegate <- UIApplicationDelegate

    init(injecting dependencies: ViewControllerDependencyResolver) {
        self.dependencies = dependencies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}
