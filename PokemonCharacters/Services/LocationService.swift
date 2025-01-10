//
//  LocationService.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/8/25.
//

import MapKit
import Foundation
import PcgRandom // For random number generator

let locationService: LocationService = LocationService()
var pcg = Pcg64Random(seed: 10)

class LocationService {
    var massAndNyData: [Location] = []
    
    let defaultLocation: (String, CLLocationCoordinate2D) = (
        "South Hadley, MA, USA",
        CLLocationCoordinate2D(latitude: 42.259552, longitude: -72.581291)
    )
    
    let earthRad = Double(6378)
    
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
                if state == "MA" || state == "NY" {
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
            print("Error reading location file")
            return
        }
    }
    
    static func randomBetween(_ firstNum: CGFloat, _ secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    func getPositionOffsetBy(originalLat: Double, originalLong: Double, xOffset: Double, yOffset: Double) -> CLLocationCoordinate2D {
        let newLat = originalLat + Double(yOffset/earthRad) * (180/Double.pi)
        let newLong = originalLong + Double(xOffset / earthRad) * (180 / Double.pi) / cos(originalLat * Double.pi / 180)
        return CLLocationCoordinate2D(latitude: newLat,
                                      longitude: newLong)
    }

    func getRandomPosition(_ withName: String = "PokeIndex") -> (String, CLLocationCoordinate2D) {
        let locationId = massAndNyData.count / withName.count
        
        let randomXOffset = Double.random(in: -1...1, using: &pcg)
        let randomYOffset = Double.random(in: -1...1, using: &pcg)
        
        let location: Location = massAndNyData[locationId]
        let locationName = "\(location.cityAscii.capitalizeFirst()), \(location.countyName.capitalizeFirst()), \(location.stateId.uppercased())"
        
        return (locationName, getPositionOffsetBy(originalLat: location.lat,
                                                  originalLong: location.lng,
                                                  xOffset: randomXOffset,
                                                  yOffset: randomYOffset))
    }
    
    static func locationToString(loc: CLLocationCoordinate2D) -> String {
        let lat: NSNumber = NSNumber(value: loc.latitude)
        let lg: NSNumber = NSNumber(value: loc.longitude)
        
        return "latitude: \(lat); longitude: \(lg)"
    }
}
