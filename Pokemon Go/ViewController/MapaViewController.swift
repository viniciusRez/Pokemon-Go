//
//  ViewController.swift
//  TrabalhandoMapas
//
//  Created by Vinicius Rezende on 29/12/22.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
   
    var locationManeger = CLLocationManager()
    var coreDataPokemon: CoreDataPokemon!
    var viewModel: LocationViewModel!
    var pokemons: [Pokemon] = []
    var latitude:CLLocationDegrees?
    var longitude:CLLocationDegrees?
    override func viewDidLoad() {
        super.viewDidLoad()
        mapa.delegate = self
     
        self.locationManeger.delegate = self
        self.viewModel = LocationViewModel()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
            if let coordenadas = self.locationManeger.location?.coordinate{
                let anotacao = self.viewModel.showPokemons(coordinate: coordenadas)
                self.mapa.addAnnotation(anotacao)
            }
        }
    }

@IBOutlet weak var mapa: MKMapView!

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let anotacaoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        if annotation is MKUserLocation {
            anotacaoView.image = UIImage(named: "player.png")
        }else{
            let nextPokemonWillApper = (annotation as! ModelPokemonLocation)
            if let imageName = nextPokemonWillApper.pokemon.nomeimagem{
                anotacaoView.image = UIImage(named: imageName)
            }
        }
        
        var frame = anotacaoView.frame
        frame.size.height = 40
        frame.size.width = 40
        
        anotacaoView.frame = frame
        
        return anotacaoView
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let anotacao = view.annotation
        let pokemon = (view.annotation as! ModelPokemonLocation).pokemon
        mapView.deselectAnnotation( anotacao, animated: true)
        
        if anotacao is MKUserLocation{
            return
        }
        
        if let coordAnotacao = anotacao?.coordinate{
            
            let regiao = MKCoordinateRegion(center: coordAnotacao, latitudinalMeters: 200, longitudinalMeters: 200 )
            
            mapa.setRegion(regiao, animated: true)
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            
            if let coord = self.locationManeger.location?.coordinate {
                var alertController:UIAlertController!
                if self.mapa.visibleMapRect.contains(MKMapPoint.init(coord)) {
                    
                    self.mapa.removeAnnotation(anotacao!)
                    alertController = self.viewModel.capturePokemon(pokemon: pokemon, captured: true)
                }else{
                    alertController = self.viewModel.capturePokemon(pokemon: pokemon, captured: false)
                }
                self.center()
                self.present(alertController, animated: true, completion: nil)
                
            }
        }
    }
        


    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status:CLAuthorizationStatus) {
        if status == .denied {
            let alertController = UIAlertController(title: "Permisão de localização",
                                                    message:"Necessario permissão para acesso à sua localização!! por favor habilite" ,
                                                    preferredStyle: .alert)
            let actionConfig = UIAlertAction(title: "Abrir configurações", style: .default, handler: { (alertConfig) in
                if let config = NSURL(string: UIApplication.openSettingsURLString){

                    UIApplication.shared.open( config as URL )
                }

            })
            let actionCancel = UIAlertAction( title: "Cancelar", style: .default, handler: nil )
            alertController.addAction( actionConfig )
            alertController.addAction( actionCancel )

            present(alertController, animated: true)
        }
        locationManeger.desiredAccuracy = kCLLocationAccuracyBest
        locationManeger.requestWhenInUseAuthorization()
        locationManeger.startUpdatingLocation()




    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations.last!
        self.latitude = userLocation.coordinate.latitude
        self.longitude = userLocation.coordinate.longitude
        self.center()
    }
    func center(){
        mapa.setRegion(self.viewModel!.getRegiao(latitude: self.latitude!, longitude: self.longitude!), animated: true)

    }
    @IBAction func btnCentralized(_ sender: Any) {
        self.center()
    }
}
