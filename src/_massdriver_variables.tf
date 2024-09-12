// Auto-generated variable declarations from massdriver.yaml
variable "cloud_function_configuration" {
  type = object({
    entrypoint        = string
    maximum_instances = number
    memory_mb         = number
    minimum_instances = number
    runtime           = string
  })
}
variable "gcp_authentication" {
  type = object({
    data = object({
      auth_provider_x509_cert_url = string
      auth_uri                    = string
      client_email                = string
      client_id                   = string
      client_x509_cert_url        = string
      private_key                 = string
      private_key_id              = string
      project_id                  = string
      token_uri                   = string
      type                        = string
    })
    specs = object({
      gcp = optional(object({
        project = optional(string)
        region  = optional(string)
      }))
    })
  })
}
variable "md_metadata" {
  type = object({
    default_tags = object({
      managed-by  = string
      md-manifest = string
      md-package  = string
      md-project  = string
      md-target   = string
    })
    deployment = object({
      id = string
    })
    name_prefix = string
    observability = object({
      alarm_webhook_url = string
    })
    package = object({
      created_at             = string
      deployment_enqueued_at = string
      previous_status        = string
      updated_at             = string
    })
    target = object({
      contact_email = string
    })
  })
}
variable "subnetwork" {
  type = object({
    data = object({
      infrastructure = object({
        cidr                   = string
        gcp_global_network_grn = string
        grn                    = string
        vpc_access_connector   = string
      })
    })
    specs = object({
      gcp = optional(object({
        project = optional(string)
        region  = optional(string)
      }))
    })
  })
}
variable "topic" {
  type = object({
    data = object({
      infrastructure = object({
        grn = string
      })
      security = object({
        iam = optional(map(object({
          condition = string
          role      = any
        })))
      })
    })
    specs = object({
      topic = optional(object({
        distribution = string
      }))
    })
  })
}
