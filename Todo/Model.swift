//
//  TodoModel.swift
//  LashMaker
//
//  Created by Alexander Malakhov on 01/01/2016.
//  Copyright (c) 2016 LashMakers.pro All rights reserved.
//
import Foundation
import RealmSwift

class dayRecord : NSObject {
    var name: String = ""
    var phone: String = ""
    var master: String = ""
    var date: NSDate = NSDate()
    var price: Int = 0
    var key: String = ""
}



class TodoModel : NSObject{
    var id: String
    var image: String
    var title: String
    var clientName: String
    var clientPhone: String
    var date: NSDate
    
    init (id: String, image: String, title: String, clientName: String, clientPhone: String, date: NSDate) {
        self.id = id
        self.image = image
        self.title = title
        self.date = date
        self.clientName = clientName
        self.clientPhone = clientPhone
    }

}



class LMClient: Object {
    dynamic var name = ""
    dynamic var phone = ""
}

class LMOrder: Object {
    dynamic var name = ""
    dynamic var dateOrder : NSDate?
    dynamic var client : LMClient?
    dynamic var isActive = false
    dynamic var isBlack = false
    dynamic var detailsObyem = ""
    dynamic var detailsIzgib = ""
    dynamic var detailsTolshina = ""
    dynamic var detailsDlina = ""
    dynamic var detailsEffekt = ""
    dynamic var detailsSnyatie = false
}

//Данные о сотрудниках и настройки, обычный пользователь или менеджер
class LMWorker: Object {
    dynamic var name = ""
    dynamic var userName = ""
    dynamic var userPhone = ""
    dynamic var isManager = false
    let orders = List<LMOrder>()
}


// Начальное заполнение данных о студии
// в зависимости от режима работы (false - один пользователь; true - студия)
// В режиме false - настройки заполняются автоматически и недоступны для редактирования пользователем, невозможно добавлять сотрудников
// В режиме true  - настройки доступны для редактирования, возможно добавлять сотрудников, делать записи на сотрудников

class LMStudio: Object {
    dynamic var serverID  = "" // Идентфикатор студии на сервере
    dynamic var mode      = false //Режим работы (false - один пользователь; true - студия)
    dynamic var name      = "" // Название студии
    dynamic var director  = "" // Контактное лицо
    dynamic var address   = "" // Адрес
    dynamic var phone     = "" // Контактный телефон
    dynamic var site      = "" // Ссылка на Сайт
    dynamic var instagram = "" // Ссылка на Инстаграм
    dynamic var vkontakte = "" // Ссылка на Вконтакте
    dynamic var createdAt = NSDate() // Дата создания студии в телефоне
    //------Сотрудники----------
    let workers = List<LMWorker>()
}

