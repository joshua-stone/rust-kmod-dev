// SPDX-License-Identifier: GPL-2.0

//! Hello World kernel module.

use kernel::prelude::*;
use kernel::{str::CStr, ThisModule};

module! {
    type: HelloWorld,
    name: "kmodhello",
    author: "Joshua Stone",
    description: "Hello World kernel module",
    license: "GPL",
}

struct HelloWorld;

impl kernel::Module for HelloWorld {
    fn init(_name: &'static CStr, _module: &'static ThisModule) -> Result<Self> {
        pr_info!("Hello World!\n");
        Ok(HelloWorld)
    }
}

impl Drop for HelloWorld {
    fn drop(&mut self) {
        pr_info!("Goodbye World!\n");
    }
}
