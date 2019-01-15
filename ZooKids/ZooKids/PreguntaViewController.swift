//
//  PreguntaViewController.swift
//  ZooKids
//
//  Created by Aula11 on 17/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit



class PreguntaViewController: ViewController,UITextFieldDelegate {
    var preguntaActual=0;
    var respuestas=[Int]();
    
    var preguntas = [String]();
    @IBOutlet weak var yes_button: UIButton!
    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var no_button: UIButton!
    @IBOutlet weak var num_pregunta: UILabel!
    @IBOutlet weak var pregunta: UILabel!
    @IBOutlet weak var stack_botones: UIStackView!
    @IBOutlet weak var stack_tf: UIStackView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var valorSlider: UILabel!
    // @IBOutlet weak var tf: UITextField!
    @IBOutlet weak var avanzar: UIButton!
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        let selectedValue = Int16(sender.value)
        valorSlider.text = String(selectedValue)
    }
    @IBAction func recordar_imagen(sender: UITapGestureRecognizer) {
        // FALTARIA RETOCARLO PARA QUE RECUERDE
        recordar = 1;
        print("Recordar es : ")
        print(recordar)
        let storyboard = UIStoryboard(name: "Juego", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("entrada") as UIViewController
        // controller.jugarBtn.hidden = true
        self.presentViewController(controller, animated: true, completion: nil)
        
        
    }
    override func viewDidLoad() {
        
         navigationController?.navigationBar.barTintColor = UIColor(red:0.56, green:0.91, blue:0.85, alpha:1.0)
        super.viewDidLoad()
        // tf.hidden = true;
        slider.hidden = true
        valorSlider.hidden = true
        avanzar.hidden = true;
        valorSlider.text = "0"
        rellenar_preguntas()
        print("Entra en la clase")
        if app == 1{
        num_pregunta.text = String(preguntaActual+1)+"/8";
        }else{
        num_pregunta.text = String(preguntaActual+1)+"/5";
        }
        
        foto.image=UIImage(named: "Pregunta"+String(preguntaActual+1))
        print("El valor de la imagen que coge es "+String(preguntaActual+1))
        pregunta.text = preguntas[preguntaActual];
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func avanzar_tf(sender: UIButton) {
        let patas = Int16(slider.value)
        // let patas = tf.text;
        //if (patas != "" && Int(patas!) != nil){
        
            respuestas.append(Int(patas));
            
            siguientePregunta();
            // respuestas.append(patas);
        
        
        
    }
    
    
    @IBAction func yes_answer(sender: UIButton) {
        print("Se ejecuta la respuesta de yes");
        respuestas.append(1);
        if !comprobar_fin(){
            siguientePregunta();
        }else{
            rellenar_respuestas();
            navegar_test();
        }
        
    }
    
    
    @IBAction func no_answer(sender: AnyObject) {
        respuestas.append(0);
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
        if app == 1 { return respuestas.count==8; }
        else {return respuestas.count==5; }
        
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
        let pregunta3 = "¿Este animal tiene pulmones?";
        preguntas.append(pregunta3);
        let pregunta4 = "¿Este animal cuantas patas tiene?";
        preguntas.append(pregunta4);
        let pregunta5 = "¿Este animal tiene dientes?";
        preguntas.append(pregunta5);
        let pregunta6 = "¿Este animal es acuatico?";
        preguntas.append(pregunta6);
        let pregunta7 = "¿Este animal tiene aletas?";
        preguntas.append(pregunta7);
        let pregunta8 = "¿Este animal tiene esqueleto?";
        preguntas.append(pregunta8);
        
    }
    func resetear_variables_globales(){
        animales.removeAll();
        numeros.removeAll();
        estadoAnimal = (-1);
        
    }
    @IBAction func salir(sender: UIBarButtonItem) {
        resetear_variables_globales()
        let storyboard = UIStoryboard(name: "nino", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("perfilNinio") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    func rellenar_respuestas(){
        print(estadoAnimal);
        animales[estadoAnimal].respuestas_dadas = respuestas;
        
    }
    func siguientePregunta(){
        preguntaActual=preguntaActual+1;
        if app == 1{
            num_pregunta.text = String(preguntaActual+1)+"/8";
        }else{
            num_pregunta.text = String(preguntaActual+1)+"/5";
        }
        
        foto.image=UIImage(named: "Pregunta"+String(preguntaActual+1))
        pregunta.text = preguntas[preguntaActual];
        if preguntaActual+1 == 4{
            //se ocultan los botones y se añade el textField y el botón de aceptar
            yes_button.hidden = true;
            no_button.hidden = true;
            slider.hidden = false
            valorSlider.hidden = false
            //tf.hidden = false;
            avanzar.hidden = false;
        }else {
            yes_button.hidden = false;
            no_button.hidden = false;
            //tf.hidden = true;
            valorSlider.hidden = true
            slider.hidden = true
            avanzar.hidden = true;
            
        }
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
