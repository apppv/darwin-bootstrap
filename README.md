# Darwin Bootstrap

## Ansible playbook for macOS setup


1. Install the required dependencies using the bash script
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/apppv/darwin-bootstrap/refs/heads/main/darwin-prerequisites.sh)
```
2. Install requirements for the playbook
```bash
ansible-galaxy install -r requirements.yml
```

3. Run the playbook to setup macOS
```bash
ansible-playbook --ask-become-pass playbook.yml
```

4. Install all recommended macOS updates
```bash
softwareupdate -i -a
```
