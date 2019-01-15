import UIKit

var estadoAnimal = -1;
var animales = [Animal] ();
var numeros = [Int]()
var recordar = 0 ;
class PartidaViewController: ViewController {
    
    
    func resetear_variables_globales(){
        animales.removeAll();
        numeros.removeAll();
        estadoAnimal = (-1);
        
    }
    @IBAction func salir(sender: UIBarButtonItem) {
        if(recordar != 2){
            
            resetear_variables_globales();
            let storyboard = UIStoryboard(name: "nino", bundle: nil)
            let controller = storyboard.instantiateViewControllerWithIdentifier("perfilNinio") as UIViewController
            
            self.presentViewController(controller, animated: true, completion: nil)
        }else{
            
            recordar = 0 ;
            //se tiene que cerrar esta ventana
            if presentingViewController is UINavigationController{
                dismissViewControllerAnimated(true, completion: nil)
            } else {
                navigationController!.popViewControllerAnimated(true)
            }
            
        }
        
    }
    
    @IBOutlet weak var jugarBtn: UIButton!
    @IBOutlet weak var animalActual: UILabel!
    @IBOutlet weak var fotoAnimal: UIImageView!
    @IBOutlet weak var salir_btn: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        navigationController?.navigationBar.barTintColor = UIColor(red:0.56, green:0.91, blue:0.85, alpha:1.0)
        super.viewDidLoad()
        
        if recordar == 1 {
            
            salir_btn.title = "Volver al juego"
            jugarBtn.hidden = true;
            recordar = 2
        }
        
        if app == 1{
            
            if estadoAnimal==(-1){
                escoger_animales_aleatoriamente_app1();
                estadoAnimal = 0;
                animalActual.text = "Animal "+String(estadoAnimal+1);
            }else{
                animalActual.text = "Animal "+String(estadoAnimal+1);
            }
        }else{
            if estadoAnimal==(-1){
                escoger_animales_aleatoriamente();
                estadoAnimal = 0;
            }else{
                animalActual.text = "Animal "+String(estadoAnimal+1)+"/5";
            }
        }
        
        
        //print("Se ejecuta ek accesi a ka varuavke de numeros")
        //print(String(numeros[estadoAnimal]));
        print("Animal"+String(numeros[estadoAnimal]))
        fotoAnimal.image=UIImage(named: "Animal"+String(numeros[estadoAnimal]))
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func escoger_animales_aleatoriamente(){
        //cargar animales diferentes de los xassets
        
        
        var contador = 0
        
        while contador<5 {
            let numAleatorio=Int(arc4random_uniform(20))+1
            if !numeros.contains(numAleatorio) {
                numeros.append(numAleatorio);
                let an = Animal();
                an.imagen = numAleatorio;
                let array_animal = animales_tipo[numAleatorio-1]
                
                an.respuesta_verdadera_establecida = array_animal![1]
                an.nombre = array_animal![0]
                animales.append(an)
                
                contador=contador+1;
            }
        }
    }
    
    func escoger_animales_aleatoriamente_app1(){
        //cargar animales diferentes de los xassets
        
        
        var contador = 0
        var n = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]
        while contador<20 {
            //entre 0 y 19, indices min y maximo de n
            let numAleatorio=Int(arc4random_uniform(UInt32(n.count)))
            
                numeros.append(n[numAleatorio]);
                let an = Animal();
                an.imagen = numAleatorio;
                let array_animal = animales_tipo[numAleatorio]
                
                an.respuesta_verdadera_establecida = array_animal![1]
                an.nombre = array_animal![0]
                animales.append(an)
                n.removeAtIndex(numAleatorio)
                contador=contador+1;
            
        }
        
        print("Hola")
    }
    
    @IBAction func jugar(sender: UIButton) {
        //dismissViewControllerAnimated(true, completion: nil)
        let storyboard = UIStoryboard(name: "Juego", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("preguntaN") as UIViewController
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