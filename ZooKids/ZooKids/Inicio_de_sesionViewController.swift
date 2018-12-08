//
//  Inicio_de_sesionViewController.swift
//  ZooKids
//
//  Created by Jefferson on 6/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit

class Inicio_de_sesionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func btnEntrar(sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Admin", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("admin") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func entrar_como_admin(sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Admin", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("admin") as UIViewController
        
        //esta primera es para cuando se quiere añadir un view controller de modo modal, es decir, que no tenga
        //la opcion predeterminada de ir para atras
        //self.presentViewController(controller, animated: true, completion: nil)
        
        //con esta forma se añade el view controller con el boton de atras.
        self.navigationController?.pushViewController(controller, animated: true)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
