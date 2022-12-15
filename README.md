# rust-kmod-dev

This repo exists for experimenting with the Rust framework that was introduced into the Linux kernel.

## Dependencies

* podman/docker
* make
* tar
* curl

## Development

1. Fetch kernel sources

First, fetch the Linux kernel source code

```
$ make fetch-source
```

2. Build the buildsystem

Next, build the builder image and verify that it was configured correctly:

```
$ make build-container
$ make build-rustavailable
```

3. Configure the Linux kernel

Enable Rust support as specified in the [Linux kernel documentation](https://www.kernel.org/doc/html/v6.1/rust/quick-start.html#configuration):

```
$ make menuconfig
```

4. Build the Linux kernel

Now build the Linux kernel. There will likely be a few interactive prompts for enabling additional features on the first run:

```
$ make build-kernel
```

5. Build the kernel module

Finally, build the kernel module:

```
$ make build-kmod
```
