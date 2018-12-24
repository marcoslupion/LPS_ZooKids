//
//  PreguntaViewController.swift
//  ZooKids
//
//  Created by Aula11 on 17/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit

class PreguntaViewController: ViewController {
    var preguntaActual=0;
    var respuestas=[Bool]();
    var preguntas = [String]();
    @IBOutlet weak var yes_button: UIButton!
    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var no_button: UIButton!
    @IBOutlet weak var num_pregunta: UILabel!
    @IBOutlet weak var pregunta: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        rellenar_preguntas()
        print("Entra en la clase")
        num_pregunta.text = String(preguntaActual+1)+"/5";
        foto.image=UIImage(named: "Pregunta"+String(preguntaActual+1))
        print("El valor de la imagen que coge es "+String(preguntaActual+1))
        pregunta.text = preguntas[preguntaActual];
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func yes_answer(sender: UIButton) {
        print("Se ejecuta la respuesta de yes");
        respuestas.append(true);
        if !comprobar_fin(){
            siguientePregunta();
        }else{
            rellenar_respuestas();
            navegar_test();
        }
        
    }
    
    
    @IBAction func no_answer(sender: AnyObject) {
        respuestas.append(false);
        if !comprobar_fin(){
            siguientePregunta();
        }else{
            rellenar_respuestas();
            navegar_test();
        }
        
    }
    
    func comprobar_fin() -> Bool {
        print("ENTRA EN COMPROBAR FIN");
        print(String(respuestas.count));
        
        return respuestas.count==5;
    }
    
    @IBAction func cerrar_juego(sender: UIButton) {
        if presentingViewController is UINavigationController{
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
        
        let storyboard = UIStoryboard(name: "Juego", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("resultados") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
        
        
    }
    func rellenar_preguntas(){
        let pregunta1 = "¿Este animal bebe leche?";
        preguntas.append(pregunta1);
        let pregunta2 = "¿Este animal tiene alas?";
        preguntas.append(pregunta2);
        let pregunta3 = "¿Este animal respira?";
        preguntas.append(pregunta3);
        let pregunta4 = "¿Este animal tiene patas?";
        preguntas.append(pregunta4);
        let pregunta5 = "¿Este animal tiene dientes?";
        preguntas.append(pregunta5);
        
        
    }
    func rellenar_respuestas(){
        print(estadoAnimal);
        animales[estadoAnimal].respuestas_dadas = respuestas;
        
    }
    func siguientePregunta(){
        preguntaActual=preguntaActual+1;
        num_pregunta.text = String(preguntaActual+1)+"/5";
        foto.image=UIImage(named: "Pregunta"+String(preguntaActual+1))
        pregunta.text = preguntas[preguntaActual];
        
    }
    func navegar_test(){
        preguntaActual = 0;
        respuestas.removeAll();
        /*
         if presentingViewController is UINavigationController{
         dismissViewControllerAnimated(true, completion: nil)
         } else {
         navigationController!.popViewControllerAnimated(true)
         }
         */
        let storyboard = UIStoryboard(name: "Juego", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("testN") as UIViewController
        
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
