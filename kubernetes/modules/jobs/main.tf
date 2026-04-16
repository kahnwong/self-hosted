locals {
  jobs_map_raw = flatten([
    for namespace, jobs in var.jobs : [
      for job in jobs : {
        job       = job
        namespace = namespace
      }
    ]
  ])
  jobs_map = { for index, v in local.jobs_map_raw : v.job => v.namespace }
}

resource "helm_release" "this" {
  for_each   = local.jobs_map
  name       = each.key
  namespace  = each.value
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = var.chart_version
  chart      = var.chart_name

  values = [
    for path in concat(["${path.module}/../../specs/jobs/${each.value}/${each.key}.yaml"], var.values_extras) :
    file(path)
  ]
}
