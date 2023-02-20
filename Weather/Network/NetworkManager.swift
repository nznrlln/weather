//
//  NetworkManager.swift
//  Weather
//
//  Created by Нияз Нуруллин on 09.01.2023.
//

import Foundation
import Alamofire

class NetworkManager {
    static let defaultManager = NetworkManager()
    
    private let geoKey: String = "ff7239e6-7563-42d0-9446-93515a1bd757"
    private let weatherKey: String = "31cd180094msheb5e6fc204d8e5ap125d5ejsn6610bfc143e8" // первый аккаунт
//    private let weatherKey: String = "2d130e4cdemsh73765ff29163795p1b1972jsnd1bb44fd8915" // второй аккаунт



    func geoRequest(_ locationName: String, complitionHandler: @escaping (GeoModel) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "geocode-maps.yandex.ru"
        urlComponents.path = "/1.x"
        urlComponents.queryItems = [
            URLQueryItem(name: "apikey", value: geoKey),
            URLQueryItem(name: "geocode", value: locationName),
            URLQueryItem(name: "kind", value: "locality"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "results", value: "1"),
        ]
        guard let url = urlComponents.url else { preconditionFailure() }

        let urlRequest = URLRequest(url: url)
        AF.request(urlRequest).responseJSON(queue: .global(qos: .background)) { response in
            if let data = response.data {
                do {
                    let geoModel = try JSONDecoder().decode(GeoModel.self, from: data)
                    complitionHandler(geoModel)
                } catch let error {
                    debugPrint("Error discription: \(error)")
                }
            }
        }
    }

    func geoRequest(_ lon: String, _ lat: String, complitionHandler: @escaping (GeoModel) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "geocode-maps.yandex.ru"
        urlComponents.path = "/1.x"
        urlComponents.queryItems = [
            URLQueryItem(name: "apikey", value: geoKey),
            URLQueryItem(name: "geocode", value: "\(lon),\(lat)"),
            URLQueryItem(name: "kind", value: "locality"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "results", value: "1"),
        ]
        guard let url = urlComponents.url else { preconditionFailure() }

        let urlRequest = URLRequest(url: url)
        AF.request(urlRequest).responseJSON(queue: .global(qos: .background)) { response in
            if let data = response.data {
                do {
                    let geoModel = try JSONDecoder().decode(GeoModel.self, from: data)
                    complitionHandler(geoModel)
                } catch let error {
                    debugPrint("Error discription: \(error)")
                }
            }
        }
    }

    func currentWeatherRequest(_ lon: String, _ lat: String, complitionHandler: @escaping (CurrentWeatherModel) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "weatherbit-v1-mashape.p.rapidapi.com"
        urlComponents.path = "/current"
        urlComponents.queryItems = [
            URLQueryItem(name: "lon", value: lon),
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "ru"),
        ]
        guard let url = urlComponents.url else { preconditionFailure() }

        let headers = [
            "X-RapidAPI-Key": weatherKey,
            "X-RapidAPI-Host": "weatherbit-v1-mashape.p.rapidapi.com"
        ]
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers

        AF.request(urlRequest).responseJSON(queue: .global(qos: .background)) { response in
            if let data = response.data {
                do {
                    let currentWeatherModel = try JSONDecoder().decode(CurrentWeatherModel.self, from: data)
                    complitionHandler(currentWeatherModel)
                } catch let error {
                    debugPrint("Error discription: \(error)")
                }            }
        }
    }

    func forecast5dBy3hRequest(_ lon: String, _ lat: String, complitionHandler: @escaping (Forecast5dBy3hModel) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "weatherbit-v1-mashape.p.rapidapi.com"
        urlComponents.path = "/forecast/3hourly"
        urlComponents.queryItems = [
            URLQueryItem(name: "lon", value: lon),
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "ru"),
        ]
        guard let url = urlComponents.url else { preconditionFailure() }

        let headers = [
            "X-RapidAPI-Key": weatherKey,
            "X-RapidAPI-Host": "weatherbit-v1-mashape.p.rapidapi.com"
        ]
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers

        AF.request(urlRequest).responseJSON(queue: .global(qos: .background)) { response in
            if let data = response.data {
                do {
                    let forecast = try JSONDecoder().decode(Forecast5dBy3hModel.self, from: data)
                    complitionHandler(forecast)
                } catch let error {
                    debugPrint("Error discription: \(error)")
                }            }
        }
    }

    func forecast16dRequest(_ lon: String, _ lat: String, complitionHandler: @escaping (Forecast16dModel) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "weatherbit-v1-mashape.p.rapidapi.com"
        urlComponents.path = "/forecast/daily"
        urlComponents.queryItems = [
            URLQueryItem(name: "lon", value: lon),
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "ru"),
        ]
        guard let url = urlComponents.url else { preconditionFailure() }

        let headers = [
            "X-RapidAPI-Key": weatherKey,
            "X-RapidAPI-Host": "weatherbit-v1-mashape.p.rapidapi.com"
        ]
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers

        AF.request(urlRequest).responseJSON(queue: .global(qos: .background)) { response in
            if let data = response.data {
                do {
                    let forecast = try JSONDecoder().decode(Forecast16dModel.self, from: data)
                    complitionHandler(forecast)
                } catch let error {
                    debugPrint("Error discription: \(error)")
                }            }
        }
    }

}

