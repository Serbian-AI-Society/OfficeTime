# RE:Searcher UI
Flutter project.

## Building for deployment 

1. Build web version of Flutter
`flutter build web --release`

2. Move web folder to `express/`

3. Build with Docker
`docker build --platform linux/amd64 -t researcher_ui .`
