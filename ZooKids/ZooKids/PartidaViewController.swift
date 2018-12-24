import UIKit

var estadoAnimal = -1;
var animales = [Animal] ();
var numeros = [Int]()

class PartidaViewController: ViewController {
    
    
    @IBOutlet weak var jugarBtn: UIButton!
    @IBOutlet weak var animalActual: UILabel!
    @IBOutlet weak var fotoAnimal: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entra en la clase")
        if estadoAnimal==(-1){
            escoger_animales_aleatoriamente();
            estadoAnimal = 0;
        }else{
            animalActual.text = "Animal "+String(estadoAnimal+1)+"/5";
        }
        
        print("Se ejecuta ek accesi a ka varuavke de numeros")
        print(String(numeros[estadoAnimal]));
        fotoAnimal.image=UIImage(named: "Animal"+String(numeros[estadoAnimal]))
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func escoger_animales_aleatoriamente(){
        //cargar animales diferentes de los xassets
        print("Se ejecu8ta el metodo")
        
        
        
        var contador = 0
        
        while contador<5 {
            let numAleatorio=Int(arc4random_uniform(5))+1
            if !numeros.contains(numAleatorio) {
                numeros.append(numAleatorio);
                let an = Animal();
                an.imagen = numAleatorio;
                animales.append(an)
                print(numAleatorio)
                contador=contador+1;
            }
        }
        
        
        
        
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