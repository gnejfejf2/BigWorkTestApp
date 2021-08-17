// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let campaignModel = try? newJSONDecoder().decode(CampaignModel.self, from: jsonData)

import Foundation


typealias CampaignModelElements = [CampaignModelElement]

// MARK: - CampaignModelElement
struct CampaignModelElement: Codable, Hashable {
    let status: Status
    let enabled: Bool
    let additionalServiceid: Int?
    let endDate: String
    let ratio, donatedSteps: Int
    let organizations: [Organization]
    let startDate: String
    let serviceOnTime: Bool
    let remainedDaysToEnd, goalPoint: Int
    let detailThumbnailImagePath: String
    let largeListThumbnailImagePath, mediumListThumbnailImagePath: String?
    let smallListThumbnailImagePath: String
    let participantCount: Int
    let beneficiary: String
    let beneficiaryLink: String
    let beneficiaryBtn: BeneficiaryBtn
    let categoryid, smsid: Int
    let campaignPromoter: CampaignPromoter
    let formattedStartDate, formattedEndDate, name: String
    let id: Int
    let my: My
    let event: Event?
    let service: Service?

    enum CodingKeys: String, CodingKey {
        case status, enabled
        case additionalServiceid = "additionalServiceId"
        case endDate, ratio, donatedSteps, organizations, startDate, serviceOnTime, remainedDaysToEnd, goalPoint, detailThumbnailImagePath, largeListThumbnailImagePath, mediumListThumbnailImagePath, smallListThumbnailImagePath, participantCount, beneficiary, beneficiaryLink, beneficiaryBtn
        case categoryid = "categoryId"
        case smsid = "smsId"
        case campaignPromoter, formattedStartDate, formattedEndDate, name, id, my, event, service
    }
}

enum BeneficiaryBtn: String, Codable, Hashable {
    case empty = ""
    case 링크 = "링크"
    case 바로가기 = "바로가기"
    case 빅워크 = "빅워크"
    case 음원듣기 = "음원듣기"
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - CampaignPromoter
struct CampaignPromoter: Codable, Hashable {
    let name: String
    let id: Int
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Event
struct Event: Codable, Hashable {
    let eventDescription, endDate, startDate, extra1: String
    let extra2: JSONNull?
    let type: String

    enum CodingKeys: String, CodingKey {
        case eventDescription = "description"
        case endDate, startDate, extra1, extra2, type
    }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - My
struct My: Codable, Hashable {
    let donatedSteps, ranking: Int
    let lastDonatedDateTime: String?
    let story: Bool
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Organization
struct Organization: Codable, Hashable {
    let id: Int
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Service
struct Service: Codable, Hashable {
    let id: Int
    let type: String
}

enum Status: String, Codable, Hashable {
    case end = "END"
    case start = "START"
}


// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
