import Foundation
import SwiftUICore

enum WeatherDay {
    case morning, afternoon, evening, night, unknown
}

extension WeatherDay {
    var name: String {
        switch self {
        case .morning:
            return "Good Morning"
        case .afternoon:
            return "Good Afternoon"
        case .evening:
            return "Good Evening"
        case .night:
            return "Good Night"
        default:
            return "Unknown"
        }
    }
}

struct WeatherModel: Codable {
	let latitude : Double?
	let longitude : Double?
	let generationtime_ms : Double?
	let utc_offset_seconds : Int?
	let timezone : String?
	let timezone_abbreviation : String?
	let elevation : Double?
	let current_units : CurrentUnitsModel?
	let current : CurrentModel?

	enum CodingKeys: String, CodingKey {

		case latitude = "latitude"
		case longitude = "longitude"
		case generationtime_ms = "generationtime_ms"
		case utc_offset_seconds = "utc_offset_seconds"
		case timezone = "timezone"
		case timezone_abbreviation = "timezone_abbreviation"
		case elevation = "elevation"
		case current_units = "current_units"
		case current = "current"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
		generationtime_ms = try values.decodeIfPresent(Double.self, forKey: .generationtime_ms)
		utc_offset_seconds = try values.decodeIfPresent(Int.self, forKey: .utc_offset_seconds)
		timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
		timezone_abbreviation = try values.decodeIfPresent(String.self, forKey: .timezone_abbreviation)
		elevation = try values.decodeIfPresent(Double.self, forKey: .elevation)
		current_units = try values.decodeIfPresent(CurrentUnitsModel.self, forKey: .current_units)
		current = try values.decodeIfPresent(CurrentModel.self, forKey: .current)
	}
    
    var weatherDay: WeatherDay {
        guard let time = self.current?.time else {
            return .unknown
        }
        
        let timestamp = Date(timeIntervalSince1970: TimeInterval(time))
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: timestamp)
        
        let timeOfDay: WeatherDay
        switch hour {
        case 6..<12:
            timeOfDay = .morning
        case 12..<17:
            timeOfDay = .afternoon
        case 17..<21:
            timeOfDay = .evening
        default:
            timeOfDay = .night
        }
        return timeOfDay
    }
    
}

struct CurrentModel : Codable {
    let time : Int?
    let interval : Int?
    let temperature_2m : Double?
    let relative_humidity_2m : Int?
    let rain : Double?
    let snowfall : Double?
    let wind_speed_10m : Double?
    let wind_direction_10m : Int?

    enum CodingKeys: String, CodingKey {

        case time = "time"
        case interval = "interval"
        case temperature_2m = "temperature_2m"
        case relative_humidity_2m = "relative_humidity_2m"
        case rain = "rain"
        case snowfall = "snowfall"
        case wind_speed_10m = "wind_speed_10m"
        case wind_direction_10m = "wind_direction_10m"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        time = try values.decodeIfPresent(Int.self, forKey: .time)
        interval = try values.decodeIfPresent(Int.self, forKey: .interval)
        temperature_2m = try values.decodeIfPresent(Double.self, forKey: .temperature_2m)
        relative_humidity_2m = try values.decodeIfPresent(Int.self, forKey: .relative_humidity_2m)
        rain = try values.decodeIfPresent(Double.self, forKey: .rain)
        snowfall = try values.decodeIfPresent(Double.self, forKey: .snowfall)
        wind_speed_10m = try values.decodeIfPresent(Double.self, forKey: .wind_speed_10m)
        wind_direction_10m = try values.decodeIfPresent(Int.self, forKey: .wind_direction_10m)
    }

}

struct CurrentUnitsModel : Codable {
    let time : String?
    let interval : String?
    let temperature_2m : String?
    let relative_humidity_2m : String?
    let rain : String?
    let snowfall : String?
    let wind_speed_10m : String?
    let wind_direction_10m : String?

    enum CodingKeys: String, CodingKey {

        case time = "time"
        case interval = "interval"
        case temperature_2m = "temperature_2m"
        case relative_humidity_2m = "relative_humidity_2m"
        case rain = "rain"
        case snowfall = "snowfall"
        case wind_speed_10m = "wind_speed_10m"
        case wind_direction_10m = "wind_direction_10m"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        interval = try values.decodeIfPresent(String.self, forKey: .interval)
        temperature_2m = try values.decodeIfPresent(String.self, forKey: .temperature_2m)
        relative_humidity_2m = try values.decodeIfPresent(String.self, forKey: .relative_humidity_2m)
        rain = try values.decodeIfPresent(String.self, forKey: .rain)
        snowfall = try values.decodeIfPresent(String.self, forKey: .snowfall)
        wind_speed_10m = try values.decodeIfPresent(String.self, forKey: .wind_speed_10m)
        wind_direction_10m = try values.decodeIfPresent(String.self, forKey: .wind_direction_10m)
    }

}
