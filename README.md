# Jeon's Personal Nix Flake

(**Deprecated: 2022/11/14**)

## When installing

1. `sudo -i` to format the disk.
1. partition -> format -> mount
1. `nix-shell -p git nixFlakes`
1. **If this is a new machine, default configs can be generated in `/mnt/etc/old.conf.d` by command below.**
    - `nixos-generate-config --root /mnt --dir /etc/old.conf.d`
1. `git clone https://github.com/aatjday/nix.git /mnt/etc/nixos`
1. `nixos-install --impure --root /mnt --flake /mnt/etc/nixos#{hostname}`
1. `umount -lR /mnt`
1. `reboot`

## After the first boot

1. login as `root`
1. `passwd ${YOUR_USER_NAME}`
1. `chown -R ${YOUR_USER_NAME} /etc/nixos`

## Useful aliases

(**inside Nix Git directory**)

1. `up`: `nix flake update .`
1. `ug`: `sudo nixos-rebuild switch --flake ./#`
