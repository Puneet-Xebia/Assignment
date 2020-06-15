//  Smart Dubai
//
//  Created by Puneet kumar  on 15/06/20.
//  Copyright © 2020 Puneet Kumar. All rights reserved.
//

import XCTest
@testable import SmartDubai

class weatherTest: XCTestCase {

    var data: Data?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        let json = """
            {
                "name": "Gurgaon",
                "weather": [
                    {
                        "description": "mist",
                    }
                ],
                "main": {
                    "temp_min": 288.15,
                    "temp_max": 292.04,
                    "humidity": 71
                },
                "wind": {
                    "speed": 3.6,
                }
            }
        """
        data = json.data(using: .utf8)
    }
    
    func testWeatherModel() {
        
        do {
            let weather = try JSONDecoder().decode(Weather.self, from: data!)
            XCTAssertNotNil(weather)
            XCTAssertEqual(weather.wind.windSpeed, 3.6)
        } catch {
            print("Failed to decode JSON")
        }
    }

}
