Installation d'Arch Linux
=========================

Écrit le 14 juin 2020.

### A. Conventions

Plus bas, le texte <code><b><span style="color: #c00000">en rouge</span></b></code>
correspond à des paquets Arch, à installer avec la commande

<pre><code><b><span style="color: #0000a0">sudo pacman -S <i>nompaquet</i></span></b></code></pre>

Les commandes sont affichées
<code><b><span style="color: #0000a0">en bleu</span></b></code>.

### B. Arch pré-installation

#### 1. Démarrage du réseau Wifi

Il faut créer un fichier dans */etc/netctl* avec un nom de connexion, y écrire
les informations nécessaires (SSID, mot de passe, etc.) et ensuite exécuter :

<pre><code><b><span style="color: #0000a0"><b>netctl start <i>nomconnexion</i></span></b></b></code></pre>

Pour ne pas tout réinventer, le plus simple est de recopier un fichier se
trouvant dans */etc/netctl/examples*.

Pour mon Wifi je prends le fichier */etc/netctl/examples/wireless-wpa*.

J'ai été confronté à deux soucis :

  1. Au démarrage avec le CD d'installation (archiso), l'interface réseau Wifi
     est dans un état 'pseudo-up' (interface montée, mais aucun lien établi et
     pas de réseau disponible). Pour que le réseau puisse être démarré sans
     erreur, il faut au préalable *descendre* l'interface réseau :

     <pre><code><b><span style="color: #0000a0">ip link show wlan0</span></b>
     # Affiche :
     # ...&lt;<b><span style="color: #ff0000">NO-CARRIER</span></b>,BROADCAST,MULTICAST,<b><span style="color: #ff0000">UP</span></b>&gt;...
     <b><span style="color: #0000a0">ip link set wlan0 down</span></b>
     <b><span style="color: #0000a0">ip link show wlan0</span></b>
     # Affiche :
     # ...<b><span style="color: #00b000">&lt;BROADCAST,MULTICAST&gt;</span></b>...
     </code></pre>

     **IMPORTANT**

     L'état de la carte réseau, *UP* ou *DOWN*, est différent de l'état de la
     *connexion au réseau*, qui elle est *DOWN* tant que le réseau n'a pas
     démarré.

     L'état de la carte apparaît entre le signe inférieur et supérieur (<...>),
     alors que l'état du lien apparaît après le mot-clé *state*.

     Détail des commandes exécutées (pour un profil réseau enregistré comme
     */etc/netctl/principal*) :

     <pre><code>root@archiso ~ # <b><span style="color: #0000a0">netctl start principal</span></b>
     Job for netctl@principal.service failed because the control process exited with error code.
     See "systemctl status netctl@principal.service" and "journalctl -xe" for details.
     root@archiso ~ # <b><span style="color: #0000a0">journalctl -t network -o cat</span></b>
     Starting network profile 'principal'...
     The interface of network profile 'principal' is already up
     root@archiso ~ # <b><span style="color: #0000a0">ip link show wlan0</span></b>
     # Remarquez la carte dans l'état UP alors que le lien est DOWN
     2: wlan0: &lt;NO-CARRIER,BROADCAST,MULTICAST,UP&gt; mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
     link/ether 58:00:e3:86:7e:81 brd ff:ff:ff:ff:ff:ff
     root@archiso ~ # <b><span style="color: #0000a0">ip link set wlan0 down</span></b>
     root@archiso ~ # <b><span style="color: #0000a0">ip link show wlan0</span></b>
     2: wlan0: &lt;BROADCAST,MULTICAST&gt; mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
     link/ether 58:00:e3:86:7e:81 brd ff:ff:ff:ff:ff:ff
     root@archiso ~ # <b><span style="color: #0000a0">netctl start principal</span></b>
     ...
     </code></pre>

  2. L'interface Wifi s'appelle *wlan0* au démarrage du CD d'installation, mais
     une fois le système installé, elle change de nom.

     Cela provient de *systemd* qui exécute (en version installée, pas dans
     archiso) un script de renommage qui applique un standard produisant des
     noms prédictibles en fonction de la carte. Par exemple la carte Wifi de mon
     portable connectée au slot 0 de l'emplacement PCI numéro 2 a pour nom
     *wlp2s0*.

     Plus de détails ici : [Predictable Network Interface Names](https://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames/)

#### 2. Disque principal chiffré

Pour employer la méthode *LVM on LUKS* (c'est celle que j'utilise), aller ici :

[Wiki Arch - dm-crypt/Encrypting an entire system](https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS)

Cette méthode chiffre un seul volume dans lequel sont configurés des *Logical
Volume* LVM.

### C. Arch post-installation

#### 1. Pour rendre le système bootable

   bootctl a besoin du fichier */boot/loader/loader.conf* et d'au moins un
   fichier dans */boot/loader/entries*.

   * [Exemple de fichier /boot/loader/loader.conf](fichiers/loader.conf)
   * [Exemple de fichier /boot/loader/entries/arch.conf](fichiers/arch.conf)

   Dans le fichier *arch.conf*, on voit l'option <code><b>pci=noaer</b></code>,
   destinée à éviter de nombreux messages d'erreur dans la console, sans
   incidence sur le bon fonctionnement du système, mais très désagréables.

   Exécuter (dans le chroot) :

   <pre><code><b><span style="color: #0000a0">bootctl install</span></b></code></pre>

   Vérifier qu'à l'issue de cette commande le fichier
   */boot/EFI/systemd/systemd-bootx64.efi* existe. C'est ce fichier qui doit
   être lancé par UEFI au démarrage du PC.

   Il faut aussi installer (si le disque est organisé avec LVM) :

   <pre><code><b><span style="color: #c00000">lvm2</span></b></code></pre>

#### 2. Le réseau Wifi

<pre><code><b><span style="color: #c00000">netctl
wpa_supplicant
dhcpcd</span></b></code></pre>

   Créer un fichier dans */etc/netctl* pour démarrer le réseau (dans le fichier
   ci-dessous, mettre à jour les lignes *Interface=*, *ESSID=* et *Key=*).

   [Exemple de fichier /etc/netctl/principal pour connexion Wifi WPA](fichiers/principal)

   Pour rappel (cf. début de ce document), ce fichier active le réseau sur
   l'interface *wlp2s0*, alors qu'au démarrage avec archiso, cette même
   interface réseau s'appelle *wlan0*.

#### 3. Le minimum du minimum

<pre><code><b><span style="color: #c00000">vim
man</span></b></code></pre>

#### 4. Élévation de droits

<pre><code><b><span style="color: #c00000">sudo</span></b></code></pre>

   Ensuite, éditer le fichier */etc/sudoers*.

#### 5. GNOME

<pre><code><b><span style="color: #c00000">mesa xf86-video-intel xorg-server xorg-apps
gnome gnome-extra</span></b></code></pre>

   Choisir *jack2* et *5-dejavu*.

   Puis faire démarrer gdm par défaut :

<pre><code><b><span style="color: #0000a0">systemctl enable gdm</span></b></code></pre>

   Pour quelques petits réglages, exécuter ces trois scripts.

   Attention, le troisième ne fonctionne que si
   <code><b><span style="color: #c00000">alacritty</span></b></code> et
   <code><b><span style="color: #c00000">tmux</span></b></code> sont installés.
   Il crée deux raccourcis, **Ctrl-Alt-T** pour un terminal avec une nouvelle
   session tmux, **Ctrl-Alt-U** pour un terminal avec tmux attaché à une session
   existante.

   * [gnome-background.sh](fichiers/gnome-background.sh)
   * [gnome-dont-group-by-application.sh](fichiers/gnome-dont-group-by-application.sh)
   * [gnome-create-keybindings.sh](fichiers/gnome-create-keybindings.sh)

#### 6. KDE

<pre><code><b><span style="color: #c00000">plasma-meta kde-applications-meta</span></b>
# Une fois dans KDE, lancer (Alt+F2) systemsettings et choisir un thème</code></pre>

#### 7. Quelques programmes bien pratiques

<pre><code><b><span style="color: #c00000">alacritty
tree
tmux
firefox
firefox-i18n-fr</span></b></code></pre>

#### 8. yaourt

   D'après [ce lien](https://wiki.archlinux.fr/yaourt#Installation).

<pre><code><b><span style="color: #c00000">base-devel git</span></b></code></pre>

   Puis exécuter :

<pre><code><b><span style="color: #0000a0">git clone https://aur.archlinux.org/package-query.git
cd package-query/
makepkg -si

git clone https://aur.archlinux.org/yaourt.git
cd yaourt/
makepkg -si</span></b></code></pre>

Exemple de paquet que l'on trouve sur l'AUR :

<pre><code><b><span style="color: #c00000">(aur) gnome-shell-extension-dash-to-dock</span></b></code></pre>

#### 9. Signer le noyau après mise à jour pour le Secure Boot

   Tout est expliqué ici :

   [Wiki Arch - Unified Extensible Firmware Interface/Secure Boot](https://wiki.archlinux.org/index.php/Unified_Extensible_Firmware_Interface/Secure_Boot#Signing_the_kernel_with_a_pacman_hook)

#### 10. Configuration de zsh

Mon fichier *~/.zshrc*.

* [Fichier ~/.zshrc](fichiers/.zshrc)
* [Fichier ~/.aliases utilisé par ~/.zshrc](fichiers/.aliases)

#### 11. Monter automatiquement une SDCARD chiffrée au démarrage

La solution consiste à ouvrir le volume avec un fichier au lieu d'un mot de
passe. Avec LUKS, le volume peut aussi avoir un mot de passe (ce qui est mon
cas, la SDCARD servant de volume de sauvegarde, je dois pouvoir l'ouvrir sans le
fichier).

Dans les commandes ci-dessous, le volume chiffré est */dev/mmcblk0p1* et le
fichier est */opt/csdcard/sdcard-keyfile*.

<pre><code># Création du fichier (/dev/random est beaucoup trop long)
<b><span style="color: #0000a0">sudo dd if=/dev/urandom of=/opt/csdcard/sdcard-keyfile bs=1024 count=4 iflag=fullblock status=progress</span></b>
# Ajout du fichier comme clé pouvant ouvrir le volume
<b><span style="color: #0000a0">sudo cryptsetup luksAddKey /dev/mmcblk0p1 /opt/csdcard/sdcard-keyfile</span></b>
# Tester l'ouverture du volume avec le fichier, manuellement
<b><span style="color: #0000a0">sudo cryptsetup open --key-file /opt/csdcard/sdcard-keyfile /dev/mmcblk0p1 csdcard</span></b>
# Lister les volumes chiffrés
<b><span style="color: #0000a0">sudo dmsetup ls</span></b></code></pre>

Une fois le fichier et le volume prêts, pour automatiser, ajouter la ligne
suivante au fichier */etc/crypttab*.

<pre><code><b><span style="color: #000000">csdcard /dev/mmcblk0p1 /opt/csdcard/sdcard-keyfile luks</span></b></code></pre>

Pour trouver l'UUID du volume, deux possibilités.

<pre><code><b># Méthode 1</b>

# Déterminer le device du volume chiffré (du type /dev/dm-1, /dev/dm-2, etc.)
<b><span style="color: #0000a0">ls -l /dev/mapper</span></b>
total 0
lrwxrwxrwx 1 root root       7 14 juin  14:33 clvm -> ../dm-0
crw------- 1 root root 10, 236 14 juin  14:33 control
lrwxrwxrwx 1 root root       7 14 juin  14:33 <b><span style="color: #00b000">csdcard -> ../dm-3</span></b>
lrwxrwxrwx 1 root root       7 14 juin  14:33 vol-rootfs -> ../dm-2
lrwxrwxrwx 1 root root       7 14 juin  14:33 vol-swap -> ../dm-1
<b><span style="color: #0000a0">ls -l /dev/disk/by-uuid</span></b>
total 0
lrwxrwxrwx 1 root root 10 14 juin  15:45 82E6-1188 -> ../../sda1
lrwxrwxrwx 1 root root 15 14 juin  14:33 95F8-7F02 -> ../../nvme0n1p1
lrwxrwxrwx 1 root root 15 14 juin  14:33 a4f4fc21-e8b1-4c33-8c59-95cb5fcd389d -> ../../mmcblk0p1
lrwxrwxrwx 1 root root 10 14 juin  14:33 <b><span style="color: #00b000">ae1163db-d091-434a-98db-bf19dc41e4bf -> ../../dm-3</span></b>
lrwxrwxrwx 1 root root 15 14 juin  14:33 b05b16c3-b474-4963-ba60-38068650386b -> ../../mmcblk0p2
lrwxrwxrwx 1 root root 15 14 juin  14:33 b66e34ac-580e-4a82-8dd0-96ee8b0e3eee -> ../../mmcblk0p3
lrwxrwxrwx 1 root root 10 14 juin  14:33 bfa09ce7-a424-40b1-88cf-973c56b6d213 -> ../../dm-1
lrwxrwxrwx 1 root root 15 14 juin  14:33 C8289BE0289BCC36 -> ../../nvme0n1p4
lrwxrwxrwx 1 root root 10 14 juin  14:33 f463b09c-3d05-48d7-bdd1-99637d2aab51 -> ../../dm-2
lrwxrwxrwx 1 root root 15 14 juin  14:33 f73ca4cc-150b-400f-9a84-36a6614154a4 -> ../../nvme0n1p2
lrwxrwxrwx 1 root root 15 14 juin  14:33 f78dd388-8819-46f6-afd3-af8faf476752 -> ../../mmcblk0p5

<b># Méthode 2</b>

<b><span style="color: #0000a0">lsblk -o NAME,UUID</span></b>
NAME             UUID
sda
└─sda1           82E6-1188
mmcblk0
├─mmcblk0p1      a4f4fc21-e8b1-4c33-8c59-95cb5fcd389d
<b><span style="color: #00b000">│ └─csdcard      ae1163db-d091-434a-98db-bf19dc41e4bf</span></b>
├─mmcblk0p2      b05b16c3-b474-4963-ba60-38068650386b
├─mmcblk0p3      b66e34ac-580e-4a82-8dd0-96ee8b0e3eee
└─mmcblk0p5      f78dd388-8819-46f6-afd3-af8faf476752
nvme0n1
├─nvme0n1p1      95F8-7F02
├─nvme0n1p2      f73ca4cc-150b-400f-9a84-36a6614154a4
│ └─clvm         IT4sOX-X5jZ-q4j3-duuZ-MOHG-fUWp-OQ1XR4
│   ├─vol-swap   bfa09ce7-a424-40b1-88cf-973c56b6d213
│   └─vol-rootfs f463b09c-3d05-48d7-bdd1-99637d2aab51
├─nvme0n1p3
└─nvme0n1p4      C8289BE0289BCC36</code></pre>

Une fois l'UUID du volume déterminé, ajouter une ligne à */etc/fstab* :

<pre><code><b><span style="color: #000000">UUID=ae1163db-d091-434a-98db-bf19dc41e4bf /mnt/csdcard ext4   rw,nosuid,nodev,noatime,users   0 0</span></b></code></pre>

En fait il est plus simple dans un tel cas de désigner le volume par son chemin,
ici */dev/mapper/csdcard*. L'idée avec les UUID est de ne pas dépendre du nom de
device du volume, qui peut changer pour une clé USB par exemple (*/dev/sda*,
*/dev/sdb*, etc.) Mais ici cela n'arrivera jamais.

* [Fichier /etc/fstab](fichiers/fstab)
* [Fichier /etc/crypttab](fichiers/crypttab)

#### 11. Autres

<pre><code><b><span style="color: #c00000">linux-lts
pacman-contrib
gvim
linux-headers
linux-lts-headers</span></b></code></pre>

<pre><code><b><span style="color: #c00000">zsh
shellcheck
efitools
sbsigntool
fzf
the_silver_searcher
gnu-efi
cpanminus
pandoc
tldr</span></b></code></pre>

*tldr* doit d'abord être mis à jour, en français (quelques contributions sont
disponibles) mais surtout en anglais. Exécuter après installation :

<pre><code><b><span style="color: #0000a0">tldr -u
LANG='' tldr -u</span></b></code></pre>

#### 12. Configuration de gvim/vim

* [Fichier ~/.vimrc](fichiers/.vimrc)
* [Archive de la configuration intégrale](fichiers/vimconfig.tar.gz)

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

<!--- vim: tw=80:ts=3:sw=3:et
-->

