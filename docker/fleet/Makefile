list-inventory:
	ansible-inventory -i inventory.yml --list
compose-ugrade-nuc:
	ansible-playbook  -i inventory.yml playbooks/compose-upgrade.yml -e host=nuc
compose-ugrade-emmental:
	ansible-playbook  -i inventory.yml playbooks/compose-upgrade.yml -e host=emmental
compose-ugrade-argon:
	ansible-playbook  -i inventory.yml playbooks/compose-upgrade.yml -e host=argon

hello-world:
	ansible-playbook -i inventory.yml playbooks/hello-world.yml
