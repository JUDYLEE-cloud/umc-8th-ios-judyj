import Foundation

struct Sample {
    static let route = """
    {
      "code": "Ok",
      "routes": [{
        "geometry": {
          "coordinates": [
            [126.978416,37.566472],
            [127.027606,37.497887]
          ],
          "type": "LineString"
        },
        "legs": [{
          "steps": [],
          "summary": "",
          "weight": 6765.3,
          "duration": 6765.3,
          "distance": 9379.4
        }],
        "weight_name": "duration",
        "weight": 6765.3,
        "duration": 6765.3,
        "distance": 9379.4
      }],
      "waypoints": [
        {
          "hint": "hint1",
          "distance": 14.2,
          "name": "",
          "location": [126.978416,37.566472]
        },
        {
          "hint": "hint2",
          "distance": 1.5,
          "name": "서초대로",
          "location": [127.027606,37.497887]
        }
      ]
    }
    """
}
