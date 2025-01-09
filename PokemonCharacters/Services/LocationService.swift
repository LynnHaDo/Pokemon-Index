//
//  LocationService.swift
//  PokemonCharacters
//
//  Created by Do Linh on 1/8/25.
//

import MapKit

let FamousLocations = [
    "Madison Square Park, NY, USA": [40.742165   , -73.988121],
    "Twin Peaks, San Francisco, CA, USA": [37.752884    , -122.447556],
    "Boston National Historical Park, MA, USA": [42.373547    ,-71.056183],
    "Boston Common, MA, USA": [42.355083    , -71.065880],
    "US Capitol Grounds, Washington, DC, USA": [38.889816   , -77.008339],
    "Riverside Park, NY, USA": [40.809551    , -73.967499],
    "City Hall Park, NY, USA": [    40.712448    , -74.006653],
    "Disney Springs, FL, USA": [    28.370970    , -81.519249],
    "Bryant Park, New York, USA": [    40.753742 ,   -73.983559],
    "Golden Gate Park, San Francisco, CA, USA": [    37.769722   , -122.476944]
]

struct LocationService {
    
    static func randomBetween(_ firstNum: CGFloat, _ secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }

    static func getRandomPosition(_ withName: String = "") -> (String, CLLocationCoordinate2D) {
        let randomInt = withName.count % FamousLocations.count
        
        let key = FamousLocations.index(FamousLocations.startIndex, offsetBy: randomInt)
        let locationName = FamousLocations.keys[key]
        
        return (locationName, CLLocationCoordinate2D(latitude: FamousLocations[locationName]![0],
                                      longitude: FamousLocations[locationName]![1]))
    }
    
    static func locationToString(loc: CLLocationCoordinate2D) -> String {
        let lat: NSNumber = NSNumber(value: loc.latitude)
        let lg: NSNumber = NSNumber(value: loc.longitude)
        
        return "latitude: \(lat); longitude: \(lg)"
    }
}
