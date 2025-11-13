import requests

r = requests.get("http://192.168.1.36:30054/model/allocation/compute?window=7d&aggregate=cluster&includeIdle=true&step=1d&accumulate=true").json()

# ref: <https://github.com/opencost/opencost/blob/develop/pkg/carbon/carbonassets.go#L150>
# GCP,average-region,,Node,0.1255365298907703,3.99835814947191e-05
# GCP,average-region,,Disk,9.254108590539544e-16,2.986563254601511e-19
# GCP,average-region,,Network,3.6880373954772945e-09,1.1902342466770815e-12

minutes = r['data'][0]['default-cluster']['minutes']
carbon_node = minutes * 3.99835814947191e-05 / 60
carbon_disk = minutes * 2.986563254601511e-19 / 60
carbon_network = minutes * 1.1902342466770815e-12 / 60

carboncost = carbon_node + carbon_disk + carbon_network

print(f"Compute Minutes: {minutes}")
print(f"Carbon Cost: {carboncost:.5f} KG CO2E")
