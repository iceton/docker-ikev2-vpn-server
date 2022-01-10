# IKEv2 VPN server Docker container/image

- Automatic, configurable credentials
- Easy mobileconfig generation

## Usage

### 1. Build the container

    > git clone https://github.com/iceton/docker-ikev2-vpn-server.git
    > docker build -t ikev2-vpn docker-ikev2-vpn-server/

### 2. Start the IKEv2 VPN Server

    > docker run --privileged -d --name ikev2-vpn-server --restart=always -p 500:500/udp -p 4500:4500/udp ikev2-vpn

Or to specify your own pre-shared key, use the `VPN_PSK` environment variable (>=32 characters please) like this:

    > docker run --privileged -d --name ikev2-vpn-server --restart=always -p 500:500/udp -p 4500:4500/udp -e VPN_PSK=09F911029D74E35BD84156C5635688C1 ikev2-vpn

### 3. View credentials / .mobileconfig

#### View the credentials to connect

    > docker run --privileged -i -t --rm --volumes-from ikev2-vpn-server -e ikev2-vpn echo-config

    VPN public IP: 83.244.233.55
    IKEv2 pre-shared key: 09F911029D74E35BD84156C5635688C1
    IKEv2 username: (none, leave blank)
    IKEv2 password: (none, leave blank)

#### Or generate a .mobileconfig for use with iOS and macOS

    > docker run --privileged -i -t --rm --volumes-from ikev2-vpn-server -e VPN_HOST=mysweetvpn.com ikev2-vpn generate-mobileconfig > ikev2-vpn.mobileconfig

Transfer the generated `ikev2-vpn.mobileconfig` file to your local computer and install:

- iOS: AirDrop the file to your iOS device and install the profile.

- macOS: Double click the file to start the profile installation.

## Technical Details

Forked from https://github.com/gaomd/docker-ikev2-vpn-server.

Container based on Debian 11, OpenSSL, strongSwan

When the container is created, a shared secret is generated for authentication. No certificate, username, or password is required.

## License

Copyright (c) 2016 Mengdi Gao, This software is licensed under the [MIT License](LICENSE).

---

\* IKEv2 protocol requires iOS 8 or later, macOS 10.11 El Capitan or later.

\* Install for **iOS 8 or later** or when your AirDrop fails: Send an E-mail to your iOS device with the `.mobileconfig` file as attachment, then tap the attachment to bring up and finish the **Install Profile** screen.
