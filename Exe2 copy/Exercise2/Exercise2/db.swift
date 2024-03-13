import Foundation
import SQLite3

class DatabaseManager {
    var db: OpaquePointer?
    let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    init() {
        openDatabase()
        createTable()
    }
    
    func openDatabase() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("mydatabase.sqlite")
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
    }
    
    func createTable() {
        guard let db = db else {
            print("Database is not initialized")
            return
        }
        
        let createTableQuery = "CREATE TABLE IF NOT EXISTS UserInfo (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, ageRange TEXT, continent TEXT, temp DOUBLE, pets TEXT)"
        if sqlite3_exec(db, createTableQuery, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error creating table: \(errmsg)")
        }
    }

    
    func insertData(name: String, ageRange: String, continent: String, temp: Double, pets: [String]) {
        guard let db = db else {
            print("Database is not initialized")
            return
        }
        
        var stmt: OpaquePointer?
        let insertQuery = "INSERT INTO UserInfo (name, ageRange, continent, temp, pets) VALUES (?, ?, ?, ?, ?)"
        if sqlite3_prepare_v2(db, insertQuery, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error preparing insert: \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stmt, 1, name, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error binding name: \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stmt, 2, ageRange, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error binding ageRange: \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stmt, 3, continent, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error binding continent: \(errmsg)")
            return
        }
        
        if sqlite3_bind_double(stmt, 4, temp) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error binding temp: \(errmsg)")
            return
        }
        
        let petsString = pets.joined(separator: ",")
        if sqlite3_bind_text(stmt, 5, petsString, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error binding pets: \(errmsg)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error inserting data: \(errmsg)")
            return
        }
        
        sqlite3_finalize(stmt)
    }



 
    
    func fetchData() {
        guard let db = db else {
            print("Database is not initialized")
            return
        }
        
        let query = "SELECT * FROM UserInfo"
        var stmt: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let nameCStr = sqlite3_column_text(stmt, 1)
                let ageRangeCStr = sqlite3_column_text(stmt, 2)
                let continentCStr = sqlite3_column_text(stmt, 3)
                let temp = sqlite3_column_double(stmt, 4)
                let petsCStr = sqlite3_column_text(stmt, 5)
                
                let name = nameCStr != nil ? String(cString: nameCStr!) : "nil"
                let ageRange = ageRangeCStr != nil ? String(cString: ageRangeCStr!) : "nil"
                let continent = continentCStr != nil ? String(cString: continentCStr!) : "nil"
                let pets = petsCStr != nil ? String(cString: petsCStr!) : "nil"
                
                print("Name: \(name), Age Range: \(ageRange), Continent: \(continent), Temperature: \(temp), Pets: \(pets)")
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error preparing fetch: \(errmsg)")
        }

        sqlite3_finalize(stmt)
    }
    
    func deleteAllData() {
        guard let db = db else {
            print("Database is not initialized")
            return
        }
        
        let deleteAllQuery = "DELETE FROM UserInfo"
        var stmt: OpaquePointer?
        
        if sqlite3_prepare_v2(db, deleteAllQuery, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error preparing delete all: \(errmsg)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error deleting all data: \(errmsg)")
            return
        }
        
        sqlite3_finalize(stmt)
    }



}
