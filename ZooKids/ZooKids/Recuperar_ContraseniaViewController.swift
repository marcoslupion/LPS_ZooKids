//
//  Recuperar_contraseniaViewController.swift
//  ZooKids
//
//  Created by Aula11 on 10/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit

class Recuperar_contraseniaViewController: UIViewController {

    @IBOutlet weak var introducirPassTxtField: UITextField!
    
    @IBAction func salir(sender: UIBarButtonItem) {
        if presentingViewController is UINavigationController{
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    @IBAction func enviar(sender: UIButton) {
        
        if(introducirPassTxtField.text==nil || introducirPassTxtField.text=="")
        {
            //AlertController campos vacíos
            let alertController = UIAlertController(title: "¡Cuidado!", message: "Escirbe el e-mail", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            return;
        }
        
        //AlertController envío email
        let alertController = UIAlertController(title: "e-mail enviado", message: "Si el e-mail existe serás notificado", preferredStyle: .Alert)
        let confirmAction = UIAlertAction(title: "Confirmar", style: UIAlertActionStyle.Default, handler: ({
            (_) in
            self.cerrarAlertController()
            
        }))
        alertController.addAction(confirmAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func cerrarAlertController(){
        
        
        if presentingViewController is UINavigationController{
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red:0.56, green:0.91, blue:0.85, alpha:1.0)
        
        // Do any additional setup after loading the view.
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
