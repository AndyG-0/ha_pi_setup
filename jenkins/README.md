# Jenkins Install Notes

Reference: [https://pimylifeup.com/jenkins-raspberry-pi/](https://pimylifeup.com/jenkins-raspberry-pi/)

After install:
1. add `Docker pipeline` plugin
1. Configure Github login credential
1. Add jenkins user to docker: `sudo usermod -aG docker jenkins` Restart Jenkins using systemctl not the web ui.

If Jenkins requires moving files using scp, passwordless ssh should be setup. See: [https://linuxize.com/post/how-to-setup-passwordless-ssh-login/](https://linuxize.com/post/how-to-setup-passwordless-ssh-login/)