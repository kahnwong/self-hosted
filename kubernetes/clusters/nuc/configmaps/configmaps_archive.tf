# # evcc
# data "sops_file" "evcc" {
#   source_file = "${path.module}/configmaps/evcc.sops.yaml"
# }
# resource "kubernetes_config_map" "evcc" {
#   metadata {
#     name      = "evcc"
#     namespace = "tools"
#   }
#
#   data = {
#     "evcc.yaml" = data.sops_file.evcc.raw
#   }
#
#   depends_on = [data.sops_file.evcc]
# }


# livegrep
# data "sops_file" "livegrep-ignorelist" {
#   source_file = "${path.module}/configmaps/livegrep.ignorelist.sops.txt"
#   input_type  = "raw"
# }
# resource "kubernetes_config_map" "livegrep-ignorelist" {
#   metadata {
#     name      = "livegrep-ignorelist"
#     namespace = "tools"
#   }
#
#   data = {
#     "ignorelist.txt" = data.sops_file.livegrep-ignorelist.raw
#   }
#
#   depends_on = [data.sops_file.livegrep-ignorelist]
# }
