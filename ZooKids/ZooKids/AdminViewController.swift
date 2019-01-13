//
//  AdminViewController.swift
//  ZooKids
//
//  Created by Alberto Fuentes on 17/12/18.
//  Copyright © 2018 ual. All rights reserved.
//


import UIKit

var profesor: Profesor!

class AdminViewController: UIViewController {

    override func viewDidLoad() {
        navigationController?.navigationBar.barTintColor = UIColor(red:0.56, green:0.91, blue:0.85, alpha:1.0)
        super.viewDidLoad()
        administrador = true;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func irAinicio(sender: UITapGestureRecognizer) {
         administrador = false;
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("inicio") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
