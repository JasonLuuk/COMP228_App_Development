//
//  dataModel.swift
//  Assignment2 Uol Map
//
//  Created by Jason on 03/12/2021.
//

import Foundation
// The sample code given by phil defines a data structure to store the artwork on campus
struct artSet: Decodable {
let id: String
let title:  String
let artist: String
let yearOfWork: String
let type: String?
let Information:  String
let lat: String
let long: String
let location: String
let locationNotes: String
let ImagefileName: String
let thumbnail: URL
let lastModified: String
let enabled: String
}

// The sample code given by phil defines a data structure to store the artwork on campus
struct artsReports: Decodable {
    let campusart: [artSet]
}
