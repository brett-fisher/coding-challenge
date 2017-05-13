// The GroupObject class is what will be used to hold features sets.
// It has an array to contain feature sets and a probability property.
class GroupObject {
    var featureSet: [String] = []
    var probability: Int
    
    init(prob: Int, featSet: [String]) {
        self.probability = prob
        self.featureSet = featSet
    }
}

// The Customer class will represent the clients of Recruiting Madness.
// It has a name and an empty array that will be filled randomly with a feature set.
class Customer {
    var name: String
    var featureSet: [String] = []
    
    init(name: String) {
        self.name = name
    }
}

// The groups array holds GroupObject's.
// I added four feature sets and a corresponding probabily number
// groups[0] represents Group 1, groups[1] represents Group 2, and so forth.
var groups: [GroupObject] = []
groups.append(GroupObject.init(prob: 1, featSet: ["a", "b"]))
groups.append(GroupObject.init(prob: 2, featSet: ["b", "c"]))
groups.append(GroupObject.init(prob: 2, featSet: ["c"]))
groups.append(GroupObject.init(prob: 5, featSet: ["a", "c", "d"]))


// The customers array holds the list of Recruiting Madness's customers.
var customers: [Customer] = []
customers.append(Customer.init(name: "Widget Co"))
customers.append(Customer.init(name: "Synergy Inc"))
customers.append(Customer.init(name: "Elevation Executives"))
customers.append(Customer.init(name: "Momentum Partners"))


// The probabilities array will hold a set of numbers to represent the likelihood of being assigned a feature set.
var probabilities: [Int] = []


// This bit of code fills the probabilities array with 0's, 1's, 2's, and 3's
// Once filled, it will look like this:  [0, 1, 1, 2, 2, 3, 3, 3, 3, 3]
// 0 = 10%, 1 = 20%, 2 = 20%, 3 = 50% of the array
// A certain number gets put in the array based on the probability number for each Feature Group.
repeat {
    probabilities.append(0)
} while probabilities.count < groups[0].probability

repeat {
    probabilities.append(1)
} while probabilities.count < groups[0].probability + groups[1].probability

repeat {
    probabilities.append(2)
} while probabilities.count < groups[0].probability + groups[1].probability + groups[2].probability
repeat {
    probabilities.append(3)
} while probabilities.count < groups[0].probability + groups[1].probability + groups[2].probability + groups[3].probability


// This function returns a random index.
// This will be used to randomly select something from the probabilities array.
func returnRandomIndex(array: [Int]) -> Int{
    let randomIndex = arc4random_uniform(UInt32(array.count))
    return Int(randomIndex)
}


// This function takes a customers array to be filled based on the feature set probabilities.
// It will randomly select a 0, 1, 2, or 3 from the probabilities array.
func assignFeatures(cust: [Customer]) {
    for item in customers {
        let index = returnRandomIndex(array: probabilities)
        if probabilities[index] == 0 {
            item.featureSet.append(contentsOf: groups[0].featureSet)
        } else if probabilities[index] == 1 {
            item.featureSet.append(contentsOf: groups[1].featureSet)
        } else if probabilities[index] == 2 {
            item.featureSet.append(contentsOf: groups[2].featureSet)
        } else if probabilities[index] == 3 {
            item.featureSet.append(contentsOf: groups[3].featureSet)
        }
    }
}


// This takes an array of customers and an array of group objects.
// It checks to see if a customer has a certain feature set.
func checkFeatures(cust: [Customer], feature: [GroupObject]) -> Bool {
    
    if cust[0].featureSet == feature[0].featureSet {
        print("DOES HAVE FEATURE")
        return true
    } else {
        print("DOES NOT HAVE FEATURE")
        return false
    }
    
}


// Assign features randomly into the 'customers' array created on line 38.
assignFeatures(cust: customers)


// Print out the results.
print("Widget Co has been assigned feature(s) \(customers[0].featureSet)")
print("Synergy Inc has been assigned feature(s) \(customers[1].featureSet)")
print("Elevation Executives has been assigned feature(s) \(customers[2].featureSet)")
print("Momentum Partners has been assigned feature(s) \(customers[3].featureSet)")


// Check if a customer has a feature.
// The current implementation reads like this: "Does Momentum Partners have access to features 'a' and 'b'?"
// If you want to change the customer and / or feature set, change either array index with a 0, 1, 2, or 3
checkFeatures(cust: [customers[3]], feature: [groups[0]])
