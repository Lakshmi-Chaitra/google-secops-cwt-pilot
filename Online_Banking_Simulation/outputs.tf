output "vpc_cloud_run_id" {
  value = module.vpc_cloud_run.network_id
}

output "vpc_gke_pd_id" {
  value = module.vpc_gke_pd.network_id
}

output "vpc_bt_sql_id" {
  value = module.vpc_bt_sql.network_id
}

#output "cwt_ml_namespaces" {
#  value = { for ns_key, ns in module.vpc_gke_pd.cwt_ml : ns_key => ns.metadata[0].name }
#}
