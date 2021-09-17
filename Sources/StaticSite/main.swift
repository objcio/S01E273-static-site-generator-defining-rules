import HTML

struct MySite: Rule {
    var body: some Rule {
        Write(contents: html {
            HTML.body {
                h1 { "Hello, World!" }
            }
        }, to: "index.html")
    }
}

MySite().execute()
