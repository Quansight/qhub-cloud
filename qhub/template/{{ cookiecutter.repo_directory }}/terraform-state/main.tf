{% if cookiecutter.provider == "aws" -%}
provider "aws" {
  region = "{{ cookiecutter.amazon_web_services.region }}"
}

module "terraform-state" {
  source = "./aws/terraform-state"

  name = "{{ cookiecutter.project_name }}-{{ cookiecutter.namespace }}"

  tags = {
    Organization = "{{ cookiecutter.project_name }}"
    Project      = "terraform-state"
    Environment  = "{{ cookiecutter.namespace }}"
  }
}
{% elif cookiecutter.provider == "gcp" -%}
provider "google" {
  project = "{{ cookiecutter.google_cloud_platform.project }}"
  region  = "{{ cookiecutter.google_cloud_platform.region }}"
  zone    = "{{ cookiecutter.google_cloud_platform.zone }}"
}

module "terraform-state" {
  source = "./gcp/terraform-state"

  name     = "{{ cookiecutter.project_name }}-{{ cookiecutter.namespace }}"
  location = "{{ cookiecutter.google_cloud_platform.region }}"
}
{% elif cookiecutter.provider == "azure" -%}
provider "azurerm" {
  features {}
}

module "terraform-state" {
  source = "./azure/terraform-state"

  resource_group_name     = "{{ cookiecutter.project_name }}-{{ cookiecutter.namespace }}"
  location                = "{{ cookiecutter.azure.region }}"
  storage_account_postfix = "{{ cookiecutter.azure.storage_account_postfix }}"
}
{% elif cookiecutter.provider == "do" -%}
module "terraform-state" {
  source = "./digitalocean/terraform-state"

  name   = "{{ cookiecutter.project_name }}-{{ cookiecutter.namespace }}"
  region = "{{ cookiecutter.digital_ocean.region }}"
}
{% endif %}
