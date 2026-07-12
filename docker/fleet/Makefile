list-inventory:
	ansible-inventory -i inventory.yml --list
compose-ugrade-nuc:
	ansible-playbook -i inventory.yml playbooks/compose-upgrade.yml -e host=nuc
compose-ugrade-emmental:
	ansible-playbook -i inventory.yml playbooks/compose-upgrade.yml -e host=emmental
compose-ugrade-argon:
	ansible-playbook -i inventory.yml playbooks/compose-upgrade.yml -e host=argon

compose-ugrade-gcp-lab:
	ansible-playbook -i inventory.yml playbooks/compose-upgrade.yml -e host=gcp-lab
compose-ugrade-oracle-lab:
	ansible-playbook -i inventory.yml playbooks/compose-upgrade.yml -e host=oracle-lab
compose-ugrade-oracle-lab2:
	ansible-playbook -i inventory.yml playbooks/compose-upgrade.yml -e host=oracle-lab2

hello-world:
	ansible-playbook -i inventory.yml playbooks/hello-world.yml
