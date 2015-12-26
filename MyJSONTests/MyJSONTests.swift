//
//  MyJSONTests.swift
//  MyJSONTests
//
//  Created by Stefano Vettor on 13/09/15.
//  Copyright © 2015 Stefano Vettor. All rights reserved.
//

import XCTest
import MyJSON

class MyJSONTests: XCTestCase {
    
    var testData: NSData!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        if let file = NSBundle(forClass:MyJSONTests.self).pathForResource("TestStandard", ofType: "json") {
            self.testData = NSData(contentsOfFile: file)
        } else {
            XCTFail("Can't find the test JSON file")
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testString() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let jObject = JSON(data: testData)
        
        XCTAssertEqual(jObject["object_id"], "1234567")
        XCTAssertEqual(jObject["object_id"].string, "1234567")
        XCTAssertEqual(jObject["object_id"].string, jObject["object_id"])
        
        XCTAssertEqual(jObject["creation_date"], "27/12/2014 07:30:15.777")
        XCTAssertEqual(jObject["creation_date"].string, "27/12/2014 07:30:15.777")
        XCTAssertEqual(jObject["creation_date"].string, jObject["creation_date"])
    }
    
    func testNumber() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let jObject = JSON(data: testData)
        
        XCTAssertEqual(jObject["priority"], 7)
        XCTAssertEqual(jObject["priority"].integer, 7)
        XCTAssertEqual(jObject["priority"].integer, jObject["priority"])
        
        XCTAssertEqual(jObject["priority"], 7.0)
        XCTAssertEqual(jObject["priority"].double, 7.0)
        XCTAssertEqual(jObject["priority"].double, jObject["priority"])
        
        XCTAssertEqual(jObject["priority"].float, 7.0)
        XCTAssertEqual(jObject["priority"].float, jObject["priority"])
    }
    
    func testBool() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let jObject = JSON(data: testData)
        
        XCTAssertEqual(jObject["is_json"], true)
        XCTAssertEqual(jObject["is_json"].bool, true)
        XCTAssertEqual(jObject["is_json"].bool, jObject["is_json"])
        
        XCTAssertEqual(jObject["is_xml"], false)
        XCTAssertEqual(jObject["is_xml"].bool, false)
        XCTAssertEqual(jObject["is_xml"].bool, jObject["is_xml"])
        
        XCTAssertEqual(jObject["is_json"].integer, 1)
        XCTAssertEqual(jObject["is_xml"].integer, 0)
    }
    
    func testArrayString() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let jObject = JSON(data: testData)
        
        XCTAssertTrue(jObject["related_objects_ids"].count == 4)
        XCTAssertEqual(jObject["related_objects_ids"][0], "11111")
        XCTAssertEqual(jObject["related_objects_ids"][1].string, "222222")
        XCTAssertEqual(jObject["related_objects_ids"][2], "4444444")
        XCTAssertEqual(jObject["related_objects_ids"][3].string, "7777777")
        
        let testArray = ["11111","222222","4444444","7777777"]
        var index = 0
        for strElement: String in jObject["related_objects_ids"]! {
            XCTAssertEqual(strElement, testArray[index++])
        }
        
        index = 0
        for strElement in jObject["related_objects_ids"].stringArray! {
            XCTAssertEqual(strElement, testArray[index++])
        }
        
        index = 0
        for jsonElement in jObject["related_objects_ids"] {
            XCTAssertEqual(jsonElement.string, testArray[index++])
        }
    }
    
    func testArrayEnumerationString() {
        let jObject = JSON(data: testData)
        
        let testArray = ["11111","222222","4444444","7777777"]
        var index = 0
        for (objIndex, jsonElement) in jObject["related_objects_ids"].enumerate() {
            XCTAssertEqual(index++, objIndex)
            XCTAssertEqual(~jsonElement, testArray[objIndex])
        }
    }
    
    func testDictionaryEnumerationStringBase() {
        let jObject = JSON(data: testData)
        
        if let theDic = jObject.dictionary {
            for (key, value) in theDic {
                XCTAssertEqual(value,jObject[key])
            }
        }
    }
    
    func testArrayInteger() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let jObject = JSON(data: testData)
        
        XCTAssertTrue(jObject["fibonacci"].count == 7)
        XCTAssertEqual(jObject["fibonacci"][0], 1)
        XCTAssertEqual(jObject["fibonacci"][1].integer, 2)
        XCTAssertEqual(jObject["fibonacci"][2], 3)
        XCTAssertEqual(jObject["fibonacci"][3].integer, 5)
        XCTAssertEqual(jObject["fibonacci"][4], 8)
        XCTAssertEqual(jObject["fibonacci"][5].integer, 13)
        XCTAssertEqual(jObject["fibonacci"][6], 21)
        
        let testArray = [1,2,3,5,8,13,21]
        var index = 0
        for intElement: Int in jObject["fibonacci"]! {
            XCTAssertEqual(intElement, testArray[index++])
        }
        
        index = 0
        for intElement in jObject["fibonacci"].integerArray! {
            XCTAssertEqual(intElement, testArray[index++])
        }
        
        index = 0
        for jsonElement in jObject["fibonacci"] {
            XCTAssertEqual(jsonElement.integer, testArray[index++])
        }
    }
    
    func testArrayDouble() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let jObject = JSON(data: testData)
        
        XCTAssertTrue(jObject["fibonacci_not_integer"].count == 7)
        XCTAssertEqual(jObject["fibonacci_not_integer"][0], 1.1)
        XCTAssertEqual(jObject["fibonacci_not_integer"][1].double, 2.2)
        XCTAssertEqual(jObject["fibonacci_not_integer"][2], 3.3)
        XCTAssertEqual(jObject["fibonacci_not_integer"][3].double, 5.5)
        XCTAssertEqual(jObject["fibonacci_not_integer"][4], 8.8)
        XCTAssertEqual(jObject["fibonacci_not_integer"][5], 14.3)
        XCTAssertEqual(jObject["fibonacci_not_integer"][6].double, 23.1)
        
        let testArray = [1.1,2.2,3.3,5.5,8.8,14.3,23.1]
        var index = 0
        for doubleElement: Double in jObject["fibonacci_not_integer"]! {
            XCTAssertEqual(doubleElement, testArray[index++])
        }
        
        index = 0
        for doubleElement in jObject["fibonacci_not_integer"].doubleArray! {
            XCTAssertEqual(doubleElement, testArray[index++])
        }
        
        index = 0
        for jsonElement in jObject["fibonacci_not_integer"] {
            XCTAssertEqual(jsonElement.double, testArray[index++])
        }
    }
    
    func testArrayFloat() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let jObject = JSON(data: testData)
        
        let testArray: [Float] = [1.1,2.2,3.3,5.5,8.8,14.3,23.1]
        var index = 0
        for floatElement: Float in jObject["fibonacci_not_integer"]! {
            XCTAssertEqual(floatElement, testArray[index++])
        }
        
        index = 0
        for floatElement in jObject["fibonacci_not_integer"].floatArray! {
            XCTAssertEqual(floatElement, testArray[index++])
        }
        
        index = 0
        for jsonElement in jObject["fibonacci_not_integer"] {
            XCTAssertEqual(jsonElement.float, testArray[index++])
        }
    }
    
    func testArrayBool() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let jObject = JSON(data: testData)
        
        XCTAssertTrue(jObject["boolean_array"].count == 5)
        XCTAssertEqual(jObject["boolean_array"][0], true)
        XCTAssertEqual(jObject["boolean_array"][1], true)
        XCTAssertEqual(jObject["boolean_array"][2].bool, false)
        XCTAssertEqual(jObject["boolean_array"][3], true)
        XCTAssertEqual(jObject["boolean_array"][4].bool, false)
        
        let testArray = [true, true, false, true, false]
        var index = 0
        for boolElement: Bool in jObject["boolean_array"]! {
            XCTAssertEqual(boolElement, testArray[index++])
        }
        
        index = 0
        for boolElement in jObject["boolean_array"].boolArray! {
            XCTAssertEqual(boolElement, testArray[index++])
        }
        
        index = 0
        for jsonElement in jObject["boolean_array"] {
            XCTAssertEqual(jsonElement.bool, testArray[index++])
        }
    }
    
    func testArrayArray() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let jObject = JSON(data: testData)
        
        XCTAssertTrue(jObject["arrayception"].count == 2)
        XCTAssertEqual(jObject["arrayception"][0][0], "11")
        XCTAssertEqual(jObject["arrayception"][0][1].string, "22")
        XCTAssertEqual(jObject["arrayception"][1][0], "33")
        XCTAssertEqual(jObject["arrayception"][1][1].string, "44")
        
        let testArray = ["11","22","33","44"]
        var index = 0
        
        for jsonElement in jObject["arrayception"] {
            for jsonSubElement in  jsonElement {
                XCTAssertEqual(jsonSubElement.string, testArray[index++])
            }
        }
        
        index = 0
        var subArray: [String]? = jObject["arrayception"][0]
        for string in subArray! {
            XCTAssertEqual(string, testArray[index++])
        }
        subArray = jObject["arrayception"][1].stringArray
        for string in subArray! {
            XCTAssertEqual(string, testArray[index++])
        }
        
        index = 0
        for jsonElement in jObject["arrayception"] {
            for jsonSubElement in  jsonElement {
                XCTAssertEqual(~jsonSubElement, testArray[index++])
            }
        }
        
        index = 0
        for jsonElement in jObject["arrayception"] {
            for stringSubElement in  jsonElement.stringArray! {
                XCTAssertEqual(stringSubElement, testArray[index++])
            }
        }
        
        index = 0
        for jsonElement in jObject["arrayception"].jsonArray! {
            for jsonSubElement in  jsonElement.jsonArray! {
                XCTAssertEqual(jsonSubElement.string, testArray[index++])
            }
        }
        
        index = 0
        for jsonElement in jObject["arrayception"].jsonArray! {
            for stringSubElement in  jsonElement.stringArray! {
                XCTAssertEqual(stringSubElement, testArray[index++])
            }
        }
        
    }
    
    func testSubElementString() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let jObject = JSON(data: testData)
        
        XCTAssertEqual(jObject["sub_object"]["object_id"], "234234")
        XCTAssertEqual(jObject["sub_object", "object_id"], "234234")
        XCTAssertEqual(jObject["sub_object"]["object_id"].string, "234234")
        XCTAssertEqual(jObject["sub_object"]["object_id"].string, jObject["sub_object"]["object_id"])
        
        XCTAssertEqual(jObject["sub_object"]["creation_date"], "28/10/2013 08:37:18.777")
        XCTAssertEqual(jObject["sub_object"]["creation_date"].string, "28/10/2013 08:37:18.777")
        XCTAssertEqual(jObject["sub_object"]["creation_date"].string, jObject["sub_object"]["creation_date"])
        
        if let jsonSubObject: JSON = jObject["sub_object"] {
            XCTAssertEqual(jsonSubObject["object_id"], "234234")
            XCTAssertEqual(jsonSubObject["object_id"].string, "234234")
            XCTAssertEqual(jsonSubObject["object_id"].string, jsonSubObject["object_id"])
            
            XCTAssertEqual(jsonSubObject["creation_date"], "28/10/2013 08:37:18.777")
            XCTAssertEqual(jsonSubObject["creation_date"].string, "28/10/2013 08:37:18.777")
            XCTAssertEqual(jsonSubObject["creation_date"].string, jsonSubObject["creation_date"])
        }
    }
    
    func testSubElementNumber() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let jObject = JSON(data: testData)
        
        XCTAssertEqual(jObject["sub_object"]["priority"].integer, 4)
        
        XCTAssertEqual(jObject["sub_object"]["priority"], 4.7)
        XCTAssertEqual(jObject["sub_object"]["priority"].double, 4.7)
        XCTAssertEqual(jObject["sub_object"]["priority"].double, jObject["sub_object"]["priority"])
        
        XCTAssertEqual(jObject["sub_object"]["priority"].float, 4.7)
        XCTAssertEqual(jObject["sub_object"]["priority"].float, jObject["sub_object"]["priority"])
        
        if let jsonSubObject: JSON = jObject["sub_object"] {
            XCTAssertEqual(jObject["sub_object"]["priority"].integer, 4)
            
            XCTAssertEqual(jsonSubObject["priority"], 4.7)
            XCTAssertEqual(jsonSubObject["priority"].double, 4.7)
            XCTAssertEqual(jsonSubObject["priority"].double, jsonSubObject["priority"])
            
            XCTAssertEqual(jsonSubObject["priority"].float, 4.7)
            XCTAssertEqual(jsonSubObject["priority"].float, jsonSubObject["priority"])
        }
    }
    
    func testSubElementBool() {
        let jObject = JSON(data: testData)
        
        XCTAssertEqual(jObject["sub_object"]["is_json"], true)
        XCTAssertEqual(jObject["sub_object"]["is_json"].bool, true)
        XCTAssertEqual(jObject["sub_object"]["is_json"].bool, jObject["sub_object"]["is_json"])
        
        XCTAssertEqual(jObject["sub_object"]["is_xml"], false)
        XCTAssertEqual(jObject["sub_object"]["is_xml"].bool, false)
        XCTAssertEqual(jObject["sub_object"]["is_xml"].bool, jObject["sub_object"]["is_xml"])
        
        XCTAssertEqual(jObject["sub_object"]["is_json"].integer, 1)
        XCTAssertEqual(jObject["sub_object"]["is_xml"].integer, 0)
        
        if let jsonSubObject: JSON = jObject["sub_object"] {
            XCTAssertEqual(jsonSubObject["is_json"], true)
            XCTAssertEqual(jsonSubObject["is_json"].bool, true)
            XCTAssertEqual(jsonSubObject["is_json"].bool, jsonSubObject["is_json"])
            
            XCTAssertEqual(jsonSubObject["is_xml"], false)
            XCTAssertEqual(jsonSubObject["is_xml"].bool, false)
            XCTAssertEqual(jsonSubObject["is_xml"].bool, jsonSubObject["is_xml"])
            
            XCTAssertEqual(jsonSubObject["is_json"].integer, 1)
            XCTAssertEqual(jsonSubObject["is_xml"].integer, 0)
        }
    }
    
    func testSubElementArrayString() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let jObject = JSON(data: testData)
        
        XCTAssertTrue(jObject["sub_object"]["related_objects_ids"].count == 4)
        XCTAssertEqual(jObject["sub_object"]["related_objects_ids"][0], "32433")
        XCTAssertEqual(jObject["sub_object"]["related_objects_ids"][1], "5646")
        XCTAssertEqual(jObject["sub_object"]["related_objects_ids"][2], "36463")
        XCTAssertEqual(jObject["sub_object"]["related_objects_ids"][3], "6799679")
        
        let testArray = ["32433","5646","36463","6799679"]
        var index = 0
        for strElement: String in jObject["sub_object"]["related_objects_ids"]! {
            XCTAssertEqual(strElement, testArray[index++])
        }
        
        index = 0
        for strElement in jObject["sub_object"]["related_objects_ids"].stringArray! {
            XCTAssertEqual(strElement, testArray[index++])
        }
        
        index = 0
        for jsonElement in jObject["sub_object"]["related_objects_ids"] {
            XCTAssertEqual(jsonElement.string, testArray[index++])
        }
        
        if let jsonSubObject: JSON = jObject["sub_object"] {
            XCTAssertTrue(jsonSubObject["related_objects_ids"].count == 4)
            XCTAssertEqual(jsonSubObject["related_objects_ids"][0], "32433")
            XCTAssertEqual(jsonSubObject["related_objects_ids"][1], "5646")
            XCTAssertEqual(jsonSubObject["related_objects_ids"][2], "36463")
            XCTAssertEqual(jsonSubObject["related_objects_ids"][3], "6799679")
            
            let testArray = ["32433","5646","36463","6799679"]
            var index = 0
            for strElement: String in jsonSubObject["related_objects_ids"]! {
                XCTAssertEqual(strElement, testArray[index++])
            }
            
            index = 0
            for strElement in jsonSubObject["related_objects_ids"].stringArray! {
                XCTAssertEqual(strElement, testArray[index++])
            }
            
            index = 0
            for jsonElement in jsonSubObject["related_objects_ids"] {
                XCTAssertEqual(jsonElement.string, testArray[index++])
            }
        }
    }
    
    func testSubElementArrayInteger() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let jObject = JSON(data: testData)
        
        XCTAssertTrue(jObject["sub_object"]["integer_array"].count == 8)
        XCTAssertEqual(jObject["sub_object"]["integer_array"][0], 0)
        XCTAssertEqual(jObject["sub_object"]["integer_array"][1].integer, 4)
        XCTAssertEqual(jObject["sub_object"]["integer_array"][2].integer, 8)
        XCTAssertEqual(jObject["sub_object"]["integer_array"][3], 5)
        XCTAssertEqual(jObject["sub_object"]["integer_array"][4], 7)
        XCTAssertEqual(jObject["sub_object"]["integer_array"][5].integer, 13)
        XCTAssertEqual(jObject["sub_object"]["integer_array"][6], 27)
        XCTAssertEqual(jObject["sub_object"]["integer_array"][7], 2)
        
        let testArray = [0,4,8,5,7,13,27,2]
        var index = 0
        for intElement: Int in jObject["sub_object"]["integer_array"]! {
            XCTAssertEqual(intElement, testArray[index++])
        }
        
        index = 0
        for intElement in jObject["sub_object"]["integer_array"].integerArray! {
            XCTAssertEqual(intElement, testArray[index++])
        }
        
        index = 0
        for jsonElement in jObject["sub_object"]["integer_array"] {
            XCTAssertEqual(jsonElement.integer, testArray[index++])
        }
        
        if let jsonSubObject: JSON = jObject["sub_object"] {
            XCTAssertTrue(jsonSubObject["integer_array"].count == 8)
            XCTAssertEqual(jsonSubObject["integer_array"][0], 0)
            XCTAssertEqual(jsonSubObject["integer_array"][1].integer, 4)
            XCTAssertEqual(jsonSubObject["integer_array"][2], 8)
            XCTAssertEqual(jsonSubObject["integer_array"][3].integer, 5)
            XCTAssertEqual(jsonSubObject["integer_array"][4], 7)
            XCTAssertEqual(jsonSubObject["integer_array"][5].integer, 13)
            XCTAssertEqual(jsonSubObject["integer_array"][6], 27)
            XCTAssertEqual(jsonSubObject["integer_array"][7], 2)
            
            let testArray = [0,4,8,5,7,13,27,2]
            var index = 0
            for intElement: Int in jObject["sub_object"]["integer_array"]! {
                XCTAssertEqual(intElement, testArray[index++])
            }
            
            index = 0
            for intElement in jsonSubObject["integer_array"].integerArray! {
                XCTAssertEqual(intElement, testArray[index++])
            }
            
            index = 0
            for jsonElement in jsonSubObject["integer_array"] {
                XCTAssertEqual(jsonElement.integer, testArray[index++])
            }
        }
    }
    
    func testSubElementArrayDouble() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let jObject = JSON(data: testData)
        
        XCTAssertTrue(jObject["sub_object"]["comma_array"].count == 7)
        XCTAssertEqual(jObject["sub_object"]["comma_array"][0], 2.1)
        XCTAssertEqual(jObject["sub_object"]["comma_array"][1].double, 5.2)
        XCTAssertEqual(jObject["sub_object"]["comma_array"][2], 22.3)
        XCTAssertEqual(jObject["sub_object"]["comma_array"][3], 7.5)
        XCTAssertEqual(jObject["sub_object"]["comma_array"][4].double, 9.8)
        XCTAssertEqual(jObject["sub_object"]["comma_array"][5].double, 141.3)
        XCTAssertEqual(jObject["sub_object"]["comma_array"][6], 203.1)
        
        let testArray = [2.1,5.2,22.3,7.5,9.8,141.3,203.1]
        var index = 0
        for doubleElement: Double in jObject["sub_object"]["comma_array"]! {
            XCTAssertEqual(doubleElement, testArray[index++])
        }
        
        index = 0
        for doubleElement in jObject["sub_object"]["comma_array"].doubleArray! {
            XCTAssertEqual(doubleElement, testArray[index++])
        }
        
        index = 0
        for jsonElement in jObject["sub_object"]["comma_array"] {
            XCTAssertEqual(jsonElement.double, testArray[index++])
        }
        
        if let jsonSubObject: JSON = jObject["sub_object"] {
            XCTAssertTrue(jsonSubObject["comma_array"].count == 7)
            XCTAssertEqual(jsonSubObject["comma_array"][0], 2.1)
            XCTAssertEqual(jsonSubObject["comma_array"][1].double, 5.2)
            XCTAssertEqual(jsonSubObject["comma_array"][2], 22.3)
            XCTAssertEqual(jsonSubObject["comma_array"][3], 7.5)
            XCTAssertEqual(jsonSubObject["comma_array"][4].double, 9.8)
            XCTAssertEqual(jsonSubObject["comma_array"][5].double, 141.3)
            XCTAssertEqual(jsonSubObject["comma_array"][6], 203.1)
            
            let testArray = [2.1,5.2,22.3,7.5,9.8,141.3,203.1]
            var index = 0
            for doubleElement: Double in jsonSubObject["comma_array"]! {
                XCTAssertEqual(doubleElement, testArray[index++])
            }
            
            index = 0
            for doubleElement in jsonSubObject["comma_array"].doubleArray! {
                XCTAssertEqual(doubleElement, testArray[index++])
            }
            
            index = 0
            for jsonElement in jsonSubObject["comma_array"] {
                XCTAssertEqual(jsonElement.double, testArray[index++])
            }
        }
    }
    
    func testSubElementArrayBool() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let jObject = JSON(data: testData)
        
        XCTAssertTrue(jObject["sub_object"]["boolean_array"].count == 5)
        XCTAssertEqual(jObject["sub_object"]["boolean_array"][0], true)
        XCTAssertEqual(jObject["sub_object"]["boolean_array"][1], true)
        XCTAssertEqual(jObject["sub_object"]["boolean_array"][2].bool, false)
        XCTAssertEqual(jObject["sub_object"]["boolean_array"][3], true)
        XCTAssertEqual(jObject["sub_object"]["boolean_array"][4].bool, false)
        
        let testArray = [true, true, false, true, false]
        var index = 0
        for boolElement: Bool in jObject["sub_object"]["boolean_array"]! {
            XCTAssertEqual(boolElement, testArray[index++])
        }
        
        index = 0
        for boolElement in jObject["sub_object"]["boolean_array"].boolArray! {
            XCTAssertEqual(boolElement, testArray[index++])
        }
        
        index = 0
        for jsonElement in jObject["sub_object"]["boolean_array"] {
            XCTAssertEqual(jsonElement.bool, testArray[index++])
        }
        
        if let jsonSubObject: JSON = jObject["sub_object"] {
            XCTAssertTrue(jsonSubObject["boolean_array"].count == 5)
            XCTAssertEqual(jsonSubObject["boolean_array"][0], true)
            XCTAssertEqual(jsonSubObject["boolean_array"][1], true)
            XCTAssertEqual(jsonSubObject["boolean_array"][2].bool, false)
            XCTAssertEqual(jsonSubObject["boolean_array"][3], true)
            XCTAssertEqual(jsonSubObject["boolean_array"][4].bool, false)
            
            let testArray = [true, true, false, true, false]
            var index = 0
            for boolElement: Bool in jsonSubObject["boolean_array"]! {
                XCTAssertEqual(boolElement, testArray[index++])
            }
            
            index = 0
            for boolElement in jsonSubObject["boolean_array"].boolArray! {
                XCTAssertEqual(boolElement, testArray[index++])
            }
            
            index = 0
            for jsonElement in jsonSubObject["boolean_array"] {
                XCTAssertEqual(jsonElement.bool, testArray[index++])
            }
        }
    }
    
    func testSubElementArrayArray() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let jObject = JSON(data: testData)
        
        XCTAssertTrue(jObject["sub_object"]["arrayception"].count == 2)
        XCTAssertTrue(jObject["sub_object", "arrayception"].count == 2)
        XCTAssertTrue(jObject[["sub_object", "arrayception"]].count == 2)
        XCTAssertEqual(jObject["sub_object"]["arrayception"][0][0], "11")
        XCTAssertEqual(jObject["sub_object"]["arrayception"][0][1].string, "22")
        XCTAssertEqual(jObject["sub_object"]["arrayception"][1][0], "33")
        XCTAssertEqual(jObject["sub_object"]["arrayception"][1][1].string, "44")
        
        let testArray = ["11","22","33","44"]
        var index = 0
        
        for jsonElement in jObject["sub_object"]["arrayception"] {
            for jsonSubElement in  jsonElement {
                XCTAssertEqual(jsonSubElement.string, testArray[index++])
            }
        }
        
        index = 0
        var subArray: [String]? = jObject["sub_object"]["arrayception"][0]
        for string in subArray! {
            XCTAssertEqual(string, testArray[index++])
        }
        subArray = jObject["sub_object"]["arrayception"][1].stringArray
        for string in subArray! {
            XCTAssertEqual(string, testArray[index++])
        }
        
        index = 0
        for jsonElement in jObject["sub_object"]["arrayception"] {
            for jsonSubElement in  jsonElement {
                XCTAssertEqual(~jsonSubElement, testArray[index++])
            }
        }
        
        index = 0
        for jsonElement in jObject["sub_object"]["arrayception"] {
            for stringSubElement in  jsonElement.stringArray! {
                XCTAssertEqual(stringSubElement, testArray[index++])
            }
        }
        
        index = 0
        for jsonElement in jObject["sub_object"]["arrayception"].jsonArray! {
            for jsonSubElement in  jsonElement.jsonArray! {
                XCTAssertEqual(jsonSubElement.string, testArray[index++])
            }
        }
        
        index = 0
        for jsonElement in jObject["sub_object"]["arrayception"].jsonArray! {
            for stringSubElement in  jsonElement.stringArray! {
                XCTAssertEqual(stringSubElement, testArray[index++])
            }
        }
        
        if let jsonSubObject: JSON = jObject["sub_object"] {
            XCTAssertTrue(jsonSubObject["arrayception"].count == 2)
            XCTAssertEqual(jsonSubObject["arrayception"][0][0], "11")
            XCTAssertEqual(jsonSubObject["arrayception"][0][1].string, "22")
            XCTAssertEqual(jsonSubObject["arrayception"][1][0], "33")
            XCTAssertEqual(jsonSubObject["arrayception"][1][1].string, "44")
            
            let testArray = ["11","22","33","44"]
            var index = 0
            
            for jsonElement in jsonSubObject["arrayception"] {
                for jsonSubElement in  jsonElement {
                    XCTAssertEqual(jsonSubElement.string, testArray[index++])
                }
            }
            
            index = 0
            var subArray: [String]? = jsonSubObject["arrayception"][0]
            for string in subArray! {
                XCTAssertEqual(string, testArray[index++])
            }
            subArray = jsonSubObject["arrayception"][1].stringArray
            for string in subArray! {
                XCTAssertEqual(string, testArray[index++])
            }
            
            index = 0
            for jsonElement in jsonSubObject["arrayception"] {
                for jsonSubElement in  jsonElement {
                    XCTAssertEqual(~jsonSubElement, testArray[index++])
                }
            }
            
            index = 0
            for jsonElement in jsonSubObject["arrayception"] {
                for stringSubElement in  jsonElement.stringArray! {
                    XCTAssertEqual(stringSubElement, testArray[index++])
                }
            }
            
            index = 0
            for jsonElement in jsonSubObject["arrayception"].jsonArray! {
                for jsonSubElement in  jsonElement.jsonArray! {
                    XCTAssertEqual(jsonSubElement.string, testArray[index++])
                }
            }
            
            index = 0
            for jsonElement in jsonSubObject["arrayception"].jsonArray! {
                for stringSubElement in  jsonElement.stringArray! {
                    XCTAssertEqual(stringSubElement, testArray[index++])
                }
            }
        }
        
    }
    
    func testArrayJSONObjects() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let jObject = JSON(data: testData)
        
        XCTAssertEqual(jObject["sub_objects"][0]["object_id"], "657567")
        XCTAssertEqual(jObject["sub_objects"][1]["object_id"].string, "7989797")
        
        XCTAssertEqual(jObject["sub_objects"][0]["priority"], 7)
        XCTAssertEqual(jObject["sub_objects"][1]["priority"].integer, 7)
        
        XCTAssertEqual(jObject["sub_objects"][1]["fibonacci"].count, 7)
        XCTAssertEqual(jObject["sub_objects"][0]["fibonacci"][3], 5)
        XCTAssertEqual(jObject["sub_objects"][1]["fibonacci"][4].integer, 8)
        
        let fibonacci = [1,2,3,5,8,13,21]
        var index = 0
        for fibonacciElement in jObject["sub_objects"][1]["fibonacci"] {
            XCTAssertEqual(fibonacciElement.integer, fibonacci[index++])
        }
        
        index = 0
        for fibonacciElement: Int in jObject["sub_objects"][1]["fibonacci"]! {
            XCTAssertEqual(fibonacciElement, fibonacci[index++])
        }
        
        let notIntegerFibo = [1.1,2.2,3.3,5.5,8.8,14.3,23.1]
        index = 0
        for fibonacciElement in jObject["sub_objects"][1]["fibonacci_not_integer"] {
            XCTAssertEqual(fibonacciElement.double, notIntegerFibo[index++])
        }
        
        index = 0
        for fibonacciElement: Double in jObject["sub_objects"][0]["fibonacci_not_integer"]! {
            XCTAssertEqual(fibonacciElement, notIntegerFibo[index++])
        }
        
        XCTAssertEqual(jObject["sub_objects"][0]["boolean_array"][1], true)
        XCTAssertEqual(jObject["sub_objects"][1]["boolean_array"][2].bool, false)
        
        let boolArray = [true, true, false, true, false]
        index = 0
        for arrayElement in jObject["sub_objects"][1]["boolean_array"] {
            XCTAssertEqual(arrayElement.bool, boolArray[index++])
        }
        
        index = 0
        for arrayElement: Bool in jObject["sub_objects"][0]["boolean_array"]! {
            XCTAssertEqual(arrayElement, boolArray[index++])
        }
        
        XCTAssertEqual(jObject["sub_objects"][0]["sub_object"]["creation_date"], "28/10/2013 08:37:18.777")
        XCTAssertEqual(jObject["sub_objects"][1]["sub_object"]["creation_date"].string, "28/10/2013 08:37:18.777")
        
        XCTAssertEqual(jObject["sub_objects"][0]["sub_object"]["related_objects_ids"][0], "32433")
        XCTAssertEqual(jObject["sub_objects"][0]["sub_object"]["comma_array"][2], 22.3)
        XCTAssertEqual(jObject["sub_objects"][1]["sub_object"]["comma_array"][2].double, 22.3)
        
    }
    
    func testEquatableImplementation() {
        let jObject1 = JSON(data: testData)
        let jObject2 = JSON(data: testData)
        
        XCTAssertEqual(jObject1,jObject2)
        XCTAssertNotEqual(jObject1["sub_objects"][0] as JSON,jObject2["sub_objects"][1] as JSON)
        XCTAssertEqual(jObject1["sub_objects"][0]["sub_object"] as JSON,jObject2["sub_objects"][0]["sub_object"] as JSON)
        XCTAssertEqual(jObject1["sub_objects"] as JSON,jObject2["sub_objects"] as JSON)
        
        XCTAssertNotEqual(JSON(data: "{\"key\": \"value_1\"}".dataUsingEncoding(NSUnicodeStringEncoding)!), JSON(data: "{\"key\": \"value_2\"}".dataUsingEncoding(NSUnicodeStringEncoding)!))
        
        XCTAssertEqual(JSON(data: "{\"key\": \"😍❤️😱\"}".dataUsingEncoding(NSUnicodeStringEncoding)!), JSON(data: "{\"key\": \"😍❤️😱\"}".dataUsingEncoding(NSUnicodeStringEncoding)!))
        
        XCTAssertEqual(JSON(data: "{\"key\": 1.0}".dataUsingEncoding(NSUnicodeStringEncoding)!), JSON(data: "{\"key\": 1}".dataUsingEncoding(NSUnicodeStringEncoding)!))
        
        XCTAssertNotEqual(JSON(data: "{\"key\": 1.1}".dataUsingEncoding(NSUnicodeStringEncoding)!), JSON(data: "{\"key\": 1}".dataUsingEncoding(NSUnicodeStringEncoding)!))
        
        XCTAssertEqual(JSON(data: "{\"key\": null}".dataUsingEncoding(NSUnicodeStringEncoding)!), JSON(data: "{\"key\": null}".dataUsingEncoding(NSUnicodeStringEncoding)!))
        
        XCTAssertNotEqual(JSON(data: "{\"key\": 0}".dataUsingEncoding(NSUnicodeStringEncoding)!), JSON(data: "{\"key\": null}".dataUsingEncoding(NSUnicodeStringEncoding)!))
    }
    
    func testRawRepresentable() {
        let jStringObject = JSON(rawValue: "test")
        XCTAssertEqual(jStringObject.rawValue as? String, "test")
        
        let rawData = try? NSJSONSerialization.JSONObjectWithData("{\"key\": \"value_1\"}".dataUsingEncoding(NSUnicodeStringEncoding)!, options:NSJSONReadingOptions.AllowFragments)
        let jRawObj = JSON(rawValue: rawData)
        XCTAssertEqual(JSON(data: "{\"key\": \"value_1\"}".dataUsingEncoding(NSUnicodeStringEncoding)!), jRawObj)
        XCTAssertNotEqual(rawData as? NSDictionary, .None)
        XCTAssertEqual(rawData as? NSDictionary, jRawObj.rawValue as? NSDictionary)
        
    }
    
    func testVariadicSubscripts() {
        let jObject = JSON(data: testData)
        
        XCTAssertEqual(jObject["sub_object", "object_id"], "234234")
        XCTAssertEqual(jObject["sub_object", "object_id"].string, "234234")
        XCTAssertEqual(jObject["sub_object", "object_id"].string, jObject["sub_object"]["object_id"])
        
        XCTAssertEqual(jObject["sub_object", "priority"].integer, 4)
        
        XCTAssertEqual(jObject["sub_object", "priority"], 4.7)
        XCTAssertEqual(jObject["sub_object", "priority"].double, 4.7)
        
        XCTAssertEqual(jObject["sub_object", "is_json"], true)
        XCTAssertEqual(jObject["sub_object", "is_json"].bool, true)
        
        XCTAssertTrue(jObject["sub_object", "related_objects_ids"].count == 4)
        XCTAssertEqual(jObject["sub_object", "related_objects_ids"][0], "32433")
        XCTAssertEqual(jObject["sub_object", "related_objects_ids"][1], "5646")
        
        XCTAssertEqual(jObject["sub_object", "integer_array"][1].integer, 4)
        XCTAssertEqual(jObject["sub_object", "integer_array"][2].integer, 8)
        
        XCTAssertEqual(jObject["sub_objects"][0]["sub_object", "creation_date"], "28/10/2013 08:37:18.777")
        XCTAssertEqual(jObject["sub_objects"][1]["sub_object", "creation_date"].string, "28/10/2013 08:37:18.777")
        
        XCTAssertEqual(jObject["sub_objects"][0]["sub_object", "related_objects_ids"][0], "32433")
        XCTAssertEqual(jObject["sub_objects"][0]["sub_object", "comma_array"][2], 22.3)
        XCTAssertEqual(jObject["sub_objects"][1]["sub_object", "comma_array"][2].double, 22.3)
        
        let testStrArray = ["32433","5646","36463","6799679"]
        var index = 0
        for strElement: String in jObject["sub_object", "related_objects_ids"]! {
            XCTAssertEqual(strElement, testStrArray[index++])
        }
        
        index = 0
        for strElement in jObject["sub_object", "related_objects_ids"].stringArray! {
            XCTAssertEqual(strElement, testStrArray[index++])
        }
        
        index = 0
        for jsonElement in jObject["sub_object", "related_objects_ids"] {
            XCTAssertEqual(jsonElement.string, testStrArray[index++])
        }
        
        let testIntArray = [0,4,8,5,7,13,27,2]
        index = 0
        for intElement: Int in jObject["sub_object", "integer_array"]! {
            XCTAssertEqual(intElement, testIntArray[index++])
        }
        
        index = 0
        for intElement in jObject["sub_object", "integer_array"].integerArray! {
            XCTAssertEqual(intElement, testIntArray[index++])
        }
        
        index = 0
        for jsonElement in jObject["sub_object", "integer_array"] {
            XCTAssertEqual(jsonElement.integer, testIntArray[index++])
        }
        
        let testDoubleArray = [2.1,5.2,22.3,7.5,9.8,141.3,203.1]
        index = 0
        for doubleElement: Double in jObject["sub_object", "comma_array"]! {
            XCTAssertEqual(doubleElement, testDoubleArray[index++])
        }
        
        index = 0
        for doubleElement in jObject["sub_object", "comma_array"].doubleArray! {
            XCTAssertEqual(doubleElement, testDoubleArray[index++])
        }
        
        index = 0
        for jsonElement in jObject["sub_object", "comma_array"] {
            XCTAssertEqual(jsonElement.double, testDoubleArray[index++])
        }
        
        let testBoolArray = [true, true, false, true, false]
        index = 0
        for boolElement: Bool in jObject["sub_object", "boolean_array"]! {
            XCTAssertEqual(boolElement, testBoolArray[index++])
        }
        
        index = 0
        for boolElement in jObject["sub_object", "boolean_array"].boolArray! {
            XCTAssertEqual(boolElement, testBoolArray[index++])
        }
        
        index = 0
        for jsonElement in jObject["sub_object", "boolean_array"] {
            XCTAssertEqual(jsonElement.bool, testBoolArray[index++])
        }
        
        let testArray = ["11","22","33","44"]
        index = 0
        
        for jsonElement in jObject["sub_object", "arrayception"] {
            for jsonSubElement in  jsonElement {
                XCTAssertEqual(jsonSubElement.string, testArray[index++])
            }
        }
        
        index = 0
        var subArray: [String]? = jObject["sub_object", "arrayception"][0]
        for string in subArray! {
            XCTAssertEqual(string, testArray[index++])
        }
        subArray = jObject["sub_object", "arrayception"][1].stringArray
        for string in subArray! {
            XCTAssertEqual(string, testArray[index++])
        }
        
        index = 0
        for jsonElement in jObject["sub_object", "arrayception"] {
            for jsonSubElement in  jsonElement {
                XCTAssertEqual(~jsonSubElement, testArray[index++])
            }
        }
        
        index = 0
        for jsonElement in jObject["sub_object", "arrayception"] {
            for stringSubElement in  jsonElement.stringArray! {
                XCTAssertEqual(stringSubElement, testArray[index++])
            }
        }
        
        index = 0
        for jsonElement in jObject["sub_object", "arrayception"].jsonArray! {
            for jsonSubElement in  jsonElement.jsonArray! {
                XCTAssertEqual(jsonSubElement.string, testArray[index++])
            }
        }
        
        index = 0
        for jsonElement in jObject["sub_object", "arrayception"].jsonArray! {
            for stringSubElement in  jsonElement.stringArray! {
                XCTAssertEqual(stringSubElement, testArray[index++])
            }
        }
    }
    
    func testArraySubscripts() {
        let jObject = JSON(data: testData)
        
        XCTAssertEqual(jObject[["sub_object", "object_id"]], "234234")
        XCTAssertEqual(jObject[["sub_object", "object_id"]].string, "234234")
        XCTAssertEqual(jObject[["sub_object", "object_id"]].string, jObject["sub_object"]["object_id"])
        
        XCTAssertEqual(jObject[["sub_object", "priority"]].integer, 4)
        
        XCTAssertEqual(jObject[["sub_object", "priority"]], 4.7)
        XCTAssertEqual(jObject[["sub_object", "priority"]].double, 4.7)
        
        XCTAssertEqual(jObject[["sub_object", "is_json"]], true)
        XCTAssertEqual(jObject[["sub_object", "is_json"]].bool, true)
        
        XCTAssertTrue(jObject[["sub_object", "related_objects_ids"]].count == 4)
        XCTAssertEqual(jObject[["sub_object", "related_objects_ids"]][0], "32433")
        XCTAssertEqual(jObject[["sub_object", "related_objects_ids"]][1], "5646")
        
        XCTAssertEqual(jObject[["sub_object", "integer_array"]][1].integer, 4)
        XCTAssertEqual(jObject[["sub_object", "integer_array"]][2].integer, 8)
        
        XCTAssertEqual(jObject["sub_objects"][0][["sub_object", "creation_date"]], "28/10/2013 08:37:18.777")
        XCTAssertEqual(jObject["sub_objects"][1][["sub_object", "creation_date"]].string, "28/10/2013 08:37:18.777")
        
        XCTAssertEqual(jObject["sub_objects"][0][["sub_object", "related_objects_ids"]][0], "32433")
        XCTAssertEqual(jObject["sub_objects"][0][["sub_object", "comma_array"]][2], 22.3)
        XCTAssertEqual(jObject["sub_objects"][1][["sub_object", "comma_array"]][2].double, 22.3)
        
        let testStrArray = ["32433","5646","36463","6799679"]
        var index = 0
        for strElement: String in jObject[["sub_object", "related_objects_ids"]]! {
            XCTAssertEqual(strElement, testStrArray[index++])
        }
        
        index = 0
        for strElement in jObject[["sub_object", "related_objects_ids"]].stringArray! {
            XCTAssertEqual(strElement, testStrArray[index++])
        }
        
        index = 0
        for jsonElement in jObject[["sub_object", "related_objects_ids"]] {
            XCTAssertEqual(jsonElement.string, testStrArray[index++])
        }
        
        let testIntArray = [0,4,8,5,7,13,27,2]
        index = 0
        for intElement: Int in jObject[["sub_object", "integer_array"]]! {
            XCTAssertEqual(intElement, testIntArray[index++])
        }
        
        index = 0
        for intElement in jObject[["sub_object", "integer_array"]].integerArray! {
            XCTAssertEqual(intElement, testIntArray[index++])
        }
        
        index = 0
        for jsonElement in jObject[["sub_object", "integer_array"]] {
            XCTAssertEqual(jsonElement.integer, testIntArray[index++])
        }
        
        let testDoubleArray = [2.1,5.2,22.3,7.5,9.8,141.3,203.1]
        index = 0
        for doubleElement: Double in jObject[["sub_object", "comma_array"]]! {
            XCTAssertEqual(doubleElement, testDoubleArray[index++])
        }
        
        index = 0
        for doubleElement in jObject[["sub_object", "comma_array"]].doubleArray! {
            XCTAssertEqual(doubleElement, testDoubleArray[index++])
        }
        
        index = 0
        for jsonElement in jObject[["sub_object", "comma_array"]] {
            XCTAssertEqual(jsonElement.double, testDoubleArray[index++])
        }
        
        let testBoolArray = [true, true, false, true, false]
        index = 0
        for boolElement: Bool in jObject[["sub_object", "boolean_array"]]! {
            XCTAssertEqual(boolElement, testBoolArray[index++])
        }
        
        index = 0
        for boolElement in jObject[["sub_object", "boolean_array"]].boolArray! {
            XCTAssertEqual(boolElement, testBoolArray[index++])
        }
        
        index = 0
        for jsonElement in jObject[["sub_object", "boolean_array"]] {
            XCTAssertEqual(jsonElement.bool, testBoolArray[index++])
        }
        
        let testArray = ["11","22","33","44"]
        index = 0
        
        for jsonElement in jObject[["sub_object", "arrayception"]] {
            for jsonSubElement in  jsonElement {
                XCTAssertEqual(jsonSubElement.string, testArray[index++])
            }
        }
        
        index = 0
        var subArray: [String]? = jObject[["sub_object", "arrayception"]][0]
        for string in subArray! {
            XCTAssertEqual(string, testArray[index++])
        }
        subArray = jObject[["sub_object", "arrayception"]][1].stringArray
        for string in subArray! {
            XCTAssertEqual(string, testArray[index++])
        }
        
        index = 0
        for jsonElement in jObject[["sub_object", "arrayception"]] {
            for jsonSubElement in  jsonElement {
                XCTAssertEqual(~jsonSubElement, testArray[index++])
            }
        }
        
        index = 0
        for jsonElement in jObject[["sub_object", "arrayception"]] {
            for stringSubElement in  jsonElement.stringArray! {
                XCTAssertEqual(stringSubElement, testArray[index++])
            }
        }
        
        index = 0
        for jsonElement in jObject[["sub_object", "arrayception"]].jsonArray! {
            for jsonSubElement in  jsonElement.jsonArray! {
                XCTAssertEqual(jsonSubElement.string, testArray[index++])
            }
        }
        
        index = 0
        for jsonElement in jObject[["sub_object", "arrayception"]].jsonArray! {
            for stringSubElement in  jsonElement.stringArray! {
                XCTAssertEqual(stringSubElement, testArray[index++])
            }
        }
    }
    
    func testEmptyKeyPath() {
        let jObject = JSON(data: testData)
        
        let emptyArray = [String]()
        XCTAssertEqual(jObject[emptyArray], jObject)
        XCTAssertEqual(jObject[emptyArray]["sub_object"]["object_id"], "234234")
        XCTAssertEqual(jObject[emptyArray]["sub_object"]["object_id"].string, "234234")
        XCTAssertEqual(jObject[emptyArray]["sub_object"]["object_id"].string, jObject["sub_object"]["object_id"])
    }
    
}
