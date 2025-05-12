import Foundation

struct BookModel: Codable {
    let meta: Meta
    let documents: [Documents]
    
    struct Meta: Codable {
        let isEnd: Bool?
        let pageableCount: Int?
        let totalCount: Int?
        
        enum CodingKeys: String, CodingKey {
            case isEnd = "is_end"
            case pageableCount = "pageable_count"
            case totalCount = "total_count"
        }
    }
    
    struct Documents: Codable {
        let title: String
        let contents: String
        let url: String
        let isbn: String
        let datetime: String
        let authors: [String]
        let publisher: String
        let translators: [String]
        let price: Int
        let salePrice: Int?
        let thumbnail: String
        let status: String
        
        enum CodingKeys: String, CodingKey {
            case authors, contents, datetime, isbn, price, publisher
            case salePrice = "sale_price"
            case status, thumbnail, title, translators, url
        }
        
    }
}
