//
//  DefinitionDTO.swift
//  
//
//  Created by serdar on 27.05.2023.
//

import Foundation

public struct DefinitionResult: Decodable {
    public let word: String?
    public let phonetic: String?
    public let phonetics: [Phonetic]?
    public let meanings: [Meaning]?
    
    private enum RootCodingKeys: String, CodingKey {
        case word, phonetic, phonetics,meanings
    }
}


public struct Meaning: Decodable{
    public let partOfSpeech: String?
    public let definitions: [Definition]?
    
    enum CodingKeys: String, CodingKey {
        case partOfSpeech, definitions
    }
}

public struct Definition: Decodable{
    public let definition: String?
    public let example: String?
    
    enum CodingKeys: String, CodingKey {
        case definition, example
    }
}

public struct Phonetic: Decodable{
    public let audio: String?
    
    enum CodingKeys: String, CodingKey {
        case audio
    }
}
