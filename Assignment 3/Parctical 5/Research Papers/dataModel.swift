//
//  dataModel.swift
//  Research Papers
//
//  Created by Jason on 25/11/2021.
//

import Foundation

// This is the code given by phil to define the json structure
struct techReport: Decodable {
let year: String
let id:  String
let owner: String?
let email: String?
let authors: String
let title:  String
let abstract: String?
let pdf: URL?
let comment: String?
let lastModified: String
}

struct technicalReports: Decodable {
let techreports2: [techReport]
}
