@test "Testing Jenkins UI is accessible" {
  curl --retry 48 --retry-delay 10 gke-tom-jenkins:8080/login
}