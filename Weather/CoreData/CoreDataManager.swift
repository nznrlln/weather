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

            debugPrint("🌼🌼")
            NetworkManager.defaultManager.currentWeatherRequest(lon, lat) { [weak self] weather in
                self?.updateCurrentWeather(weather: weather, to: newCity)
            }
//            NetworkManager.defaultManager.forecast5dBy3hRequest(lon, lat) { [weak self] forecast in
//                self?.updateForecast24h(weather: forecast, to: newCity)
//            }
//            NetworkManager.defaultManager.forecast16dRequest(lon, lat) { [weak self] forecast in
//                self?.updateForecast16d(weather: forecast, to: newCity)
//            }
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

    func updateCurrentWeather(weather model: CurrentWeatherModel, to city: CityCoreData) {
        persistentContainer.performBackgroundTask { taskContext in
            let objectId = city.objectID
            let copyCity = taskContext.object(with: objectId) as! CityCoreData
            if let existingWeather = copyCity.currentWeather {
                existingWeather.sunriseTime = model.data[0].sunriseTime
                existingWeather.sunsetTime = model.data[0].sunsetTime
                existingWeather.temperature = model.data[0].temperature
                existingWeather.weatherCode = Int16(model.data[0].weather.code)
                existingWeather.weatherDescription = model.data[0].weather.description
                existingWeather.uvIndex = Int16(model.data[0].uvIndex)
                existingWeather.windVelocity = model.data[0].windVelocity
                existingWeather.airQualityIndex = Int16(model.data[0].airQualityIndex)
                existingWeather.airQualityIndexScore = CoreDataHelper.defaultHelper.getAQIScore(from: model.data[0].airQualityIndex)
                existingWeather.airQualityIndexDescription = CoreDataHelper.defaultHelper.getAQIDescription(from: model.data[0].airQualityIndex)
                existingWeather.humidityLevel = Int16(model.data[0].humidityLevel)
            } else {
                let newCurrentWeather = CurrentWeatherCoreData(context: taskContext)
                newCurrentWeather.sunriseTime = model.data[0].sunriseTime
                newCurrentWeather.sunsetTime = model.data[0].sunsetTime
                newCurrentWeather.temperature = model.data[0].temperature
                newCurrentWeather.weatherCode = Int16(model.data[0].weather.code)
                newCurrentWeather.weatherDescription = model.data[0].weather.description
                newCurrentWeather.uvIndex = Int16(model.data[0].uvIndex)
                newCurrentWeather.windVelocity = model.data[0].windVelocity
                newCurrentWeather.airQualityIndex = Int16(model.data[0].airQualityIndex)
                newCurrentWeather.airQualityIndexScore = CoreDataHelper.defaultHelper.getAQIScore(from: model.data[0].airQualityIndex)
                newCurrentWeather.airQualityIndexDescription = CoreDataHelper.defaultHelper.getAQIDescription(from: model.data[0].airQualityIndex)
                newCurrentWeather.humidityLevel = Int16(model.data[0].humidityLevel)
                newCurrentWeather.toCity = copyCity 
//                city.currentWeather = newCurrentWeather
            }
            do {
                try taskContext.save()
            } catch {
                debugPrint("🎲 Failed to update current weather: \(error)")
            }
        }
    }

    func updateForecast24h(weather model: Forecast5dBy3hModel, to city: CityCoreData) {
        persistentContainer.performBackgroundTask { taskContext in
            let objectId = city.objectID
            let copyCity = taskContext.object(with: objectId) as! CityCoreData
            for index in 0...7 {
                let new3hWeather = Forecast3hCoreData(context: taskContext)
                new3hWeather.uid = UUID().uuidString
                new3hWeather.cloudiness = Int16(model.data[index].cloudiness)
                new3hWeather.feelsLikeTemperature = model.data[index].feelsLikeTemperature
                new3hWeather.forecastTime = model.data[index].forecastTime
                new3hWeather.humidityLevel = Int16(model.data[index].humidityLevel)
                new3hWeather.precipitation = Int16(model.data[index].precipitation)
                new3hWeather.temperature = model.data[index].temperature
                new3hWeather.weatherCode = Int16(model.data[index].weather.code)
                new3hWeather.weatherDescription = model.data[index].weather.description
                new3hWeather.windVelocity = model.data[index].windVelocity
                new3hWeather.windDirection = model.data[index].windDirection
                new3hWeather.toCity = copyCity
                copyCity.addToForecast3h(new3hWeather)
            }
            do {
                try taskContext.save()
            } catch {
                debugPrint("🎲 Failed to update 1 day weather forecast: \(error)")
            }
        }
    }

    func updateForecast16d(weather model: Forecast16dModel, to city: CityCoreData) {
        persistentContainer.performBackgroundTask { taskContext in
            let objectId = city.objectID
            let copyCity = taskContext.object(with: objectId) as! CityCoreData
            for data in model.data {
                let new1dWeather = Forecast1dCoreData(context: taskContext)
                new1dWeather.uid = UUID().uuidString
                new1dWeather.cloudiness = Int16(data.cloudiness)
                new1dWeather.feelsLikeTemperatureMax = data.feelsLikeTemperatureMax
                new1dWeather.feelsLikeTemperatureMin = data.feelsLikeTemperatureMin
                new1dWeather.forecastDate = data.forecastDate
                new1dWeather.humidityLevel = Int16(data.humidityLevel)
                new1dWeather.moonphase = data.moonphase
                new1dWeather.moonphaseText = CoreDataHelper.defaultHelper.getMoonphaseText(from: data.moonphase)
                new1dWeather.moonriseTime = CoreDataHelper.defaultHelper.getTime(from: data.moonriseTime)
                new1dWeather.moonsetTime = CoreDataHelper.defaultHelper.getTime(from: data.moonsetTime)
                new1dWeather.precipitation = Int16(data.precipitation)
                new1dWeather.sunriseTime = CoreDataHelper.defaultHelper.getTime(from: data.sunriseTime)
                new1dWeather.sunsetTime = CoreDataHelper.defaultHelper.getTime(from: data.sunsetTime)
                new1dWeather.temperatureMax = data.temperatureMax
                new1dWeather.temperatureMin = data.temperatureMin
                new1dWeather.uvIndex = Int16(data.uvIndex)
                new1dWeather.weatherCode = Int16(data.weather.code)
                new1dWeather.weatherDescription = data.weather.description
                new1dWeather.windVelocity = data.windVelocity
                new1dWeather.windDirection = data.windDirection
                new1dWeather.toCity = copyCity
                copyCity.addToForecast1d(new1dWeather)
            }
            do {
                try taskContext.save()
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

//    private func removeOutdated5dForecast(from city: CityCoreData, context: NSManagedObjectContext) {
//        for forecast in city.forecast3h {
//            context.delete(forecast)
//        }
//    }
//
//    private func removeOutdated16dForecast(from city: CityCoreData, context: NSManagedObjectContext) {
//        for forecast in city.forecast1d {
//            context.delete(forecast)
//        }
//    }
        
    }

    /*

    lazy var defaultManager = CoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Weather")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()


    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
     */
//}

