# encrypted-apticron
This version replaces the original [`apticron`](https://tracker.debian.org/pkg/apticron). It's purpose is to encrypt the outgoing emails using [`gpg`](https://www.gnupg.org/) before sending them. Forked from `git://git.debian.org/git/collab-maint/apticron.git`.

**On the origin of the idea for this project:** Intercepting emails send by `apticron` would possibly provide very valuable information for an attacker of a system.
Since she/he would then know which packages on that system do need a (security) update.

## How to install

It is recommended that you first install the `apticron` version provided by your distribution.
This will initially prompt you to configure `apticron` like you need it.
**Afterwards** use the `./install` script of this repository to replace the original `apticron` version with this one.

## How it works

This version automatically will identify the public key to be used for encrypting by the email address given in the standard `apticron.conf`. The root user of your system needs to know that public key, if `apticron` is executed by the system (as usual).

## State of the debian package

And official debian feature/bug request was initiated for this feature to be included. You can see it's state [here](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=877894).

## Issues and Contributing

Feel free to open an issue if you have questions or want changes to this version.

## Copyright

`apticron` and `apticron.conf` are based on the [debian source](git://git.debian.org/git/collab-maint/apticron.git) of the respective files.
Therefore the original debian `./COPYRIGHT` file is included in this project. All other files a written by the author and are licensed under the
GPL License (see `./LICENSE`).
