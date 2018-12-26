//
//  BarrasAciertos.swift
//  ZooKids
//
//  Created by Jefferson on 26/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit

class BarrasAciertos: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    // MARK: atributos
    var botones = [UIButton]()
    let tamanio = CGRect(x: 0, y: 0, width: 96.8, height: 30)
    var gradoAfinidad = 0 {
        didSet{
          //  actualizaEstrellas()
        }
    }
    
    // MARK: inicialización
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        for i in 0..<5{
            let boton = UIButton(frame: tamanio)
            
            if( i<2){
                boton.setImage(UIImage(named:"verde"), forState: .Normal)
            }else{
                boton.setImage(UIImage(named:"rosa"), forState: .Normal)
            }
            
            boton.adjustsImageWhenHighlighted = false
           
            boton.tag = i
            botones += [boton]
            addSubview(boton)
        }
        
    }
    
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 96.8, height: 30)
    }
    
    
    //método para mostrar las vistas, por defecto lo hace de forma apilada.
    override func layoutSubviews() {
        for (i, boton) in botones.enumerate() {
            boton.frame.origin.x = CGFloat(i * (96 + 0))
        }
     
    }
    
 


}
