use std::collections::HashMap;

// use crate::bridge::api::RustOperation;
// use crate::bridge::api::RustRequest;
// use crate::bridge::api::RustResponse;
// use crate::bridge::api::RustSignal;
// use crate::bridge::send_rust_signal;
use rmp_serde::from_slice;
use rmp_serde::to_vec_named;
use serde::Deserialize;
use serde::Serialize;

use crate::bridge::api::{RustRequest, RustResponse};

pub async fn get_ports(rust_request: RustRequest) -> RustResponse {
    match rust_request.operation {
        RustOperation::Create => RustResponse::default(),
        RustOperation::Read => {
            #[derive(Serialize)]
            struct RustResponseSchema {
                ports:  HashMap<String, String>,
            }

            let mut ports = HashMap::new();
            ports.insert(String::from("RUST COM1"), String::from("Description of RUST COM1"));
            ports.insert(String::from("RUST COM2"), String::from("Description of RUST COM2"));
            RustResponse {
                successful: true,
                bytes: to_vec_named(&RustResponseSchema {
                    ports: ports
                })
                .unwrap(),
            }
        }
        RustOperation::Update => RustResponse::default(),
        RustOperation::Delete => RustResponse::default(),
    }
}
