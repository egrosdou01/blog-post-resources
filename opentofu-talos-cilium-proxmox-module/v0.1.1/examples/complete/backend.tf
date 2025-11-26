terraform {
  backend "http" {
    skip_cert_verification = true
  }
}