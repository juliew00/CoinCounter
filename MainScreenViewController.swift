//
//  ViewController.swift
//  Coin Counter
//
//  Created by Julie Wu on 2019-01-08.
//  Copyright © 2019 Julie Wu. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func BackButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
