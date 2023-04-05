//
//  ViewController.swift
//  TableStory
//
//  Created by Simbolon, Meli on 3/22/23.
//

import UIKit
import MapKit

let data = [
    Item(name: "K-Bop", desc: "Korean street food is our specialty. Pair any menu item with a refreshing bubble tea.", lat: 29.884716928823025, long: -97.94175903914879, imageName: "rest1"),
    Item(name: "Kobe Steak House & Sushi", desc: "The place to go to for unlimited sushi. Gather here with family and friends for outstanding hibachi.", lat: 29.887212154928676, long: -97.92158765634821, imageName: "rest2"),
    Item(name: "Phở Tran88", desc: "San Marcos's 2021 Love Downtown Awards Winner for Outstanding New Business. Family-owned, serving quality Vietnamese cuisine.", lat: 29.883661774929447, long: -97.93977408788406, imageName: "rest3"),
    Item(name: "Thai Thai Cafe", desc: "A brand-new restaurant in town. As it's located across the street from the huge H-E-B, stop by before your grocery run.", lat: 29.886489517068178, long: -97.9247614735477, imageName: "rest4"),
    Item(name: "Xian Sushi & Noodle", desc: "This fine eatery serves hand-pulled Chinese noodles. Premium teas and signature sushi rolls are just a few of the restaurant's specialties.", lat: 29.88647192538372, long: -97.92111232380353, imageName: "rest5")
   
]

struct Item {
    var name: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}





class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    
    @IBOutlet weak var theTable: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        let item = data[indexPath.row]
        cell?.textLabel?.text = item.name
        
        let image = UIImage(named: item.imageName)
                  cell?.imageView?.image = image
                  cell?.imageView?.layer.cornerRadius = 10
                  cell?.imageView?.layer.borderWidth = 5
                  cell?.imageView?.layer.borderColor = UIColor.white.cgColor
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let item = data[indexPath.row]
      performSegue(withIdentifier: "ShowDetailSegue", sender: item)
    
  }
      
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if segue.identifier == "ShowDetailSegue" {
                  if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                      // Pass the selected item to the detail view controller
                      detailViewController.item = selectedItem
                  }
              }
          }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theTable.delegate = self
        theTable.dataSource = self
        
        //set center, zoom level and region of the map
                let coordinate = CLLocationCoordinate2D(latitude: 29.886489517068178, longitude: -97.9247614735477)
                let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                mapView.setRegion(region, animated: true)
                
             // loop through the items in the dataset and place them on the map
                 for item in data {
                    let annotation = MKPointAnnotation()
                    let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                    annotation.coordinate = eachCoordinate
                        annotation.title = item.name
                        mapView.addAnnotation(annotation)
                        }

        
        
        // Do any additional setup after loading the view.
    }


}

