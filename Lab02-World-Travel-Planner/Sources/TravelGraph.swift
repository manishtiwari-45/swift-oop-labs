import Foundation

final class TravelGraph {

    private var adjacencyList:
        [City: [City]] = [:]

    func addCity(_ city: City) {

        if adjacencyList[city] == nil {

            adjacencyList[city] = []
        }
    }

    func addConnection(
        from city1: City,
        to city2: City
    ) {

        adjacencyList[city1, default: []]
            .append(city2)

        adjacencyList[city2, default: []]
            .append(city1)
    }
}