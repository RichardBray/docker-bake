group "default" {
  targets = ["webapp", "api"]
}

variable "VERSION" {
  default = "1.0"
}

function "tags" {
  params = [project]
  result = ["${project}:latest", "${project}:${VERSION}"]
}

target "_common" {
  context = "."
  platforms = ["linux/amd64", "linux/arm64"]
}

target "webapp" {
  inherits = ["_common"]
  dockerfile = "Dockerfile"
  tags = tags("bunapp")
  labels = {
    "org.label-schema.name" = "bunapp"
    "org.label-schema.version" = "${VERSION}"
  }
}

target "api" {
  inherits = ["_common"]
  dockerfile = "api.Dockerfile"
  tags = tags("goapp")
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