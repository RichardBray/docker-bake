group "default" {
  targets = ["webapp", "api"]
}

# target "_common" {
#   context = "."
#   platforms = ["linux/amd64", "linux/arm64"]
# }

target "webapp" {
  context = "."
  dockerfile = "Dockerfile"
  tags = ["bunapp:latest", "bunapp:1.0"]
  labels = {
    "org.label-schema.name" = "bunapp"
    "org.label-schema.version" = "1.0"
  }
  platforms = ["linux/amd64", "linux/arm64"]
}

target "api" {
  context = "."
  dockerfile = "api.Dockerfile"
  tags = ["goapp:latest", "goapp:1.0"]
  platforms = ["linux/amd64", "linux/arm64"]
}

# target "tests" {
#   dockerfile = "tests.Dockerfile"
#   contexts = {
#     webapp = "target:webapp",
#     api = "target:api",
#   }
#   output = ["type=local,dest=build/tests"]
#   context = "."
# }