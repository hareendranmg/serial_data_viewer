//! This module runs the corresponding function
//! when a `RustRequest` was received from Dart
//! and returns `RustResponse`.

use crate::bridge::api::RustRequestUnique;
use crate::bridge::api::RustResponse;
use crate::bridge::api::RustResponseUnique;
use crate::sample_functions;
use crate::serial_communication;

pub async fn handle_request(request_unique: RustRequestUnique) -> RustResponseUnique {
    // Get the request data.
    let rust_request = request_unique.request;
    let interaction_id = request_unique.id;

    // Run the function that corresponds to the address.
    let layered: Vec<&str> = rust_request.address.split('.').collect();
    let rust_response = if layered.is_empty() {
        RustResponse::default()
    }  else if layered[0] == "serial" {
         if layered[1] == "getPorts" {
            // sample_functions::get_ports(rust_request).await;
            serial_communication::get_ports(rust_request).await;
        } else {
            RustResponse::default()
        }
    } else {
        RustResponse::default()
    };

    // Return the response.
    RustResponseUnique {
        id: interaction_id,
        response: rust_response,
    }
}
