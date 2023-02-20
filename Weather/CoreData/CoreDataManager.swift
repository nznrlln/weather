//
//  CoreDataManager.swift
//  Weather
//
//  Created by Нияз Нуруллин on 06.10.2022.
//

import CoreData

class CoreDataManager {

    static let defaultManager = CoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Weather")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        container.viewContext.automaticallyMergesChangesFromParent = true

        return container
    }()

    private init() {}

    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func addCityWithWeatherData(geoModel: GeoModel) {
        addCity(geoModel: geoModel) { newCity in
            guard let lon = newCity.longitude else { return }
            guard let lat = newCity.latitude else { return }

            let group = DispatchGroup()

            DispatchQueue.global().sync {
                group.enter()
                NetworkManager.defaultManager.currentWeatherRequest(lon, lat) { [weak self] weather in
                    self?.updateCurrentWeather(weather: weather, to: newCity) {
                        group.leave()
                    }
                }
                group.wait()

                group.enter()
                NetworkManager.defaultManager.forecast5dBy3hRequest(lon, lat) { [weak self] forecast in
                    self?.updateForecast24h(weather: forecast, to: newCity) {
                        group.leave()
                    }
                }
                group.wait()

                group.enter()
                NetworkManager.defaultManager.forecast16dRequest(lon, lat) { [weak self] forecast in
                    self?.updateForecast16d(weather: forecast, to: newCity) {
                        group.leave()
                    }
                }
                group.wait()
                debugPrint("🌼🌼")
            }
        }
    }

    func addCity(geoModel: GeoModel, completionHandler: @escaping (CityCoreData) -> Void) {
        guard let cityLocation = LocationManager.defaultManager.getCoordinates(geoModel) else { return }
        guard let cityName = LocationManager.defaultManager.getName(geoModel) else { return }
        let exist = cityCheck(name: cityName.city)
        if !exist {
            persistentContainer.performBackgroundTask { taskContext in
                let newCity = CityCoreData(context: taskContext)
                newCity.city = cityName.city
                newCity.country = cityName.country
                newCity.latitude = cityLocation.latitude
                newCity.longitude = cityLocation.longitude
                do {
                    try taskContext.save()
                    completionHandler(newCity)
                    debugPrint("City added")
                    debugPrint(newCity)
                } catch {
                    debugPrint("🎲 CoreDataError: \(error)")
                }
            }
        }
    }

    func updateCurrentWeather(weather model: CurrentWeatherModel, to city: CityCoreData, completion: @escaping () -> ()) {
        persistentContainer.performBackgroundTask { taskContext in
            let objectId = city.objectID
            let copyCity = taskContext.object(with: objectId) as! CityCoreData
            if let existingWeather = copyCity.currentWeather {
                existingWeather.sunriseTime = model.data[0].sunriseTime
                existingWeather.sunsetTime = model.data[0].sunsetTime
                existingWeather.temperature = Int16(model.data[0].temperature)
                existingWeather.weatherCode = Int16(model.data[0].weather.code)
                existingWeather.weatherDescription = model.data[0].weather.description
                existingWeather.uvIndex = Int16(model.data[0].uvIndex)
                existingWeather.windVelocity = Int16(model.data[0].windVelocity)
                existingWeather.airQualityIndex = Int16(model.data[0].airQualityIndex)
                existingWeather.airQualityIndexScore = CoreDataHelper.defaultHelper.getAQIScore(from: model.data[0].airQualityIndex)
                existingWeather.airQualityIndexDescription = CoreDataHelper.defaultHelper.getAQIDescription(from: model.data[0].airQualityIndex)
                existingWeather.humidityLevel = Int16(model.data[0].humidityLevel)
            } else {
                let newCurrentWeather = CurrentWeatherCoreData(context: taskContext)
                newCurrentWeather.sunriseTime = model.data[0].sunriseTime
                newCurrentWeather.sunsetTime = model.data[0].sunsetTime
                newCurrentWeather.temperature = Int16(model.data[0].temperature)
                newCurrentWeather.weatherCode = Int16(model.data[0].weather.code)
                newCurrentWeather.weatherDescription = model.data[0].weather.description
                newCurrentWeather.uvIndex = Int16(model.data[0].uvIndex)
                newCurrentWeather.windVelocity = Int16(model.data[0].windVelocity)
                newCurrentWeather.airQualityIndex = Int16(model.data[0].airQualityIndex)
                newCurrentWeather.airQualityIndexScore = CoreDataHelper.defaultHelper.getAQIScore(from: model.data[0].airQualityIndex)
                newCurrentWeather.airQualityIndexDescription = CoreDataHelper.defaultHelper.getAQIDescription(from: model.data[0].airQualityIndex)
                newCurrentWeather.humidityLevel = Int16(model.data[0].humidityLevel)
                newCurrentWeather.toCity = copyCity
            }
            do {
                try taskContext.save()
                completion()
            } catch {
                debugPrint("🎲 Failed to update current weather: \(error)")
            }
        }
    }

    func updateForecast24h(weather model: Forecast5dBy3hModel, to city: CityCoreData, completion: @escaping () -> ()) {
        persistentContainer.performBackgroundTask { taskContext in
            let objectId = city.objectID
            let copyCity = taskContext.object(with: objectId) as! CityCoreData

            copyCity.forecast3h?.forEach({ hourForecast in
                taskContext.delete(hourForecast as! Forecast3hCoreData)
            })

            for index in 0...7 {
                let new3hWeather = Forecast3hCoreData(context: taskContext)
                new3hWeather.uid = UUID().uuidString
                new3hWeather.cloudiness = Int16(model.data[index].cloudiness)
                new3hWeather.feelsLikeTemperature = Int16(model.data[index].feelsLikeTemperature)
                new3hWeather.forecastTime = model.data[index].forecastTime
                new3hWeather.humidityLevel = Int16(model.data[index].humidityLevel)
                new3hWeather.precipitation = Int16(model.data[index].precipitation)
                new3hWeather.temperature = Int16(model.data[index].temperature)
                new3hWeather.weatherCode = Int16(model.data[index].weather.code)
                new3hWeather.weatherDescription = model.data[index].weather.description
                new3hWeather.windVelocity = Int16(model.data[index].windVelocity)
                new3hWeather.windDirection = model.data[index].windDirection
                new3hWeather.toCity = copyCity
                copyCity.addToForecast3h(new3hWeather)
            }
            do {
                try taskContext.save()
                completion()
            } catch {
                debugPrint("🎲 Failed to update 1 day weather forecast: \(error)")
            }
        }
    }

    func updateForecast16d(weather model: Forecast16dModel, to city: CityCoreData, completion: @escaping () -> ()) {
        persistentContainer.performBackgroundTask { taskContext in
            let objectId = city.objectID
            let copyCity = taskContext.object(with: objectId) as! CityCoreData
            copyCity.forecast1d?.forEach({ dayForecast in
                taskContext.delete(dayForecast as! Forecast1dCoreData)
            })
            for data in model.data {
                let new1dWeather = Forecast1dCoreData(context: taskContext)
                new1dWeather.uid = UUID().uuidString
                new1dWeather.cloudiness = Int16(data.cloudiness)
                new1dWeather.feelsLikeTemperatureMax = Int16(data.feelsLikeTemperatureMax)
                new1dWeather.feelsLikeTemperatureMin = Int16(data.feelsLikeTemperatureMin)
                new1dWeather.forecastDate = data.forecastDate
                new1dWeather.humidityLevel = Int16(data.humidityLevel)
                new1dWeather.moonphase = data.moonphase
                new1dWeather.moonphaseText = CoreDataHelper.defaultHelper.getMoonphaseText(from: data.moonphase)
                new1dWeather.moonriseTime = CoreDataHelper.defaultHelper.getTime(from: data.moonriseTime)
                new1dWeather.moonsetTime = CoreDataHelper.defaultHelper.getTime(from: data.moonsetTime)
                new1dWeather.precipitation = Int16(data.precipitation)
                new1dWeather.sunriseTime = CoreDataHelper.defaultHelper.getTime(from: data.sunriseTime)
                new1dWeather.sunsetTime = CoreDataHelper.defaultHelper.getTime(from: data.sunsetTime)
                new1dWeather.temperatureMax = Int16(data.temperatureMax)
                new1dWeather.temperatureMin = Int16(data.temperatureMin)
                new1dWeather.uvIndex = Int16(data.uvIndex)
                new1dWeather.weatherCode = Int16(data.weather.code)
                new1dWeather.weatherDescription = data.weather.description
                new1dWeather.windVelocity = Int16(data.windVelocity)
                new1dWeather.windDirection = data.windDirection
                new1dWeather.toCity = copyCity
                copyCity.addToForecast1d(new1dWeather)
            }
            do {
                try taskContext.save()
                completion()
            } catch {
                debugPrint("🎲 Failed to update 16d weather forecast: \(error)")
            }
        }
    }

    private func cityCheck(name: String) -> Bool {
        let request = CityCoreData.fetchRequest()
        let context = persistentContainer.viewContext
        do {

            if let city = try context.fetch(request).first(where: { $0.city == name }) {
                debugPrint(city.city! + "уже добавлен в CoreData")
                return true
            } else {
                return false
            }
        } catch {
            debugPrint("🎲 CoreDataError: \(error)")
            return false
        }
    }

    private func removeOutdated24hForecast(forecast: Forecast3hCoreData, context: NSManagedObjectContext) {
        context.delete(forecast)
        do {
            try context.save()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    private func removeOutdated16dForecast(forecast: Forecast1dCoreData, context: NSManagedObjectContext) {
        context.delete(forecast)
        do {
            try context.save()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

}
