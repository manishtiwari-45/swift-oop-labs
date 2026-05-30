import Foundation

do {

    let newYork =
        try City(
            name: "New York",
            country: "USA",
            timezone: "EDT"
        )

    let london =
        try City(
            name: "London",
            country: "UK",
            timezone: "GMT"
        )

    let paris =
        try City(
            name: "Paris",
            country: "France",
            timezone: "CET"
        )

    let tokyo =
        try City(
            name: "Tokyo",
            country: "Japan",
            timezone: "JST"
        )

    let singapore =
        try City(
            name: "Singapore",
            country: "Singapore",
            timezone: "SGT"
        )

    let dubai =
        try City(
            name: "Dubai",
            country: "UAE",
            timezone: "GST"
        )

    let sydney =
        try City(
            name: "Sydney",
            country: "Australia",
            timezone: "AEST"
        )

    let delhi =
        try City(
            name: "Delhi",
            country: "India",
            timezone: "IST"
        )

    let graph = TravelGraph()

    [
        newYork,
        london,
        paris,
        tokyo,
        singapore,
        dubai,
        sydney,
        delhi
    ].forEach {

        graph.addCity($0)
    }

    graph.addConnection(
        from: newYork,
        to: london
    )

    graph.addConnection(
        from: london,
        to: paris
    )

    graph.addConnection(
        from: newYork,
        to: tokyo
    )

    graph.addConnection(
        from: tokyo,
        to: singapore
    )

    graph.addConnection(
        from: singapore,
        to: dubai
    )

    graph.addConnection(
        from: dubai,
        to: delhi
    )

    graph.addConnection(
        from: delhi,
        to: sydney
    )

    let path =
        try graph.findPath(
            from: newYork,
            to: dubai
        )

    print("Travel Route:")

    print(
        path.map { $0.name }
            .joined(separator: " → ")
    )

} catch {

    print(error.localizedDescription)
}