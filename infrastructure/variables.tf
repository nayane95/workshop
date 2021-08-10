variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "ssh_public_key" {
#  default = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAgEAugvIwq3phj/1Y8338dEAlY/Q06j+S4+7ABtVYG+r+uGiuJ/qvFwHa0VFiDOec27UGYvBRgodkxqUNV9kNWojlEceiAnoklMxNC/0LQ84R0FaosNua0Y2urkI8sqZLhb55lCo/f9dWZqVA+vBhmTfN2Vw2rrYV1EAondUqKgRgMizV8xRmCktB5/2A60E55Olz/RTZgtiHfQImTV2N35+XWODhwCtZMOcY0Z+HcBV3W+GdS9KRfKZhimi7tYpagGIJfgi2a0UIsjHe811x6U5MmCZ9DgCES0KUTBvla1q9wABZJ6gpEfPtt+O5b9Ob9xv9OYGqtzSmGDDLTL260P0FYcjTbcVLVSEy7ls67DpAf28NcHH9ZL3cAGy0h7M1BP6ZaiP0GwEgvMmQ4sDS/2BJdAW6MdIkSLglJT1CZA39bCUS6XzUa5s7bAGtMN3uYayrA5tgylh9Pd4qpctCnPVUTnLrNDGIbApzuX3DqW2bC/+l4rlqPXI5AFz9CVDDgL2nyYOy31Cph1FeeO8dYtP11ave3gTfegJNV6jxsadYAA22ev0nNWi3UXB4Bz0ERcHk9Rzbe0e8eiok+22FNyhH9S+L3FUWO/Vc2ERQVManJVH9jvPZRE+7RC3j5Hv4RWTz8Crtfm5NbOlgWWcv4MfjgVAmN2upGxUCGWfBsARGrs= magnus.fagertun@gmail.com"
}

provider "oci" {
  tenancy_ocid = "${var.tenancy_ocid}"
  user_ocid = "${var.user_ocid}"
  fingerprint = "${var.fingerprint}"
 private_key_path = "${var.private_key_path}"
}

variable "VPC-CIDR" {
  default = "172.16.0.0/16"
}

variable "Oracle-Linux-7_3" {
  default = "ocid1.image.oc1.phx.aaaaaaaaifdnkw5d7xvmwfsfw2rpjpxe56viepslmmisuyy64t3q4aiquema"
}
