import json

with open('terraform.tfstate') as f:
    state = json.load(f)

for resource in state['resources']:
    resource_name = ""
    resource_id = ""

    if resource['mode'] == 'managed':
        is_module = resource.get('module')
        if is_module:
            resource_name = resource.get('module') + '.' + resource['type'] + '.' + resource['name']
        else:
            resource_name = resource['type'] + '.' + resource['name']

    resource_type = resource['type']
    for instance in resource['instances']:
        if resource_type == 'cloudflare_record':
            instance_id = instance['attributes']['id']
            instance_zone_id = instance['attributes'].get('zone_id')

            resource_id = f'{instance_zone_id}/{instance_id}'
        elif resource_type == 'cloudflare_api_token':
            resource_id = instance['attributes']['id']
        elif resource_type == 'cloudflare_page_rule':
            instance_id = instance['attributes']['id']
            instance_zone_id = instance['attributes'].get('zone_id')

            resource_id = f'{instance_zone_id}/{instance_id}'
        elif resource_type == 'cloudflare_r2_bucket':
            account = instance['attributes']['account_id']
            id = instance['attributes'].get('id')
            location = instance['attributes'].get('location')

            resource_id = f'{account}/{id}/{location}'

        elif resource_type == 'cloudflare_pages_domain':
            account = instance['attributes']['account_id']
            project_name = instance['attributes'].get('project_name')
            domain = instance['attributes'].get('domain')

            resource_id = f'{account}/{project_name}/{domain}'
        elif resource_type == 'cloudflare_pages_project':
            account = instance['attributes']['account_id']
            project_name = instance['attributes'].get('id')

            resource_id = f'{account}/{project_name}'
        if instance.get('index_key'):
            resource_name_loop = resource_name + '["' + instance['index_key'] + '"]'
            print(f"tf import '{resource_name_loop}' {resource_id}")
        else:
            print(f"tf import '{resource_name}' {resource_id}")
print('----')
