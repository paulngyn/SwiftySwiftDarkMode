//
//  DetailViewController.swift
//  Dark Light Mode
//
//  Created by Paul Nguyen on 3/12/19.
//  Copyright © 2019 Paul Ngyn. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    var anotherLabel = UILabel()

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = "Timestamped: "+detail.timestamp!.euroForm_En_US
            }
            view.addSubview(anotherLabel)
            anotherLabel.translatesAutoresizingMaskIntoConstraints = false
            anotherLabel.topAnchor.constraint(equalTo: detailDescriptionLabel.bottomAnchor).isActive = true
            anotherLabel.heightAnchor.constraint(equalTo: detailDescriptionLabel.heightAnchor).isActive = true
            anotherLabel.centerXAnchor.constraint(equalTo: detailDescriptionLabel.centerXAnchor).isActive = true
            anotherLabel.text = "Speed: \(detail.swiftyspeed) mph"
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        setUpMode()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    var detailItem: Event? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

extension DetailViewController: ModeType {
    func applyMode(_ mode: AppMode) {
        view.backgroundColor = mode.backgroundColor
        detailDescriptionLabel.textColor = mode.textColor
        detailDescriptionLabel.backgroundColor = .clear
        anotherLabel.textColor = mode.textColor
        anotherLabel.backgroundColor = .clear
        
        print("applying detail mode -----\n" +
              "bg-c: \(mode.backgroundColor.description)\n:" +
              "txt-c: \(mode.textColor.description)")
    }
}

