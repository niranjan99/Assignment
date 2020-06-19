//
//  FeedsModel.swift
//  Assignment
//
//  Created by Niranjan on 18/06/20.
//  Copyright © 2020 Niranjan. All rights reserved.
//
import Foundation

struct FeedsModel: Codable {
    let title: String?
    let rows: [ListModel]?
}

extension FeedsModel: Parceable {
    static func parseObject(data: Data) -> Result<FeedsModel, ErrorResult> {
        let decoder = JSONDecoder()
        let response = String(data: data, encoding: String.Encoding.ascii)
        guard let data2 = response?.data(using: String.Encoding.utf8) else { return Result.failure(ErrorResult.parser(string: "Unable to parse FeedsModel results"))  }
        if let result = try? decoder.decode(FeedsModel.self, from: data2) {
            return Result.success(result)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse FeedsModel results"))
        }
    }
}
