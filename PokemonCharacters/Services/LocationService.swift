//
//  LocationService.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/8/25.
//

import MapKit
import Foundation

let locationService: LocationService = LocationService()

class LocationService {
    var massAndNyData: [Location] = []
    
    let defaultLocation: (String, CLLocationCoordinate2D) = (
        "South Hadley, MA, USA",
        CLLocationCoordinate2D(latitude: 42.259552, longitude: -72.581291)
    )
    
    init() {
        guard let filePath = Bundle.main.path(forResource: "uscities", ofType: "csv") else {
            return
        }
        
        var dataStr = ""
        do {
            dataStr = try String(contentsOfFile: filePath, encoding: .utf8)
            var rows = dataStr.components(separatedBy: "\n")
            rows.removeFirst()
            for row in rows {
                let columns = row.components(separatedBy: ",")
                guard columns.count >= 8 else { continue }
                let city: String = columns[1].replacingOccurrences(of: "\"", with: "")
                let state: String = columns[2].replacingOccurrences(of: "\"", with: "")
                let county: String = columns[5].replacingOccurrences(of: "\"", with: "")
                if state == "MA" {
                    let lat = Double(columns[6].replacingOccurrences(of: "\"", with: ""))
                    let lng = Double(columns[7].replacingOccurrences(of: "\"", with: ""))
                    var location: Location {
                        if let lat, let lng {
                            return Location(cityAscii: city, stateId: state, countyName: county, lat: lat, lng: lng)
                        }
                        else {
                            return Location(cityAscii: "South Hadley", stateId: "MA", countyName: "Hampshire", lat: 42.259552, lng: -72.581291)
                        }
                    }
                    massAndNyData.append(location)
                }
            }
        }
        catch {
            print(error)
            return
        }
    }
    
    static func randomBetween(_ firstNum: CGFloat, _ secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }

    func getRandomPosition(_ withName: String = "PokeIndex") -> (String, CLLocationCoordinate2D) {
        let randomInt = massAndNyData.count / withName.count
        
        let location: Location = massAndNyData[randomInt]
        let locationName = "\(location.cityAscii.capitalizeFirst()), \(location.countyName.capitalizeFirst()), \(location.stateId.uppercased())"
        
        return (locationName, CLLocationCoordinate2D(latitude: location.lat,
                                                     longitude: location.lng))
    }
    
    static func locationToString(loc: CLLocationCoordinate2D) -> String {
        let lat: NSNumber = NSNumber(value: loc.latitude)
        let lg: NSNumber = NSNumber(value: loc.longitude)
        
        return "latitude: \(lat); longitude: \(lg)"
    }
}
