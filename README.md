# ekko

Lead maintainer: [Buğra Ekuklu](Chatatata)

Automates the deployment process of your Helm releases.

## Installation

##### macOS

```sh
$ brew install ekko
```

##### Linux (CentOS, Debian, Fedora etc.)

Download the tarball from the [releases page](https://github.com/Chatatata/ekko/releases).

> Unfortunately, Linux support is experimental at the moment.

## Initializing a new project

To create a new Ekko project, issue the initialization command to bootstrap
a directory with Ekko files and folders using `ekko(1)`.

```sh
$ ekko init k8s-manifests
```

## Managing your releases

After adding your solutions, you can install/delete the related Helm releases
by using CLI.

```sh
$ ekko install                  # install all solutions
$ ekko purge postgresql         # remove PostgreSQL
$ ekko purge                    # remove all solutions
```

To learn more of publishing Ekko configurations for your Helm releases, read the Wiki.

## License

MIT
