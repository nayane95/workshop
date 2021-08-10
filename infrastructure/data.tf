data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}

data "oci_core_vnic_attachments" "webserver_vnics" {
compartment_id = "${var.compartment_ocid}"
availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
instance_id = "${oci_core_instance.TF_webserver.id}"
}

data "oci_core_vnic" "webserver_vnic" {
vnic_id = "${lookup(data.oci_core_vnic_attachments.webserver_vnics.vnic_attachments[0],"vnic_id")}"
}

output "webserver_public_ip" {
value = ["${data.oci_core_vnic.webserver_vnic.public_ip_address}"]
}

output "webserver_private_ip" {
value = ["${data.oci_core_vnic.webserver_vnic.private_ip_address}"]
}


data "oci_core_vnic_attachments" "dbserver_vnics" {
compartment_id = "${var.compartment_ocid}"
availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
instance_id = "${oci_core_instance.TF_dbserver.id}"
}

data "oci_core_vnic" "dbserver_vnic" {
vnic_id = "${lookup(data.oci_core_vnic_attachments.dbserver_vnics.vnic_attachments[0],"vnic_id")}"
}

output "dbserver_public_ip" {
value = ["${data.oci_core_vnic.dbserver_vnic.public_ip_address}"]
}

output "dbserver_private_ip" {
value = ["${data.oci_core_vnic.dbserver_vnic.private_ip_address}"]
}

