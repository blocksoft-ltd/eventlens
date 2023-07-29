USER = root
HOST = 88.203.214.85
DIR = /var/www/eventlens

setup:
	ssh $(USER)@$(HOST) 'bash -s' < scrips/setup.sh

login:
	ssh $(USER)@$(HOST)

deploy:
	#git push origin main
	ssh $(USER)@$(HOST) 'cd $(DIR) && git pull && npm install && npm run build && pm2 restart eventlens'

rollback:
	ssh $(USER)@$(HOST) 'cd $(DIR) && git reset --hard HEAD~1 && npm install && npm run build && pm2 restart eventlens'

.PHONY: deploy rollback login
