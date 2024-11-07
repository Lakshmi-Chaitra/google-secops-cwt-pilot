# Service Account Configuration
service_account_name = "cwt"                     # Name of the Service Account
namespace            = "default"                   # Namespace for the Service Account
role_name            = "cwt-role"                  # Role name to be created
role_binding_name    = "cwt-role-binding"          # Role Binding name to be created
resources            = ["pods"]                    # List of resources the role can access
verbs                = ["get", "list", "watch"]    # List of allowed verbs

# Additional configurations (if needed)
# region               = "us-central1"               # Example: Specify a region
# cluster_name         = "my-cluster"                # Example: Name of your GKE cluster
