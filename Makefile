all: cidata.iso
	@runmany 'echo $$1; jq . <$$1 >/dev/null' *.json

cidata.iso: cidata/user-data cidata/meta-data
	mkisofs -R -V cidata -o $@.tmp cidata
	mv $@.tmp $@

cidata/meta-data: cidata/user-data
	@mkdir -p cidata
	@echo --- | tee $@.tmp
	@echo instance-id: p-$(shell date +%s) | tee -a $@.tmp
	mv $@.tmp $@

cidata/user-data: cidata/user-data.template .ssh/ssh-container
	@cat "$<" | env CONTAINER_SSH_KEY="$(shell cat .ssh/ssh-container.pub)" envsubst '$$USER $$CONTAINER_SSH_KEY $$CACHE_VIP' | tee "$@.tmp"
	mv "$@.tmp" "$@"

.ssh/ssh-container:
	@mkdir -p $(shell dirname $@)
	@ssh-keygen -f $@ -P '' -C "packer@$(shell uname -n)"

key: .ssh/ssh-container
	@aws ec2 import-key-pair --key-name vagrant-$(shell md5 -q .ssh/ssh-container.pub) --public-key-material "$(shell cat .ssh/ssh-container.pub)"
