#======================= setup module ============================#
# Display facts from all hosts and store them indexed by I(hostname) at C(/tmp/facts).
ansible all -m setup --tree /tmp/facts

# Display only facts regarding memory found by ansible on all hosts and output them.
ansible all -m setup -a 'filter=ansible_*_mb'

# Display only facts returned by facter.
ansible all -m setup -a 'filter=facter_*'

# Display only facts about certain interfaces.
ansible all -m setup -a 'filter=ansible_eth[0-2]'

# Restrict additional gathered facts to network and virtual.
ansible all -m setup -a 'gather_subset=network,virtual'

# Do not call puppet facter or ohai even if present.
ansible all -m setup -a 'gather_subset=!facter,!ohai'

# Only collect the minimum amount of facts:
ansible all -m setup -a 'gather_subset=!all'

# Display facts from Windows hosts with custom facts stored in C(C:\custom_facts).
ansible windows -m setup -a "fact_path='c:\custom_facts'"


#======================= File module ===========================#
# Create file on the remote host
ansible all -m file -a 'path=/tmp/test state=touch' -o

# Modify the permission of the file
ansible all -m file -a 'path=/tmp/test state=file mode=600' -o


#======================= Copy module ==========================#
# To copy file from controller to remote hosts
ansible all -m copy -a 'src=/tmp/x dest=/tmp/x' -o

# To copy file within the remote host
ansible all -m copy -a 'remote_src=yes src=/tmp/x dest=/tmp/y' -o

#======================= Command module =======================#
# Command module is a default module for ansible so no need to specify it separately
# To get the hostname
ansible all -a 'hostname' -o

#This will create the file if it is not there, if it there command will simply skip as we are mentions a conditional check ‘creates=/tmp/test1’
ansible all -a 'touch /tmp/test creates=/tmp/test'

#This will delete the file if it is not there, if it there command will simply skip as we are mentions a conditional check ‘removes=/tmp/test1’
ansible all -a 'rm /tmp/test1 removes=/tmp/test1'

#====================== Fetch Module ==========================#
# To download the files from remote hosts to controller machine.
ansible all -m fetch -a 'src=/tmp/test_modules.txt dest=/tmp/' -o
