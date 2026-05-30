import Foundation

final class City: Hashable {

    let name: String
    let country: String
    let timezone: String

    init(
        name: String,
        country: String,
        timezone: String
    ) {

        guard !name.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty else {

            throw CityError.invalidInput(
                "City name cannot be empty"
            )
        }

        guard !country.isEmpty else {

            throw CityError.invalidInput(
                "Country cannot be empty"
            )
        }

        guard !timezone.isEmpty else {

            throw CityError.invalidInput(
                "Timezone cannot be empty"
            )
        }

        self.name = name
        self.country = country
        self.timezone = timezone
    }

    static func == (
        lhs: City,
        rhs: City
    ) -> Bool {

        lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {

        hasher.combine(name)
    }
}

extension City: CustomStringConvertible {

    var description: String {

        return """
        City{name='\(name)', country='\(country)', timezone='\(timezone)'}
        """
    }
}

enum CityError: Error {

    case invalidInput(String)
}

extension CityError: LocalizedError {

    var errorDescription: String? {

        switch self {

        case .invalidInput(let message):
            return message
        }
    }
}

func findPath(
    from start: City,
    to destination: City
) throws -> [City] {

    guard adjacencyList[start] != nil else {

        throw GraphError.cityNotFound(
            start.name
        )
    }

    guard adjacencyList[destination] != nil else {

        throw GraphError.cityNotFound(
            destination.name
        )
    }

    var visited = Set<City>()

    var parent:
        [City: City] = [:]

    var stack: [City] = []

    stack.append(start)
    visited.insert(start)

    while !stack.isEmpty {

        let current =
            stack.removeLast()

        if current == destination {

            return reconstructPath(
                parent: parent,
                destination: destination
            )
        }

        for neighbor in adjacencyList[current] ?? [] {

            if !visited.contains(neighbor) {

                visited.insert(neighbor)

                parent[neighbor] =
                    current

                stack.append(neighbor)
            }
        }
    }

    return []
}

private func reconstructPath(
    parent: [City: City],
    destination: City
) -> [City] {

    var path: [City] = []

    var current: City? =
        destination

    while current != nil {

        path.append(current!)

        current =
            parent[current!]
    }

    return path.reversed()
}
enum GraphError: Error {

    case cityNotFound(String)
}

extension GraphError:
    LocalizedError {

    var errorDescription: String? {

        switch self {

        case .cityNotFound(let city):

            return "\(city) not found in graph"
        }
    }
}