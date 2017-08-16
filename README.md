# encrypted-apticron
This version replaces the original [`apticron`](https://tracker.debian.org/pkg/apticron). It's purpose is to encrypt the outgoing emails using [`gpg`](https://www.gnupg.org/) before sending them. Besides the encryption this fork is as close to the original `apticron` as possible. It was forked from `git://git.debian.org/git/collab-maint/apticron.git`.

**On the origin of the idea for this project:** Intercepting emails send by `apticron` would possibly provide very valuable information for an attacker of a system.
Since she/he would then know which packages on a system are in need for a (security) update and possibly could use this information to target those vulnerabilities.

## Install

It is recommended that you first install the `apticron` version provided by your distribution.
This will initially prompt you to configure `apticron` like you need it.
**Afterwards** use the `./install` script of this repository to replace the original `apticron` version with this version.

Be aware that this `apticron` version assumes that you have `gpg` installed and configured properly (i.e. that you have your own private key available and the public key of your `apticron` mail recipient imported).

## Usage

This version automatically will identify the public key to be used for encrypting by the email address given in the standard `apticron.conf` and will try to sign the sended message using your own private key. You can provide your passphrase for signing as environment variable.

Example `crontable` entries could look like this:

```bash
GPG_PASS_PHRASE="your passphrase here"
0  5  *  *  *  [ -x /usr/sbin/apticron ] && /usr/sbin/apticron
```
The private key of the user this `crontable` belongs to will be used to sign the message. If your private key is not protected by a passphrase you don't need to set that environment variable (but using unprotected private keys is not recommended, as you might already be aware of :stuck_out_tongue_winking_eye:).

The default is that `apticron` is run as defined in `/etc/cron.d/apticron` which should look like
```bash
# cron entry for apticron

4 * * * * root if test -x /usr/sbin/apticron; then /usr/sbin/apticron --cron; else true; fi
```

This results in the private key of the `root` user being used to sign the message.
Accordingly you can provide the corresponding passphrase like

```bash
# cron entry for apticron
GPG_PASS_PHRASE="your passphrase here"
4 * * * * root if test -x /usr/sbin/apticron; then /usr/sbin/apticron --cron; else true; fi
```

## Issues and Contributing
Feel free to open an issue if you have questions or want changes to this version.
